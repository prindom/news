<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <link rel="icon" type="image/svg+xml" href="/assets/favicon.svg" />
    <meta
            name="viewport"
            content="viewport-fit=cover, width=device-width, initial-scale=1.0"
    />
    <title>news.redslate.net</title>
    <meta
            name="description"
            content="a news feed based on the hackernews api"
    />
    <link rel="manifest" href="/manifest.webmanifest" />

    <script>
  window.vmtrcq = window.vmtrcq || [];
  window.vmtrc = window.vmtrc || function (){ window.vmtrcq.push(Array.prototype.slice.call(arguments))};
</script>
<script defer src="https://cdn.vemetric.com/main.js" id="vmtrc-scr" data-token="otsG5HYZINKUWlvn"></script>

    <script
            src="https://kit.fontawesome.com/7d20ea0579.js"
            crossorigin="anonymous"
    ></script>

    <!-- import Inter font from cdn -->
    <link rel="stylesheet" href="https://rsms.me/inter/inter.css" />
    <link rel="stylesheet" href="/dist/css/hn-news.css" />
</head>
<body>
<div
        id="app"
        class="flex min-h-screen flex-col items-center justify-between py-4 text-center dark:bg-gray-800 p-3 selection:bg-green-100 max-w-full overflow-x-hidden"
>
    {include file="navigation.tpl"}

{block name="body"}{/block}

    <!-- Footer -->
    <footer class="mt-auto pt-8 pb-4 text-center">
        <div class="text-sm text-gray-500 dark:text-gray-400">
            Copyright © dprinzensteiner |
            <a href="mailto:contact@prinzensteiner.net" class="text-blue-500 hover:text-blue-400 hover:underline transition-all">
                contact@prinzensteiner.net
            </a>
        </div>
    </footer>
</div>

<script type="module" src="/dist/js/main.js"></script>
</body>
</html>
