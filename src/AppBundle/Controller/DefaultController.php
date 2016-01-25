<?php

namespace AppBundle\Controller;

use Sensio\Bundle\FrameworkExtraBundle\Configuration\Route;
use Sylius\Api\InvalidResponseFormatException;
use Symfony\Bundle\FrameworkBundle\Controller\Controller;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;

class DefaultController extends Controller
{
    /**
     * @Route("/me", name="user_info")
     */
    public function userInfoAction()
    {
        $response = $this->get('app.api_client')->get('me');
        $responseType = $response->getHeader('Content-Type');

        if ((false === strpos($responseType, 'application/json')) && (false === strpos($responseType, 'application/xml'))) {
            throw new InvalidResponseFormatException((string) $response->getBody(), $response->getStatusCode());
        }

        return (strpos($responseType, 'application/json') !== false) ? $response->json() : $response->xml();
    }

    /**
     * @Route("/v1/{path}", name="resource_api")
     */
    public function resourceAction()
    {
        $users = $this->get('app.api_resolver')->getApi('me');
        $data = $users->get(1);

        // TODO: other format
        return JsonResponse::create($data);
    }

    /**
     * @Route("/", name="homepage")
     */
    public function indexAction()
    {
        // replace this example code with whatever you need
        return $this->render('default/index.html.twig', [
            'base_dir' => realpath($this->container->getParameter('kernel.root_dir').'/..'),
        ]);
    }
}
