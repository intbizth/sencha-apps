<?php

namespace AppBundle\OAuth;

use CommerceGuys\Guzzle\Oauth2\GrantType\PasswordCredentials;
use Symfony\Component\Security\Core\Authentication\Token\Storage\TokenStorageInterface;

class PasswordCredentialsGrantType extends PasswordCredentials
{
    /**
     * @var TokenStorageInterface
     */
    protected $tokenStorage;

    /**
     * @param TokenStorageInterface $tokenStorage
     */
    public function setTokenStorage(TokenStorageInterface $tokenStorage)
    {
        $this->tokenStorage = $tokenStorage;
    }

    /**
     * {@inheritdoc}
     */
    public function getToken()
    {
        if (!$token = $this->tokenStorage->getToken()) {
            return parent::getToken();
        }

        $username = $token->getUsername();
        $password = $token->getCredentials();

        if ($password) {
            $this->config->set('username', $username);
            $this->config->set('password', $password);

            $token->eraseCredentials();
        }

        $user = $token->getUser();
        $token = parent::getToken();

        $user->setAccessToken($token->getToken());
        $user->setRefreshToken($token->getRefreshToken()->getToken());

        return $token;
    }
}
