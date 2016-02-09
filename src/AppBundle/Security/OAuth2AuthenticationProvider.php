<?php

namespace AppBundle\Security;

use League\OAuth2\Client\Provider\Exception\IdentityProviderException;
use League\OAuth2\Client\Provider\GenericProvider;
use Symfony\Component\Security\Core\Authentication\Provider\DaoAuthenticationProvider;
use Symfony\Component\Security\Core\Authentication\Token\UsernamePasswordToken;
use Symfony\Component\Security\Core\Exception\AuthenticationServiceException;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Security\Core\User\UserProviderInterface;

class OAuth2AuthenticationProvider extends DaoAuthenticationProvider
{
    /**
     * @var GenericProvider
     */
    protected $apiProvider;

    /**
     * @var UserProviderInterface
     */
    private $userProvider;

    /**
     * @param GenericProvider $apiProvider
     */
    public function setApiProvider(GenericProvider $apiProvider)
    {
        $this->apiProvider = $apiProvider;
    }

    /**
     * @param UserProviderInterface $userProvider
     */
    public function setUserProvider(UserProviderInterface $userProvider)
    {
        $this->userProvider = $userProvider;
    }

    /**
     * {@inheritdoc}
     */
    protected function retrieveUser($username, UsernamePasswordToken $token)
    {
        $user = $token->getUser();

        if ($user instanceof UserInterface) {
            return $user;
        }

        try {
            // Try to get an access token using the resource owner password credentials grant.
            $accessToken = $this->apiProvider->getAccessToken('password', [
                'username' => $token->getUsername(),
                'password' => $token->getCredentials()
            ]);

            $user = $this->userProvider->loadUserByUsername(serialize($accessToken));

            if (!$user instanceof UserInterface) {
                throw new AuthenticationServiceException('The user provider must return a UserInterface object.');
            }

            return $user;

        } catch (IdentityProviderException $e) {
            if (is_array($message = $e->getResponseBody())) {
                $message = $message['error_description'];
            }

            $e = new AuthenticationServiceException($message, 0, $e);
            $e->setToken($token);
            throw $e;
        } catch (\Exception $e) {
            $e = new AuthenticationServiceException($e->getMessage(), 0, $e);
            $e->setToken($token);
            throw $e;
        }
    }
}
