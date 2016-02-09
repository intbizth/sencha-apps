<?php

namespace AppBundle\OAuth;

use AppBundle\Security\User;
use GuzzleHttp\HandlerStack;
use GuzzleHttp\Middleware;
use League\OAuth2\Client\Provider\GenericProvider;
use League\OAuth2\Client\Token\AccessToken;
use Psr\Http\Message\RequestInterface;
use Psr\Http\Message\ResponseInterface;
use Symfony\Component\Security\Core\Authentication\Token\Storage\TokenStorageInterface;

class OAuth2HandlerStack
{
    /**
     * @var HandlerStack
     */
    protected $handlerStack;

    /**
     * @var GenericProvider
     */
    protected $provider;

    /**
     * @var TokenStorageInterface
     */
    private $tokenStorage;

    public function __construct(HandlerStack $handlerStack, GenericProvider $provider, TokenStorageInterface $tokenStorage)
    {
        $this->handlerStack = $handlerStack;
        $this->provider = $provider;
        $this->tokenStorage = $tokenStorage;
    }

    /**
     * Set the middleware handlers for all requests using Oauth2
     *
     * @return HandlerStack|null
     */
    public function pushHandlers()
    {
        // Add the Authorization header to requests.
        $this->handlerStack->push(Middleware::mapRequest(function (RequestInterface $request) {
            if (in_array('oauth2', $request->getHeader('auth'))) {
                $token = $this->getAccessToken();

                if ($token !== null) {
                    // return new request
                    return $request->withHeader('Authorization', 'Bearer ' . $token->getToken());
                }
            }

            return $request;
        }), 'add_oauth_header');

        $this->handlerStack->before('add_oauth_header', $this->retryModifyRequest(function ($retries, RequestInterface $request, ResponseInterface $response = null, $error = null){
            if ($retries > 0) {
                return false;
            }

            if($response instanceof ResponseInterface) {
                if ($response->getStatusCode() === 401) {
                    return true;
                }
            }

            return false;
        },
            function(RequestInterface $request, ResponseInterface $response){
                if ($response instanceof ResponseInterface) {
                    if ($response->getStatusCode() === 401) {
                        $token = $this->refreshAccessToken();
                        $modify['set_headers']['Authorization'] = 'Bearer ' . $token->getToken();
                        $request = \GuzzleHttp\Psr7\modify_request($request, $modify);
                    }
                }

                return $request;
            }
        ));
    }

    /**
     * Retry Call after updating access token
     */
    function retryModifyRequest(callable $decider, callable $requestModifier, callable $delay = null)
    {
        return function (callable $handler) use ($decider, $requestModifier,  $delay) {
            return new RetryModifyRequestMiddleware($decider, $requestModifier, $handler, $delay);
        };
    }

    /**
     * Get a new access token.
     *
     * @return AccessToken
     */
    protected function refreshAccessToken()
    {
        return $this->provider->getAccessToken('refresh_token', array(
            'refresh_token' => $this->getAccessToken() ? $this->getAccessToken()->getRefreshToken() : null
        ));
    }

    /**
     * Get the access token.
     *
     * @return AccessToken|null Oauth2 access token
     */
    public function getAccessToken()
    {
        /** @var User $user */
        if (!$user = $this->tokenStorage->getToken()->getUser()) {
            return null;
        }

        $accessToken = $user->getAccessToken();

        if ($accessToken->hasExpired()) {
            // Try to acquire a new access token from the server.
            $accessToken = $this->refreshAccessToken();
        }

        return $accessToken;
    }
}
