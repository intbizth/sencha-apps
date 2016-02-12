<?php

namespace AppBundle\Security;

use League\OAuth2\Client\Token\AccessToken;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Security\Core\User\EquatableInterface;

class User implements UserInterface, EquatableInterface
{
    /**
     * @var string
     */
    protected $username;

    /**
     * @var AccessToken
     */
    protected $accessToken;

    /**
     * @var array
     */
    protected $roles = array();

    /**
     * User constructor.
     *
     * @param string $username
     * @param array $roles
     * @param AccessToken $accessToken
     */
    public function __construct($username, array $roles, AccessToken $accessToken)
    {
        $this->username = $username;
        $this->roles = $roles;
        $this->accessToken = $accessToken;
    }

    /**
     * {@inheritdoc}
     */
    public function getRoles()
    {
        return $this->roles;
    }

    /**
     * {@inheritdoc}
     */
    public function getUsername()
    {
        return $this->username;
    }

    /**
     * {@inheritdoc}
     */
    public function eraseCredentials()
    {
    }

    /**
     * {@inheritdoc}
     */
    public function isEqualTo(UserInterface $user)
    {
        return true;
    }

    /**
     * {@inheritdoc}
     */
    public function getPassword()
    {
        return;
    }

    /**
     * {@inheritdoc}
     */
    public function getSalt()
    {
        return;
    }

    /**
     * @return AccessToken
     */
    public function getAccessToken()
    {
        return $this->accessToken;
    }

    /**
     * @param AccessToken $accessToken
     */
    public function setAccessToken(AccessToken $accessToken)
    {
        $this->accessToken = $accessToken;
    }
}
