<?php

namespace AppBundle\OAuth;

use GuzzleHttp\ClientInterface as HttpClientInterface;
use GuzzleHttp\Post\PostBodyInterface;
use GuzzleHttp\Url;
use Sylius\Api\Factory\PostFileFactory;
use Sylius\Api\Factory\PostFileFactoryInterface;
use Sylius\Api\ClientInterface;

class Client implements ClientInterface
{
    /**
     * @var Url $baseUrl
     */
    private $baseUrl;
    /**
     * @var HttpClientInterface $httpClient
     */
    private $httpClient;
    /**
     * @var PostFileFactoryInterface $postFileFactory
     */
    private $postFileFactory;

    public function __construct(HttpClientInterface $httpClient, PostFileFactoryInterface $postFileFactory = null)
    {
        $this->httpClient = $httpClient;
        $this->postFileFactory = $postFileFactory ?: new PostFileFactory();
        $this->baseUrl = Url::fromString($httpClient->getBaseUrl());
    }

    /**
     * {@inheritdoc }
     */
    public function get($url, array $queryParameters = [])
    {
        return $this->httpClient->get($url, ['query' => $queryParameters]);
    }

    /**
     * {@inheritdoc }
     */
    public function patch($url, array $body)
    {
        return $this->httpClient->patch($url, ['json' => $body]);
    }

    /**
     * {@inheritdoc }
     */
    public function put($url, array $body)
    {
        return $this->httpClient->put($url, ['json' => $body]);
    }

    /**
     * {@inheritdoc }
     */
    public function delete($url)
    {
        return $this->httpClient->delete($url);
    }

    /**
     * {@inheritdoc }
     */
    public function post($url, $body, array $files = array())
    {
        $request = $this->httpClient->createRequest('POST', $url, ['json' => $body]);

        /** @var PostBodyInterface $postBody */
        $postBody = $request->getBody();
        foreach ($files as $key => $filePath) {
            $file = $this->postFileFactory->create($key, $filePath);
            $postBody->addFile($file);
        }
        $response = $this->httpClient->send($request);

        return $response;
    }

    /**
     * {@inheritdoc }
     */
    public function getSchemeAndHost()
    {
        return sprintf('%s://%s', $this->baseUrl->getScheme(), $this->baseUrl->getHost());
    }
}
