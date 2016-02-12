<?php

namespace AppBundle\Security;

use League\OAuth2\Client\Provider\GenericProvider;
use League\OAuth2\Client\Token\AccessToken;
use Symfony\Component\Security\Core\User\UserProviderInterface;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Security\Core\Exception\UsernameNotFoundException;
use Symfony\Component\Security\Core\Exception\UnsupportedUserException;

class UserProvider implements UserProviderInterface
{
    /**
     * @var GenericProvider
     */
    private $provider;

    public function __construct(GenericProvider $provider)
    {
        $this->provider = $provider;
    }

    public function loadUserByUsername($username)
    {
        /** @var AccessToken $token */
        $accessToken = unserialize($username);

        if ($userData = $this->provider->getResourceOwner($accessToken)->toArray()) {
            return new User(
                $userData['username'],
                $userData['roles'],
                $accessToken
            );
        }

        throw new UsernameNotFoundException(
            sprintf('Username "%s" does not exist.', $username)
        );
    }

    public function refreshUser(UserInterface $user)
    {
        if (!$user instanceof User) {
            throw new UnsupportedUserException(
                sprintf('Instances of "%s" are not supported.', get_class($user))
            );
        }

        return $user; //$this->loadUserByUsername($user->getUsername());
    }

    public function supportsClass($class)
    {
        return $class === User::class;
    }
}
