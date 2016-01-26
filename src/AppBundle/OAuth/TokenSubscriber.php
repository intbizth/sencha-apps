<?php

namespace AppBundle\OAuth;

use AppBundle\Security\User;
use CommerceGuys\Guzzle\Oauth2\Oauth2Subscriber;
use GuzzleHttp\Event\RequestEvents;
use GuzzleHttp\Event\SubscriberInterface;
use Symfony\Component\Security\Core\Authentication\Token\Storage\TokenStorageInterface;

class TokenSubscriber implements SubscriberInterface
{
    /**
     * @var TokenStorageInterface
     */
    protected $tokenStorage;

    /**
     * @var Oauth2Subscriber
     */
    protected $oauth2Subscriber;

    public function __construct(TokenStorageInterface $tokenStorage, Oauth2Subscriber $oauth2Subscriber)
    {
        $this->tokenStorage = $tokenStorage;
        $this->oauth2Subscriber = $oauth2Subscriber;
    }

    /**
     * {@inheritdoc}
     */
    public function getEvents()
    {
        return [
            'before' => ['onBefore', RequestEvents::SIGN_REQUEST + 1],
        ];
    }

    public function onBefore()
    {
        if (!$token = $this->tokenStorage->getToken()) {
            return;
        }

        /** @var User $user */
        $user = $token->getUser();
        $this->oauth2Subscriber->setAccessToken($user->getAccessToken());
        $this->oauth2Subscriber->setRefreshToken($user->getRefreshToken());
    }
}
