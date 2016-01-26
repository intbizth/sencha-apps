<?php

namespace AppBundle\Compiler;

use Symfony\Component\DependencyInjection\Compiler\CompilerPassInterface;
use Symfony\Component\DependencyInjection\ContainerBuilder;

class SecurityAuthenSuccessHandler implements CompilerPassInterface
{
    public function process(ContainerBuilder $container)
    {
        $container->getDefinition('security.authentication.success_handler')
            ->setClass('AppBundle\Security\AuthenticationSuccessHandler')
            ->addMethodCall(
                'setPasswordCredentialsGrantType',
                array($container->getDefinition('app.oauth2.grant_type.password_credentials'))
            )
        ;
    }
}
