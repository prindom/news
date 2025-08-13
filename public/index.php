<?php

require dirname(__DIR__) . '/vendor/autoload.php';

use Dumbo\Dumbo;
use Smarty\Smarty;

$app = new Dumbo();

$app->use(function ($context, $next) {
    $context->render(
        function (string $view, array $attributes) {
            // Define our cache and views directory
            $cacheDirectory = dirname(__DIR__) . '/cache/views';
            $templateDirectory = dirname(__DIR__) . '/views';
            $configDirectory = dirname(__DIR__) . '/config';
            $compileDirectory = dirname(__DIR__) . '/cache/compiles';


            // Instantiate our Template Engine
            $smarty = new Smarty();
            $smarty->setTemplateDir($templateDirectory);
            $smarty->setCompileDir($compileDirectory);
            $smarty->setCacheDir($cacheDirectory);
            $smarty->setConfigDir($configDirectory);

            // Render our HTML string from our view and attributes.
            $smarty->assign($attributes);
            $html = $smarty->fetch($view);

            return $html;
        }
    );

    return $next($context);
});

$app->get('/', function ($context) {
    return $context->view('index.tpl', []);
});

$app->get('/item/:id', function ($context) {
    return $context->view('item.tpl', []);
});

$app->get('/demo', function ($context) {
    return $context->view('demo.tpl', []);
});

$app->get('/users/:id', function ($context) {
    $id = $context->req->param('id');
    return $context->json(['userId' => $id]);
});

$app->post('/users', function ($context) {
    $body = $context->req->body();
    return $context->json($body, 201);
});

$app->run();