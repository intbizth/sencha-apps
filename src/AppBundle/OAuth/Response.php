<?php

namespace AppBundle\OAuth;

use Psr\Http\Message\ResponseInterface;

class Response
{
    /**
     * @var ResponseInterface
     */
    protected $response;

    public function __construct(ResponseInterface $response)
    {
        $this->response = $response;
    }

    public function getStatusCode()
    {
        return $this->response->getStatusCode();
    }

    public function getStatusText()
    {
        return $this->response->getReasonPhrase();
    }

    public function isStatus($codes)
    {
        $codes = (array) $codes;

        return in_array($this->response->getStatusCode(), $codes);
    }

    public function getRawContents()
    {
        return $this->response->getBody()->getContents();
    }

    public function toXml()
    {
        return array();
    }

    public function toArray()
    {
        return json_decode($this->response->getBody()->getContents(), true);
    }

    /**
     * @return array|mixed|string
     */
    public function getContent()
    {
        if ($this->isXml()) {
            return $this->toXml();
        }

        return $this->toArray();
    }

    public function isJson()
    {
        return in_array('application/json', $this->response->getHeader('content-type'));
    }

    public function isXml()
    {
        return in_array('application/xml', $this->response->getHeader('content-type'));
    }
}
