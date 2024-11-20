<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="assets/favicon.svg" />
    <meta
            name="viewport"
            content="viewport-fit=cover, width=device-width, initial-scale=1.0"
    />
    <title>news.redslate.net</title>
    <meta
            name="description"
            content="a news feed based on the hackernews api"
    />
    <link rel="manifest" href="manifest.webmanifest" />

    <script
            src="https://kit.fontawesome.com/7d20ea0579.js"
            crossorigin="anonymous"
    ></script>

    <!-- import Inter font from cdn -->
    <link rel="stylesheet" href="https://rsms.me/inter/inter.css" />
    <link rel="stylesheet" href="/dist/css/style.css" />
</head>
<body>
<div
        id="app"
        class="flex min-h-screen flex-col items-center justify-between py-4 text-center dark:bg-gray-800 p-3 selection:bg-green-100 max-w-full overflow-x-hidden"
>
    {include file="navigation.tpl"}

{block name="body"}{/block}
</div>

<script type="module" src="/dist/js/main.js"></script>
</body>
</html>