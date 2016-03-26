<?php

namespace AppBundle\OAuth;

use AppBundle\Security\User;
use GuzzleHttp\Client as GuzzleClient;
use GuzzleHttp\HandlerStack;
use League\OAuth2\Client\Provider\GenericProvider;
use League\OAuth2\Client\Token\AccessToken;
use Psr\Http\Message\ResponseInterface;
use Somoza\Psr7\OAuth2Middleware\Bearer;
use Symfony\Component\Security\Core\Authentication\Token\Storage\TokenStorageInterface;

class Client
{
    /**
     * @var string
     */
    private $baseUrl;

    /**
     * @var GuzzleClient
     */
    private $httpClient;

    /**
     * @var HandlerStack
     */
    private $handlerStack;

    /**
     * @var GenericProvider
     */
    private $oauth2Provider;

    /**
     * @var TokenStorageInterface
     */
    private $tokenStorage;

    /**
     * @var string
     */
    private $prefix;

    public function __construct(
        GuzzleClient $httpClient,
        HandlerStack $handlerStack,
        GenericProvider $oauth2Provider,
        TokenStorageInterface $tokenStorage,
        $prefix = 'api'
    ) {
        $this->httpClient = $httpClient;
        $this->handlerStack = $handlerStack;
        $this->prefix = $prefix;
        $this->tokenStorage = $tokenStorage;
        $this->baseUrl = $httpClient->getConfig('base_uri');

        $this->oauth2Provider = $oauth2Provider->setHttpClient($httpClient);

        $this->initOauth2Middleware();
    }

    /**
     * @return User|null
     */
    private function getUser()
    {
        return $this->tokenStorage->getToken()
            ? $this->tokenStorage->getToken()->getUser()
            : null
        ;
    }

    /**
     * @return AccessToken|null
     */
    private function getUserAccessToken()
    {
        return $this->getUser()
            ? $this->getUser()->getAccessToken()
            : null
        ;
    }

    protected function initOauth2Middleware()
    {
        $oauth2Middleware = new Bearer(
            $this->oauth2Provider,
            $this->getUserAccessToken(),
            function(AccessToken $accessToken) {
                if ($user = $this->getUser()) {
                    $user->setAccessToken($accessToken);
                    $this->tokenStorage->getToken()->setUser($user);
                }
            }
        );

        $this->handlerStack->push($oauth2Middleware);
    }

    /**
     * @param $path
     *
     * @return string
     */
    private function buildUri($path)
    {
        return sprintf('%s/%s', $this->prefix, $path);
    }

    /**
     * @param $url
     * @param array $queryParameters
     * @param array $options
     *
     * @return Response
     */
    public function get($url, array $queryParameters = [], array $options = [])
    {
        return $this->parseResponse(
            $this->httpClient->get(
                $this->buildUri($url),
                array_merge($this->applyOptions($options), ['query' => $queryParameters])
            )
        );
    }

    /**
     * @param $url
     * @param array $body
     * @param array $options
     *
     * @return Response
     */
    public function patch($url, array $body = [], array $options = [])
    {
        return $this->parseResponse(
            $this->httpClient->patch(
                $this->buildUri($url),
                array_merge($this->applyOptions($options), ['json' => $body])
            )
        );
    }

    /**
     * @param $url
     * @param array $body
     * @param array $options
     *
     * @return Response
     */
    public function put($url, array $body = [], array  $options = [])
    {
        return $this->parseResponse(
            $this->httpClient->put(
                $this->buildUri($url),
                array_merge($this->applyOptions($options), ['json' => $body])
            )
        );
    }

    /**
     * @param $url
     *
     * @return Response
     */
    public function delete($url)
    {
        return $this->parseResponse(
            $this->httpClient->delete($this->buildUri($url))
        );
    }

    /**
     * @param $url
     * @param $body
     * @param array $options
     *
     * @return Response
     */
    public function post($url, $body, array $options = array())
    {
        return $this->parseResponse(
            $this->httpClient->post(
                $this->buildUri($url),
                array_merge($this->applyOptions($options), ['json' => $body])
            )
        );
    }

    /**
     * {@inheritdoc }
     */
    public function getSchemeAndHost()
    {
        return sprintf('%s://%s', $this->baseUrl->getScheme(), $this->baseUrl->getHost());
    }

    /**
     * @param ResponseInterface $response
     *
     * @return Response
     */
    protected function parseResponse(ResponseInterface $response)
    {
        return new Response($response);
    }

    /**
     * @param array $options
     *
     * @return array
     */
    private function applyOptions(array $options = [])
    {
        if (array_key_exists('headers', $options)) {
            $defaults = (array)$this->httpClient->getConfig('headers');

            foreach ($options['headers'] as $key => &$value) {
                $value = sprintf('%s; %s', $defaults[$key], $value);
            }
        }

        return $options;
    }
}
