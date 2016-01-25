<?php

namespace AppBundle\OAuth;

use CommerceGuys\Guzzle\Oauth2\GrantType\PasswordCredentials;

class PasswordCredentialsGrantType extends PasswordCredentials
{
    use RuntimeCredentialTrait;
}
