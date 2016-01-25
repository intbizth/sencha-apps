<?php

namespace AppBundle\OAuth;

use GuzzleHttp\Collection;

/**
 * @author liverbool <phaiboon@intbizth.com>
 */

/**
 * @property Collection $config
 */
trait RuntimeCredentialTrait
{
    /**
     * @param string $username
     * @param string $password
     */
    public function setCredential($username, $password)
    {
        $this->config->set('username', $username);
        $this->config->set('password', $password);
    }
}
