<?php

// check url parameters for valid parameter url
if(!isset($_GET['url']) || empty($_GET['url'])){
    echo "Please enter a valid url";
    exit;
}

$html = file_get_contents($_GET['url']);

// create a new DOM document
$dom = new DOMDocument();

// get meta information from dom
$dom->loadHTML($html);
$metaTags = $dom->getElementsByTagName('meta');

// return meta information as json
$meta = array();
foreach ($metaTags as $metaTag) {
    if ($metaTag->getAttribute('name')) {
        $meta[$metaTag->getAttribute('name')] = $metaTag->getAttribute('content');
    } else if ($metaTag->getAttribute('property')) {
        $meta[$metaTag->getAttribute('property')] = $metaTag->getAttribute('content');
    }
}
echo json_encode($meta);
die();