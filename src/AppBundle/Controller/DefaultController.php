<?php

namespace AppBundle\Controller;

use AppBundle\OAuth\Response as OAuthResponse;
use GuzzleHttp\Exception\RequestException;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DefaultController extends Controller
{
    /**
     * @param OAuthResponse $response
     *
     * @return Response|static
     */
    private static function createResponse(OAuthResponse $response)
    {
        $status = $response->getStatusCode();

        if ($response->isStatus(204)) {
            return Response::create('', $status);
        }

        if ($response->isStatus([301, 302])) {
            // TODO: location?
            return RedirectResponse::create('', $status);
        }

        if ($response->isStatus(400)) {
            return JsonResponse::create(array(
                'code' => $status,
                'message' => $response->getStatusText(),
            ), $status);
        }

        if ($response->isJson()) {
            return JsonResponse::create($response->getContent(), $status);
        }

        return Response::create($response->getContent(), $status);
    }

    /**
     * @param Request $request
     */
    private static function removeClientQueryParams(Request $request)
    {
        $request->query->remove('_dc');
        $request->query->remove('_method');
        $request->query->remove('start');
    }

    /**
     * @param Request $request
     * @param string $path
     *
     * @return OAuthResponse
     */
    private function resource(Request $request, $path)
    {
        $client = $this->get('api.client');
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
            return new OAuthResponse($e->getResponse());
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
