<?php

namespace AppBundle\Controller;

use GuzzleHttp\Exception\RequestException;
use GuzzleHttp\Message\ResponseInterface;
use Sylius\Api\InvalidResponseFormatException;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController extends Controller
{
    /**
     * @param ResponseInterface $response
     *
     * @return Response|static
     *
     * @throws InvalidResponseFormatException
     */
    private static function createResponse(ResponseInterface $response)
    {
        $responseType = $response->getHeader('Content-Type');

        if ((false === strpos($responseType, 'application/json')) && (false === strpos($responseType, 'application/xml'))) {
            throw new InvalidResponseFormatException((string) $response->getBody(), $response->getStatusCode());
        }

        $status = $response->getStatusCode();

        if ($status >= 400) {
            return JsonResponse::create(array(
                'code' => $status,
                'message' => $response->getReasonPhrase(),
            ), $status);
        }

        if (strpos($responseType, 'application/json') !== false) {
            return JsonResponse::create($response->json());
        }

        return Response::create($response->xml());
    }

    /**
     * @param Request $request
     * @param string $path
     *
     * @return ResponseInterface|null
     */
    private function resource(Request $request, $path)
    {
        try {
            $client = $this->get('app.api_client');

            if ($request->query->count()) {
                $path .= '?' . $request->getQueryString();
            }

            $method = $request->getMethod();

            if ($request->query->has('_method')) {
                $method = $request->query->get('_method');
            }

            switch(strtoupper($method)) {
                case 'POST':
                    $result = $client->post($path, $request->request->all());
                    break;

                case 'PUT':
                    $result = $client->put($path, $request->request->all());
                    break;

                case 'PATCH':
                    $result = $client->patch($path, $request->request->all());
                    break;

                case 'DELETE':
                    $result = $client->delete($path);
                    break;

                default:
                    $result = $client->get($path, $request->query->all());
            }

            return $result;
        } catch (RequestException $e) {
            return $e->getResponse();
        }
    }

    /**
     * @Route("/v1/{path}", name="resource_api", requirements={"path"=".*"})
     *
     * @param Request $request
     * @param string $path
     *
     * @return Response|static
     */
    public function apiAction(Request $request, $path)
    {
        return self::createResponse($this->resource($request, $path));
    }

    /**
     * @Route("/", name="homepage")
     */
    public function indexAction()
    {
        return $this->render('default/index.html.twig');
    }
}
