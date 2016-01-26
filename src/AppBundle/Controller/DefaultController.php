<?php

namespace AppBundle\Controller;

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

        if (strpos($responseType, 'application/json') !== false) {
            return JsonResponse::create($response->json());
        }

        return Response::create($response->xml());
    }

    /**
     * @param $path
     * @param array|null $queryParameters
     *
     * @return ResponseInterface
     */
    private function getResource($path, array $queryParameters = null)
    {
        return $this->get('app.api_client')->get($path, $queryParameters);
    }

    /**
     * @Route("/me", name="user_info")
     */
    public function userInfoAction()
    {
        return self::createResponse($this->getResource('me'));
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
        return self::createResponse($this->getResource($path, $request->query->all()));
    }

    /**
     * @Route("/", name="homepage")
     */
    public function indexAction()
    {
        return $this->render('default/index.html.twig', [
        ]);
    }
}
