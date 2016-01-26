<?php

namespace AppBundle\OAuth;


use CommerceGuys\Guzzle\Oauth2\GrantType\RefreshToken;
use Symfony\Component\Security\Core\Authentication\Token\Storage\TokenStorageInterface;

class RefreshTokenGrantType extends RefreshToken
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
        $user = $this->tokenStorage->getToken()->getUser();
        $token = parent::getToken();

        $user->setAccessToken($token->getToken());
        $user->setRefreshToken($token->getRefreshToken()->getToken());

        return $token;
    }
}
