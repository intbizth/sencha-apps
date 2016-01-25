<?php

namespace AppBundle\OAuth;

use CommerceGuys\Guzzle\Oauth2\GrantType\RefreshToken;

class RefreshTokenGrantType extends RefreshToken
{
    use RuntimeCredentialTrait;
}
