<?php

namespace AppBundle\OAuth;

use GuzzleHttp\Client as GuzzleClient;
use Psr\Http\Message\ResponseInterface;

class Client
{
    /**
     * @var string $baseUrl
     */
    private $baseUrl;

    /**
     * @var GuzzleClient $httpClient
     */
    private $httpClient;

    /**
     * @var string
     */
    private $prefix;

    public function __construct(GuzzleClient $httpClient, OAuth2HandlerStack $auth2HandlerStack, $prefix = 'api')
    {
        $this->httpClient = $httpClient;
        $this->prefix = $prefix;
        $this->baseUrl = $httpClient->getConfig('base_uri');

        $auth2HandlerStack->pushHandlers();
    }

    /**
     * @param $path
     *
     * @return string
     */
    private function buildUri($path)
    {
        return sprintf('%s/%s', $this->prefix, $path);
    }

    /**
     * @param $url
     * @param array $queryParameters
     *
     * @return Response
     */
    public function get($url, array $queryParameters = [])
    {
        return $this->parseResponse(
            $this->httpClient->get($this->buildUri($url), ['query' => $queryParameters])
        );
    }

    /**
     * @param $url
     * @param array $body
     *
     * @return Response
     */
    public function patch($url, array $body)
    {
        return $this->parseResponse(
            $this->httpClient->patch($this->buildUri($url), ['json' => $body])
        );
    }

    /**
     * @param $url
     * @param array $body
     *
     * @return Response
     */
    public function put($url, array $body)
    {
        return $this->parseResponse(
            $this->httpClient->put($this->buildUri($url), ['json' => $body])
        );
    }

    /**
     * @param $url
     *
     * @return Response
     */
    public function delete($url)
    {
        return $this->parseResponse(
            $this->httpClient->delete($this->buildUri($url))
        );
    }

    /**
     * @param $url
     * @param $body
     * @param array $files
     *
     * @return Response
     */
    public function post($url, $body, array $files = array())
    {
        return $this->parseResponse(
            $this->httpClient->post($this->buildUri($url), ['json' => $body])
        );
    }

    /**
     * {@inheritdoc }
     */
    public function getSchemeAndHost()
    {
        return sprintf('%s://%s', $this->baseUrl->getScheme(), $this->baseUrl->getHost());
    }

    /**
     * @param ResponseInterface $response
     *
     * @return Response
     */
    protected function parseResponse(ResponseInterface $response)
    {
        return new Response($response);
    }
}
