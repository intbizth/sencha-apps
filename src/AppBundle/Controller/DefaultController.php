<?php

namespace AppBundle\Controller;

use GuzzleHttp\Exception\RequestException;
use GuzzleHttp\Message\ResponseInterface;
use Sylius\Api\InvalidResponseFormatException;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RedirectResponse;
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
        $status = $response->getStatusCode();

        if ($status === 204) {
            return Response::create('', $status);
        }

        if (in_array($status, [301, 302])) {
            // TODO: location?
            return RedirectResponse::create('', $status);
        }

        $responseType = $response->getHeader('Content-Type');

        if ((false === strpos($responseType, 'application/json')) && (false === strpos($responseType, 'application/xml'))) {
            throw new InvalidResponseFormatException((string) $response->getBody(), $response->getStatusCode());
        }


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
     */
    private static function removeClientQueryParams(Request $request)
    {
        $request->query->remove('_dc');
        $request->query->remove('_method');
        $request->query->remove('page');
        $request->query->remove('start');
    }

    /**
     * @param Request $request
     * @param string $path
     *
     * @return ResponseInterface|null
     */
    private function resource(Request $request, $path)
    {
        $client = $this->get('app.api_client');
        $method = $request->getMethod();

        if ($request->query->has('_method')) {
            $method = $request->query->get('_method');
        }

        self::removeClientQueryParams($request);

        if ('GET' !== $method && $request->query->count()) {
            $path .= '?' . http_build_query($request->query->all());
        }

        try {

            $data = json_decode($request->getContent(), true);

            switch($method) {
                case 'POST':
                    $result = $client->post($path, $data);
                    break;

                case 'PUT':
                    $result = $client->put($path, $data);
                    break;

                case 'PATCH':
                    $result = $client->patch($path, $data);
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
