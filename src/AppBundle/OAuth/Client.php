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
     * @param array $options
     *
     * @return Response
     */
    public function get($url, array $queryParameters = [], array $options = [])
    {
        return $this->parseResponse(
            $this->httpClient->get(
                $this->buildUri($url),
                array_merge($this->applyOptions($options), ['query' => $queryParameters])
            )
        );
    }

    /**
     * @param $url
     * @param array $body
     * @param array $options
     *
     * @return Response
     */
    public function patch($url, array $body = [], array $options = [])
    {
        return $this->parseResponse(
            $this->httpClient->patch(
                $this->buildUri($url),
                array_merge($this->applyOptions($options), ['json' => $body])
            )
        );
    }

    /**
     * @param $url
     * @param array $body
     * @param array $options
     *
     * @return Response
     */
    public function put($url, array $body = [], array  $options = [])
    {
        return $this->parseResponse(
            $this->httpClient->put(
                $this->buildUri($url),
                array_merge($this->applyOptions($options), ['json' => $body])
            )
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
     * @param array $options
     *
     * @return Response
     */
    public function post($url, $body, array $options = array())
    {
        return $this->parseResponse(
            $this->httpClient->post(
                $this->buildUri($url),
                array_merge($this->applyOptions($options), ['json' => $body])
            )
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

    /**
     * @param array $options
     *
     * @return array
     */
    private function applyOptions(array $options = [])
    {
        if (array_key_exists('headers', $options)) {
            $defaults = (array) $this->httpClient->getConfig('headers');

            foreach($options['headers'] as $key => &$value) {
                $value = sprintf('%s; %s', $defaults[$key], $value);
            }
        }

        return $options;
    }
}
