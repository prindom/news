{extends file="layout.tpl"}
{block name="body"}
    <div class="mx-auto container">
        <article
                x-data="item()"
                class="mb-3 rounded-xl bg-gradient-to-r from-green-300 via-blue-500 to-purple-600 p-0.5 shadow-xl transition hover:animate-background hover:bg-[length:400%_400%] hover:shadow-sm hover:[animation-duration:_4s] dark:shadow-gray-700/25"
        >
            <div
                    class="flex flex-col gap-4 p-4 sm:p-6 lg:p-8 rounded-[10px] bg-white !pt-8 dark:bg-gray-900"
            >
                <!--<img :src="image" alt="image" class="w-12 h-12 rounded shadow-lg" />-->

                <h3 class="font-medium sm:text-lg">
                    <a
                            :href="url"
                            target="_blank"
                            rel="noopener noreferrer"
                            class="hover:underline text-gray-600 hover:text-gray-700 dark:text-gray-300 dark:hover:text-gray-200"
                            x-text="title"
                    ></a>
                </h3>

                <p class="text-sm text-gray-600" x-show="text != ''" x-text="text">
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

                    <span class="hidden sm:block" aria-hidden="true">&middot;</span>

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

                    <span class="hidden sm:block" aria-hidden="true">&middot;</span>

                    <p class="hidden sm:block sm:text-xs sm:text-gray-500">
                        Posted by
                        <a
                                target="_blank"
                                rel="noopener noreferrer"
                                :href="by_url"
                                class="font-medium underline hover:text-gray-700"
                                x-text="by"
                        ></a>
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

                        <p
                                class="text-xs"
                                x-text="new Date(time *1000).toLocaleString()"
                        ></p>
                    </div>
                </div>
            </div>
        </article>
        <section
                class="mb-3 rounded-xl bg-gradient-to-r from-green-300 via-blue-500 to-purple-600 p-0.5 shadow-xl transition hover:animate-background hover:bg-[length:400%_400%] hover:shadow-sm hover:[animation-duration:_4s] dark:shadow-gray-700/25"
        >
            <ul
                    id="comments"
                    class="text-left flex flex-col gap-4 p-4 sm:p-6 lg:p-8 rounded-[10px] bg-white !pt-8 dark:bg-gray-900 text-gray-600 hover:text-gray-700 dark:text-gray-300 dark:hover:text-gray-200"
            ></ul>
        </section>
    </div>
{/block}
