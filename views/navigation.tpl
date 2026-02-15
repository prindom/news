<div
        x-data="nav"
        class="fixed bottom-0 inset-x-0 z-50 w-full md:static md:mb-4"
        role="navigation"
        aria-label="Primary"
>
    <div class="mx-auto w-full px-3 pb-3 md:container md:px-0 md:pb-0">
        <div
                class="flex flex-wrap items-center justify-between gap-2 rounded-xl border border-edge-secondary bg-surface-secondary p-2 shadow-lg md:shadow-sm"
        >
            <div class="flex items-center gap-2">
                <div class="relative md:hidden" x-data="{ typesOpen: false }" @click.outside="typesOpen = false">
                    <button
                            type="button"
                            @click="typesOpen = !typesOpen"
                            class="inline-flex items-center gap-2 rounded-lg border border-edge bg-surface-secondary px-4 py-2 text-sm text-content shadow-sm"
                    >
                        <span class="capitalize" x-text="$store.current"></span>
                        <svg
                                xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 24 24"
                                fill="currentColor"
                                class="w-4 h-4 transition-transform"
                                :class="{ 'rotate-180': typesOpen }"
                        >
                            <path
                                    fill-rule="evenodd"
                                    d="M12 15.75a.75.75 0 0 1-.53-.22l-4.5-4.5a.75.75 0 1 1 1.06-1.06L12 13.94l3.97-3.97a.75.75 0 1 1 1.06 1.06l-4.5 4.5a.75.75 0 0 1-.53.22Z"
                                    clip-rule="evenodd"
                            />
                        </svg>
                    </button>
                    <div
                            x-cloak
                            x-show="typesOpen"
                            x-transition
                            class="absolute bottom-full left-0 mb-2 w-56 rounded-xl border border-edge bg-surface p-2 shadow-lg"
                    >
                        <button
                                @click="$store.current = 'top'; window.location = window.location.origin + '?type=top'; typesOpen = false"
                                :class="{ 'bg-surface-secondary': $store.current === 'top' }"
                                class="block w-full rounded-lg px-4 py-3 text-left text-sm text-content hover:bg-surface-tertiary"
                        >
                            top
                        </button>
                        <button
                                @click="$store.current = 'new'; window.location = window.location.origin + '?type=new'; typesOpen = false"
                                :class="{ 'bg-surface-secondary': $store.current === 'new' }"
                                class="block w-full rounded-lg px-4 py-3 text-left text-sm text-content hover:bg-surface-tertiary"
                        >
                            new
                        </button>
                        <button
                                @click="$store.current = 'show'; window.location = window.location.origin + '?type=show'; typesOpen = false"
                                :class="{ 'bg-surface-secondary': $store.current === 'show' }"
                                class="block w-full rounded-lg px-4 py-3 text-left text-sm text-content hover:bg-surface-tertiary"
                        >
                            show
                        </button>
                        <button
                                @click="$store.current = 'best'; window.location = window.location.origin + '?type=best'; typesOpen = false"
                                :class="{ 'bg-surface-secondary': $store.current === 'best' }"
                                class="block w-full rounded-lg px-4 py-3 text-left text-sm text-content hover:bg-surface-tertiary"
                        >
                            best
                        </button>
                    </div>
                </div>
                <div
                        class="hidden md:inline-flex rounded-lg border border-edge bg-surface-secondary p-1 md:border-0 md:bg-transparent md:p-0"
                >
                    <button
                            @click="$store.current = 'top'; window.location = window.location.origin + '?type=top'"
                            :class="{ 'bg-surface-active': $store.current === 'top' }"
                            class="inline-block rounded-md px-3 py-1.5 text-xs focus:relative text-content-secondary hover:text-content-heading focus:text-white md:px-4 md:py-2 md:text-sm"
                    >
                        <span>top</span>
                    </button>
                    <button
                            @click="$store.current = 'new'; window.location = window.location.origin + '?type=new'"
                            :class="{ 'bg-surface-active': $store.current === 'new' }"
                            class="inline-block rounded-md px-3 py-1.5 text-xs focus:relative text-content-secondary hover:text-content-heading focus:text-white md:px-4 md:py-2 md:text-sm"
                    >
                        <span>new</span>
                    </button>
                    <button
                            @click="$store.current = 'show'; window.location = window.location.origin + '?type=show'"
                            :class="{ 'bg-surface-active': $store.current === 'show' }"
                            class="inline-block rounded-md px-3 py-1.5 text-xs focus:relative text-content-secondary hover:text-content-heading focus:text-white md:px-4 md:py-2 md:text-sm"
                    >
                        <span>show</span>
                    </button>
                    <button
                            @click="$store.current = 'best'; window.location = window.location.origin + '?type=best'"
                            :class="{ 'bg-surface-active': $store.current === 'best' }"
                            class="inline-block rounded-md px-3 py-1.5 text-xs focus:relative text-content-secondary hover:text-content-heading focus:text-white md:px-4 md:py-2 md:text-sm"
                    >
                        <span>best</span>
                    </button>
                </div>
            </div>

            <div class="flex items-center gap-2 md:gap-3">
                <div x-data="search()" class="flex items-center">
                    <label for="SearchTrigger" class="sr-only">Search</label>
                    <div class="relative hidden md:block">
                        <input
                                id="SearchTrigger"
                                type="text"
                                readonly
                                aria-label="Open search"
                                @focus="open = true; $nextTick(() => $refs.searchInput && $refs.searchInput.focus())"
                                class="w-64 rounded-lg border border-edge-secondary bg-surface px-4 py-2.5 pl-12 pr-16 text-sm text-content placeholder:text-content-secondary focus:outline-none focus:ring-2 focus:ring-accent/30 cursor-pointer"
                        />
                        <span
                                class="pointer-events-none absolute inset-y-0 left-3 inline-flex items-center gap-2 text-xs text-content-secondary"
                                :aria-label="isMac ? 'Cmd+K' : 'Ctrl+K'"
                        >
                            <svg
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.5"
                                    class="h-4 w-4"
                            >
                                <path
                                        stroke-linecap="round"
                                        stroke-linejoin="round"
                                        d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z"
                                />
                            </svg>
                            <span class="text-content-secondary">Search</span>
                        </span>
                        <span
                                class="pointer-events-none absolute inset-y-0 right-3 inline-flex items-center gap-1 text-xs text-content-secondary"
                                :aria-label="isMac ? 'Cmd+K' : 'Ctrl+K'"
                        >
                            <svg
                                    x-cloak
                                    x-show="isMac"
                                    xmlns="http://www.w3.org/2000/svg"
                                    viewBox="0 0 24 24"
                                    fill="none"
                                    stroke="currentColor"
                                    stroke-width="1.5"
                                    class="h-3.5 w-3.5"
                            >
                                <path d="M18 3a3 3 0 0 0-3 3v3H9V6a3 3 0 1 0-3 3h3v6H6a3 3 0 1 0 3 3v-3h6v3a3 3 0 1 0 3-3h-3V9h3a3 3 0 0 0 3-3 3 3 0 0 0-3-3z" />
                            </svg>
                            <span
                                    x-cloak
                                    x-show="!isMac"
                                    class="font-medium text-content-secondary"
                            >
                                Ctrl
                            </span>
                            <span>+</span>
                            <span x-text="searchShortcutKey"></span>
                        </span>
                    </div>
                    <button
                            id="searchBtn"
                            type="button"
                            @click="open = true; $nextTick(() => $refs.searchInput && $refs.searchInput.focus())"
                            aria-label="Open search"
                            class="md:hidden text-content-secondary hover:bg-surface-hover rounded-lg text-sm p-2 text-center h-full"
                    >
                        <svg
                                xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 24 24"
                                fill="currentColor"
                                class="w-4 h-4"
                        >
                            <path
                                    fill-rule="evenodd"
                                    d="M10.5 3.75a6.75 6.75 0 1 0 0 13.5 6.75 6.75 0 0 0 0-13.5ZM2.25 10.5a8.25 8.25 0 1 1 14.59 5.28l4.69 4.69a.75.75 0 1 1-1.06 1.06l-4.69-4.69A8.25 8.25 0 0 1 2.25 10.5Z"
                                    clip-rule="evenodd"
                            />
                        </svg>
                    </button>
                    <!-- Modal -->
                    <div
                            x-show="open"
                            style="display: none"
                            x-on:keydown.escape.prevent.stop="open = false"
                            role="dialog"
                            aria-modal="true"
                            x-id="['modal-title']"
                            :aria-labelledby="$id('modal-title')"
                            class="fixed inset-0 z-10 overflow-y-auto"
                    >
                        <!-- Overlay -->
                        <div
                                x-show="open"
                                x-transition.opacity
                                class="fixed inset-0 bg-black bg-opacity-50"
                        ></div>

                        <!-- Panel -->
                        <div
                                x-show="open"
                                x-transition
                                x-on:click="open = false"
                                class="relative flex min-h-screen items-center justify-center p-4"
                        >
                            <div
                                    x-on:click.stop
                                    x-trap.noscroll.inert="open"
                                    class="relative w-full max-w-2xl overflow-y-auto rounded-xl card-gradient p-0.5 shadow-xl transition hover:animate-background hover:bg-[length:400%_400%] hover:shadow-sm hover:[animation-duration:_4s] shadow-theme"
                            >
                                <div
                                        class="p-0.5 sm:p-1 lg:p-1.5 rounded-[10px] bg-surface !pt-1.5"
                                >
                                    <!-- Title
                                                <h2 class="text-3xl font-bold text-content" :id="$id('modal-title')">Search</h2>-->
                                    <div class="relative">
                                        <label for="Search" class="sr-only"> Search </label>

                                        <input
                                                type="text"
                                                id="Search"
                                                x-ref="searchInput"
                                                placeholder="Search for..."
                                                class="block w-full appearance-none bg-transparent py-4 pl-4 pr-12 text-base focus:outline-none sm:text-sm sm:leading-6 focus-visible text-content hover:text-content-heading"
                                        />

                                        <span
                                                class="absolute inset-y-0 end-0 grid w-10 place-content-center"
                                        >
                                <button
                                        type="button"
                                        class="text-content hover:text-content-heading"
                                >
                                  <span class="sr-only">Search</span>
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
                                            d="m21 21-5.197-5.197m0 0A7.5 7.5 0 1 0 5.196 5.196a7.5 7.5 0 0 0 10.607 10.607Z"
                                    />
                                  </svg>
                                </button>
                              </span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Theme selector -->
                <div x-data="themeSelector" class="relative">
                    <button
                            type="button"
                            @click="open = !open"
                            aria-label="Change theme"
                            class="text-content-secondary hover:bg-surface-hover rounded-lg text-sm p-2 text-center"
                    >
                        <svg
                                xmlns="http://www.w3.org/2000/svg"
                                viewBox="0 0 24 24"
                                fill="currentColor"
                                class="w-4 h-4"
                        >
                            <path
                                    fill-rule="evenodd"
                                    d="M2.25 4.125c0-1.036.84-1.875 1.875-1.875h5.25c1.036 0 1.875.84 1.875 1.875V17.25a4.5 4.5 0 1 1-9 0V4.125Zm4.5 14.25a1.125 1.125 0 1 0 0-2.25 1.125 1.125 0 0 0 0 2.25Z"
                                    clip-rule="evenodd"
                            />
                            <path d="M10.719 21.75h9.156c1.036 0 1.875-.84 1.875-1.875v-5.25c0-1.036-.84-1.875-1.875-1.875h-.14l-8.742 8.743c-.09.089-.18.175-.274.257ZM12.738 17.625l6.474-6.474a1.875 1.875 0 0 0-1.337-.551H10.5a3.375 3.375 0 0 0-.238.016l2.476 7.01Z" />
                        </svg>
                    </button>
                    <div
                            x-cloak
                            x-show="open"
                            x-transition
                            @click.outside="open = false"
                            class="absolute right-0 bottom-full mb-2 md:bottom-auto md:top-full md:mt-2 w-48 rounded-xl border border-edge bg-surface p-2 shadow-lg z-50"
                    >
                        <template x-for="t in themes" :key="t.name">
                            <button
                                    @click="$store.theme.setTheme(t.name); open = false"
                                    class="flex w-full items-center gap-3 rounded-lg px-3 py-2 text-left text-sm text-content hover:bg-surface-hover"
                            >
                                <span
                                        class="inline-block h-3 w-3 rounded-full border border-edge-secondary"
                                        :style="'background-color:' + t.color"
                                ></span>
                                <span class="flex-1" x-text="t.label"></span>
                                <svg
                                        x-show="$store.theme.name === t.name"
                                        xmlns="http://www.w3.org/2000/svg"
                                        viewBox="0 0 20 20"
                                        fill="currentColor"
                                        class="w-4 h-4 text-accent"
                                >
                                    <path
                                            fill-rule="evenodd"
                                            d="M16.704 4.153a.75.75 0 0 1 .143 1.052l-8 10.5a.75.75 0 0 1-1.127.075l-4.5-4.5a.75.75 0 0 1 1.06-1.06l3.894 3.893 7.48-9.817a.75.75 0 0 1 1.05-.143Z"
                                            clip-rule="evenodd"
                                    />
                                </svg>
                            </button>
                        </template>
                    </div>
                </div>
                <button
                        id="theme-toggle"
                        type="button"
                        x-data="themeToggle"
                        @click="$store.theme.toggleDark()"
                        aria-label="Toggle theme"
                        class="text-content-secondary hover:bg-surface-hover rounded-lg text-sm p-2 text-center"
                >
                    <svg
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 24 24"
                            fill="currentColor"
                            class="hidden w-4 h-4"
                            :class="{ 'hidden': $store.theme.dark }"
                    >
                        <path
                                fill-rule="evenodd"
                                d="M9.528 1.718a.75.75 0 0 1 .162.819A8.97 8.97 0 0 0 9 6a9 9 0 0 0 9 9 8.97 8.97 0 0 0 3.463-.69.75.75 0 0 1 .981.98 10.503 10.503 0 0 1-9.694 6.46c-5.799 0-10.5-4.7-10.5-10.5 0-4.368 2.667-8.112 6.46-9.694a.75.75 0 0 1 .818.162Z"
                                clip-rule="evenodd"
                        />
                    </svg>
                    <svg
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 24 24"
                            fill="currentColor"
                            class="hidden w-4 h-4"
                            :class="{ 'hidden': !$store.theme.dark }"
                    >
                        <path
                                d="M12 2.25a.75.75 0 0 1 .75.75v2.25a.75.75 0 0 1-1.5 0V3a.75.75 0 0 1 .75-.75ZM7.5 12a4.5 4.5 0 1 1 9 0 4.5 4.5 0 0 1-9 0ZM18.894 6.166a.75.75 0 0 0-1.06-1.06l-1.591 1.59a.75.75 0 1 0 1.06 1.061l1.591-1.59ZM21.75 12a.75.75 0 0 1-.75.75h-2.25a.75.75 0 0 1 0-1.5H21a.75.75 0 0 1 .75.75ZM17.834 18.894a.75.75 0 0 0 1.06-1.06l-1.59-1.591a.75.75 0 1 0-1.061 1.06l1.59 1.591ZM12 18a.75.75 0 0 1 .75.75V21a.75.75 0 0 1-1.5 0v-2.25A.75.75 0 0 1 12 18ZM7.758 17.303a.75.75 0 0 0-1.061-1.06l-1.591 1.59a.75.75 0 0 0 1.06 1.061l1.591-1.59ZM6 12a.75.75 0 0 1-.75.75H3a.75.75 0 0 1 0-1.5h2.25A.75.75 0 0 1 6 12ZM6.697 7.757a.75.75 0 0 0 1.06-1.06l-1.59-1.591a.75.75 0 0 0-1.061 1.06l1.59 1.591Z"
                        />
                    </svg>
                </button>
                <button
                        id="reload"
                        type="button"
                        @click="window.location.reload()"
                        aria-label="Reload page"
                        class="text-content-secondary hover:bg-surface-hover rounded-lg text-sm p-2 text-center"
                >
                    <svg
                            xmlns="http://www.w3.org/2000/svg"
                            viewBox="0 0 24 24"
                            fill="currentColor"
                            class="w-4 h-4"
                    >
                        <path
                                fill-rule="evenodd"
                                d="M4.755 10.059a7.5 7.5 0 0 1 12.548-3.364l1.903 1.903h-3.183a.75.75 0 1 0 0 1.5h4.992a.75.75 0 0 0 .75-.75V4.356a.75.75 0 0 0-1.5 0v3.18l-1.9-1.9A9 9 0 0 0 3.306 9.67a.75.75 0 1 0 1.45.388Zm15.408 3.352a.75.75 0 0 0-.919.53 7.5 7.5 0 0 1-12.548 3.364l-1.902-1.903h3.183a.75.75 0 0 0 0-1.5H2.984a.75.75 0 0 0-.75.75v4.992a.75.75 0 0 0 1.5 0v-3.18l1.9 1.9a9 9 0 0 0 15.059-4.035.75.75 0 0 0-.53-.918Z"
                                clip-rule="evenodd"
                        />
                    </svg>
                </button>
            </div>
        </div>
    </div>
</div>
