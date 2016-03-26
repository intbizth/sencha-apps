<?php

namespace AppBundle\DependencyInjection\Compiler;

use AppBundle\Security\OAuth2AuthenticationProvider;
use Symfony\Component\DependencyInjection\Compiler\CompilerPassInterface;
use Symfony\Component\DependencyInjection\ContainerBuilder;
use Symfony\Component\DependencyInjection\Reference;

class DaoAuthenticationProviderPass implements CompilerPassInterface
{
    public function process(ContainerBuilder $container)
    {
        $container->getDefinition('security.authentication.provider.dao')
            ->setClass(OAuth2AuthenticationProvider::class)
            ->addMethodCall('setApiProvider', [new Reference('oauth2.provider')])
        ;
    }
}
