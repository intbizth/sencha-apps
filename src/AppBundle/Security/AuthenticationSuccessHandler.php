<?php

namespace AppBundle\Security;

use AppBundle\OAuth\PasswordCredentialsGrantType;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Http\Authentication\DefaultAuthenticationSuccessHandler;

class AuthenticationSuccessHandler extends DefaultAuthenticationSuccessHandler
{
    /**
     * @var PasswordCredentialsGrantType
     */
    protected $passwordCredentialsGrantType;

    /**
     * @param PasswordCredentialsGrantType $passwordCredentialsGrantType
     */
    public function setPasswordCredentialsGrantType(PasswordCredentialsGrantType $passwordCredentialsGrantType)
    {
        $this->passwordCredentialsGrantType = $passwordCredentialsGrantType;
    }

    /**
     * {@inheritdoc}
     */
    public function onAuthenticationSuccess(Request $request, TokenInterface $token)
    {
        $this->passwordCredentialsGrantType->getToken();

        return $this->httpUtils->createRedirectResponse($request, $this->determineTargetUrl($request));
    }
}
