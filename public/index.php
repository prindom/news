<?php

require dirname(__DIR__) . '/vendor/autoload.php';
require 'HackerNewsService.php';

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
    // Get story type from query params, default to 'top'
    $type = $context->req->query('type') ?: 'top';
    
    // Validate story type
    $validTypes = ['top', 'new', 'show', 'best'];
    if (!in_array($type, $validTypes)) {
        $type = 'top';
    }
    
    // Fetch initial articles for SEO
    $hnService = new HackerNewsService();
    $storyIds = $hnService->getStoryIds($type);
    $articles = [];
    
    if ($storyIds) {
        // Get first 10 articles for initial render
        $articles = $hnService->getItems(array_slice($storyIds, 0, 10), 10);
    }
    
    return $context->view('index.tpl', [
        'articles' => $articles,
        'currentType' => $type
    ]);
});

$app->get('/item/:id', function ($context) {
    return $context->view('item.tpl', []);
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