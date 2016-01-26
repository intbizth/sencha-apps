<?php

namespace AppBundle\Security;

use Doctrine\DBAL\Connection;
use Symfony\Component\Security\Core\User\UserProviderInterface;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Security\Core\Exception\UsernameNotFoundException;
use Symfony\Component\Security\Core\Exception\UnsupportedUserException;

class UserProvider implements UserProviderInterface
{
    /**
     * @var Connection
     */
    private $connection;

    public function __construct(Connection $connection)
    {
        $this->connection = $connection;
    }

    /**
     * @param $username
     *
     * @return array|false
     */
    private function getUserData($username)
    {
        return $this->connection->createQueryBuilder()
            ->select('*')
            ->from('sylius_user', 'u')
            //->where('u.enabled = :enabled')
            //->andWhere('u.locked = :locked')
            ->andWhere('u.username = :username')
            //->setParameter('enabled', true)
            //->setParameter('locked', false)
            ->setParameter('username', $username)
            ->execute()
            ->fetch()
        ;
    }

    public function loadUserByUsername($username)
    {
        // pretend it returns an array on success, false if there is no user
        if ($userData = $this->getUserData($username)) {
            return new User($userData['username'], $userData['password'], $userData['salt'], unserialize($userData['roles']));
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
