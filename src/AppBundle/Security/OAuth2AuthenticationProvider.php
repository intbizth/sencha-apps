<?php

namespace AppBundle\Security;

use League\OAuth2\Client\Provider\Exception\IdentityProviderException;
use League\OAuth2\Client\Provider\GenericProvider;
use Symfony\Component\Security\Core\Authentication\Provider\UserAuthenticationProvider;
use Symfony\Component\Security\Core\Authentication\Token\UsernamePasswordToken;
use Symfony\Component\Security\Core\Encoder\EncoderFactoryInterface;
use Symfony\Component\Security\Core\Exception\AuthenticationServiceException;
use Symfony\Component\Security\Core\User\UserCheckerInterface;
use Symfony\Component\Security\Core\User\UserInterface;
use Symfony\Component\Security\Core\User\UserProviderInterface;

class OAuth2AuthenticationProvider extends UserAuthenticationProvider
{
    /**
     * @var EncoderFactoryInterface
     */
    private $encoderFactory;

    /**
     * @var UserProviderInterface
     */
    private $userProvider;

    /**
     * @var GenericProvider
     */
    private $apiProvider;

    /**
     * Constructor.
     *
     * @param UserProviderInterface   $userProvider               An UserProviderInterface instance
     * @param UserCheckerInterface    $userChecker                An UserCheckerInterface instance
     * @param string                  $providerKey                The provider key
     * @param EncoderFactoryInterface $encoderFactory             An EncoderFactoryInterface instance
     * @param bool                    $hideUserNotFoundExceptions Whether to hide user not found exception or not
     */
    public function __construct(UserProviderInterface $userProvider, UserCheckerInterface $userChecker, $providerKey, EncoderFactoryInterface $encoderFactory, $hideUserNotFoundExceptions = true)
    {
        parent::__construct($userChecker, $providerKey, $hideUserNotFoundExceptions);

        $this->encoderFactory = $encoderFactory;
        $this->userProvider = $userProvider;
    }

    /**
     * @param GenericProvider $apiProvider
     */
    public function setApiProvider(GenericProvider $apiProvider)
    {
        $this->apiProvider = $apiProvider;
    }

    /**
     * {@inheritdoc}
     */
    protected function checkAuthentication(UserInterface $user, UsernamePasswordToken $token)
    {
        // nothing to do here.
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
            dump($e);
            if (is_array($message = $e->getResponseBody())) {
                $message = $message['error_description'];
            }

            $e = new AuthenticationServiceException($message, 0, $e);
            $e->setToken($token);
            throw $e;
        } catch (\Exception $e) {
            dump($e);
            $e = new AuthenticationServiceException($e->getMessage(), 0, $e);
            $e->setToken($token);
            throw $e;
        }
    }
}
