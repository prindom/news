{extends file="layout.tpl"}
{block name="body"}
    <script>
        // Initialize Alpine store with server-side data
        document.addEventListener('alpine:init', () => {
            Alpine.store('current', '{$currentType|default:"top"}')
        })
    </script>
    <div
            id="app"
            class="flex min-h-screen flex-col items-center justify-between py-4 text-center dark:bg-gray-800 p-3 selection:bg-green-100 max-w-full overflow-x-hidden"
    >
        <div id="articles" x-data="list" class="mx-auto container">
            {* Server-rendered articles for SEO *}
            {foreach $articles as $article}
            <div class="relative z-0">
                <div
                        class="cursor-pointer reveal-right text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg text-sm p-2"
                >
                    <!-- save icon -->
                    <svg
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke-width="1.5"
                            stroke="currentColor"
                            class="w-6 h-6"
                    >
                        <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z"
                        />
                    </svg>
                </div>
                <article
                        x-data="item({$article.id})"
                        x-intersect.once="loadFull"
                        class="z-20 article mb-3 rounded-xl bg-gradient-to-r from-green-300 via-blue-500 to-purple-600 p-0.5 shadow-xl transition hover:animate-background hover:bg-[length:400%_400%] hover:shadow-sm hover:[animation-duration:_4s] dark:shadow-gray-700/25"
                >
                    <div
                            class="z-20 flex flex-col gap-4 p-4 sm:p-6 lg:p-8 rounded-[10px] bg-white !pt-8 dark:bg-gray-900"
                    >
                        <h3 class="font-medium sm:text-lg">
                            <a
                                    href="{$article.url|default:'#'}"
                                    target="_blank"
                                    class="hover:underline text-gray-600 hover:text-gray-700 dark:text-gray-300 dark:hover:text-gray-200"
                            >{$article.title|default:'Untitled'}</a>
                        </h3>

                        {if isset($article['text'])}
                        <p class="line-clamp-2 text-sm text-gray-700">
                            {$article.text|strip_tags|truncate:200}
                        </p>
                        {/if}

                        <div class="mt-2 sm:flex sm:items-center sm:gap-2">
                            <div class="flex items-center gap-1 text-gray-500">
                                <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        fill="none"
                                        viewBox="0 0 24 24"
                                        stroke-width="1.5"
                                        stroke="currentColor"
                                        class="w-4 h-4 leading-normal"
                                >
                                    <path
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            d="m3.75 13.5 10.5-11.25L12 10.5h8.25L9.75 21.75 12 13.5H3.75Z"
                                    />
                                </svg>
                                <p class="text-xs">{$article.score|default:0}</p>
                            </div>

                            <span class="hidden sm:block" aria-hidden="true">&middot;</span>

                            <div class="flex items-center gap-1 text-gray-500 hover:underline hover:cursor-pointer">
                                <a href="/item/{$article.id}" class="text-xs flex">
                                    <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            fill="none"
                                            viewBox="0 0 24 24"
                                            stroke-width="1.5"
                                            stroke="currentColor"
                                            class="w-4 h-4 leading-normal"
                                    >
                                        <path
                                                stroke-linecap="round"
                                                stroke-linejoin="round"
                                                d="M7.5 8.25h9m-9 3H12m-9.75 1.51c0 1.6 1.123 2.994 2.707 3.227 1.129.166 2.27.293 3.423.379.35.026.67.21.865.501L12 21l2.755-4.133a1.14 1.14 0 0 1 .865-.501 48.172 48.172 0 0 0 3.423-.379c1.584-.233 2.707-1.626 2.707-3.228V6.741c0-1.602-1.123-2.995-2.707-3.228A48.394 48.394 0 0 0 12 3c-2.392 0-4.744.175-7.043.513C3.373 3.746 2.25 5.14 2.25 6.741v6.018Z"
                                        />
                                    </svg>
                                    <span class="pl-1">{$article.descendants|default:0}</span>
                                </a>
                            </div>

                            <span class="hidden sm:block" aria-hidden="true">&middot;</span>

                            <p class="hidden sm:block sm:text-xs sm:text-gray-500">
                                Posted by
                                <a
                                        target="_blank"
                                        href="https://news.ycombinator.com/user?id={$article.by|default:''}"
                                        class="font-medium underline hover:text-gray-700"
                                >{$article.by|default:'Unknown'}</a>
                            </p>

                            <span class="hidden sm:block" aria-hidden="true">&middot;</span>

                            <div class="flex items-center gap-1 text-gray-500">
                                <svg
                                        xmlns="http://www.w3.org/2000/svg"
                                        fill="none"
                                        viewBox="0 0 24 24"
                                        stroke-width="1.5"
                                        stroke="currentColor"
                                        class="w-4 h-4"
                                >
                                    <path
                                            stroke-linecap="round"
                                            stroke-linejoin="round"
                                            d="M12 6v6h4.5m4.5 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                                    />
                                </svg>
                                <p class="text-xs">
                                    {if $article.time}
                                        {$article.time|date_format:"%Y-%m-%d %H:%M"}
                                    {/if}
                                </p>
                            </div>
                        </div>
                    </div>
                </article>
                <div
                        class="cursor-pointer reveal-left text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg text-sm p-2"
                >
                    <!-- share icon -->
                    <svg
                            xmlns="http://www.w3.org/2000/svg"
                            fill="none"
                            viewBox="0 0 24 24"
                            stroke-width="1.5"
                            stroke="currentColor"
                            class="w-6 h-6"
                    >
                        <path
                                stroke-linecap="round"
                                stroke-linejoin="round"
                                d="M7.217 10.907a2.25 2.25 0 1 0 0 2.186m0-2.186c.18.324.283.696.283 1.093s-.103.77-.283 1.093m0-2.186 9.566-5.314m-9.566 7.5 9.566 5.314m0 0a2.25 2.25 0 1 0 3.935 2.186 2.25 2.25 0 0 0-3.935-2.186Zm0-12.814a2.25 2.25 0 1 0 3.933-2.185 2.25 2.25 0 0 0-3.933 2.185Z"
                        />
                    </svg>
                </div>
            </div>
            {/foreach}

            {* Alpine.js template for client-side loading *}
            <template x-for="article in items">
                <div class="relative z-0">
                    <div
                            class="cursor-pointer reveal-right text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg text-sm p-2"
                    >
                        <!-- save icon -->
                        <svg
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="1.5"
                                stroke="currentColor"
                                class="w-6 h-6"
                        >
                            <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M17.593 3.322c1.1.128 1.907 1.077 1.907 2.185V21L12 17.25 4.5 21V5.507c0-1.108.806-2.057 1.907-2.185a48.507 48.507 0 0 1 11.186 0Z"
                            />
                        </svg>
                    </div>
                    <article
                            x-data="item(article)"
                            x-intersect.once="loadFull"
                            class="z-20 article mb-3 rounded-xl bg-gradient-to-r from-green-300 via-blue-500 to-purple-600 p-0.5 shadow-xl transition hover:animate-background hover:bg-[length:400%_400%] hover:shadow-sm hover:[animation-duration:_4s] dark:shadow-gray-700/25"
                    >
                        <div
                                class="z-20 flex flex-col gap-4 p-4 sm:p-6 lg:p-8 rounded-[10px] bg-white !pt-8 dark:bg-gray-900"
                        >
                            <!--<img :src="image" alt="image" class="w-12 h-12 rounded shadow-lg" />-->

                            <h3 class="font-medium sm:text-lg">
                                <a
                                        :href="url"
                                        target="_blank"
                                        class="hover:underline text-gray-600 hover:text-gray-700 dark:text-gray-300 dark:hover:text-gray-200"
                                        x-text="title"
                                ></a>
                            </h3>

                            <p
                                    class="line-clamp-2 text-sm text-gray-700"
                                    x-show="text != ''"
                                    x-html="text"
                            >
                                loading ...
                            </p>

                            <div class="mt-2 sm:flex sm:items-center sm:gap-2">
                                <div class="flex items-center gap-1 text-gray-500">
                                    <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            fill="none"
                                            viewBox="0 0 24 24"
                                            stroke-width="1.5"
                                            stroke="currentColor"
                                            class="w-4 h-4 leading-normal"
                                    >
                                        <path
                                                stroke-linecap="round"
                                                stroke-linejoin="round"
                                                d="m3.75 13.5 10.5-11.25L12 10.5h8.25L9.75 21.75 12 13.5H3.75Z"
                                        />
                                    </svg>

                                    <p class="text-xs" x-text="score"></p>
                                </div>

                                <span class="hidden sm:block" aria-hidden="true"
                                >&middot;</span
                                >

                                <div
                                        class="flex items-center gap-1 text-gray-500 hover:underline hover:cursor-pointer"
                                >
                                    <a :href='"/item/"+id' class="text-xs flex">
                                        <svg
                                                xmlns="http://www.w3.org/2000/svg"
                                                fill="none"
                                                viewBox="0 0 24 24"
                                                stroke-width="1.5"
                                                stroke="currentColor"
                                                class="w-4 h-4 leading-normal"
                                        >
                                            <path
                                                    stroke-linecap="round"
                                                    stroke-linejoin="round"
                                                    d="M7.5 8.25h9m-9 3H12m-9.75 1.51c0 1.6 1.123 2.994 2.707 3.227 1.129.166 2.27.293 3.423.379.35.026.67.21.865.501L12 21l2.755-4.133a1.14 1.14 0 0 1 .865-.501 48.172 48.172 0 0 0 3.423-.379c1.584-.233 2.707-1.626 2.707-3.228V6.741c0-1.602-1.123-2.995-2.707-3.228A48.394 48.394 0 0 0 12 3c-2.392 0-4.744.175-7.043.513C3.373 3.746 2.25 5.14 2.25 6.741v6.018Z"
                                            />
                                        </svg>

                                        <span class="pl-1" x-text="descendants"></span>
                                    </a>
                                </div>

                                <span class="hidden sm:block" aria-hidden="true"
                                >&middot;</span
                                >

                                <p class="hidden sm:block sm:text-xs sm:text-gray-500">
                                    Posted by
                                    <a
                                            target="_blank"
                                            :href="by_url"
                                            class="font-medium underline hover:text-gray-700"
                                            x-text="by"
                                    ></a>
                                </p>

                                <span class="hidden sm:block" aria-hidden="true"
                                >&middot;</span
                                >

                                <div class="flex items-center gap-1 text-gray-500">
                                    <svg
                                            xmlns="http://www.w3.org/2000/svg"
                                            fill="none"
                                            viewBox="0 0 24 24"
                                            stroke-width="1.5"
                                            stroke="currentColor"
                                            class="w-4 h-4"
                                    >
                                        <path
                                                stroke-linecap="round"
                                                stroke-linejoin="round"
                                                d="M12 6v6h4.5m4.5 0a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
                                        />
                                    </svg>

                                    <p
                                            class="text-xs"
                                            x-text="new Date(time *1000).toLocaleString()"
                                    ></p>
                                </div>
                            </div>
                        </div>
                    </article>
                    <div
                            class="cursor-pointer reveal-left text-gray-500 dark:text-gray-400 hover:bg-gray-100 dark:hover:bg-gray-700 rounded-lg text-sm p-2"
                    >
                        <!-- share icon -->
                        <svg
                                xmlns="http://www.w3.org/2000/svg"
                                fill="none"
                                viewBox="0 0 24 24"
                                stroke-width="1.5"
                                stroke="currentColor"
                                class="w-6 h-6"
                        >
                            <path
                                    stroke-linecap="round"
                                    stroke-linejoin="round"
                                    d="M7.217 10.907a2.25 2.25 0 1 0 0 2.186m0-2.186c.18.324.283.696.283 1.093s-.103.77-.283 1.093m0-2.186 9.566-5.314m-9.566 7.5 9.566 5.314m0 0a2.25 2.25 0 1 0 3.935 2.186 2.25 2.25 0 0 0-3.935-2.186Zm0-12.814a2.25 2.25 0 1 0 3.933-2.185 2.25 2.25 0 0 0-3.933 2.185Z"
                            />
                        </svg>
                    </div>
                </div>
            </template>
        </div>
    </div>
{/block}

