{literal}
{extends file="layout.tpl"}
{block name="body"}
    <div class="max-w-4xl mx-auto p-6">
        <h1 class="text-3xl font-bold text-gray-900 dark:text-white mb-8">Select Input Component Demo</h1>
        
        <!-- Basic Select -->
        <div class="mb-8">
            <h2 class="text-xl font-semibold text-gray-800 dark:text-gray-200 mb-4">Basic Single Select</h2>
            <div 
                x-data="selectInput({
                    placeholder: 'Choose a fruit...',
                    searchable: false
                })"
                x-init="
                    options = [
                        {value: 'apple', label: 'Apple'},
                        {value: 'banana', label: 'Banana'},
                        {value: 'orange', label: 'Orange'},
                        {value: 'grape', label: 'Grape'},
                        {value: 'strawberry', label: 'Strawberry'}
                    ];
                    filteredOptions = [...options];
                "
                class="relative w-64"
            >
                <!-- Select Button -->
                <button 
                    @click="toggle()"
                    class="w-full flex items-center justify-between px-4 py-2 text-left bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                    <span x-text="displayText" class="block truncate text-gray-900 dark:text-white"></span>
                    <svg class="w-5 h-5 text-gray-400" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </button>
                
                <!-- Dropdown -->
                <div 
                    x-show="open" 
                    x-transition
                    class="absolute z-10 w-full mt-1 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-lg"
                >
                    <div class="max-h-60 overflow-auto">
                        <template x-for="(option, index) in filteredOptions" :key="option.value">
                            <button
                                @click="selectOption(option)"
                                :data-index="index"
                                class="option w-full px-4 py-2 text-left hover:bg-gray-100 dark:hover:bg-gray-700 focus:bg-gray-100 dark:focus:bg-gray-700 focus:outline-none"
                                :class="{'bg-blue-50 dark:bg-blue-900': isSelected(option)}"
                                tabindex="-1"
                            >
                                <span x-text="option.label" class="block text-gray-900 dark:text-white"></span>
                            </button>
                        </template>
                    </div>
                </div>
            </div>
        </div>

        <!-- Searchable Select -->
        <div class="mb-8">
            <h2 class="text-xl font-semibold text-gray-800 dark:text-gray-200 mb-4">Searchable Single Select</h2>
            <div 
                x-data="selectInput({
                    placeholder: 'Search and select a country...',
                    searchable: true
                })"
                x-init="
                    options = [
                        {value: 'us', label: 'United States'},
                        {value: 'uk', label: 'United Kingdom'},
                        {value: 'ca', label: 'Canada'},
                        {value: 'au', label: 'Australia'},
                        {value: 'de', label: 'Germany'},
                        {value: 'fr', label: 'France'},
                        {value: 'jp', label: 'Japan'},
                        {value: 'cn', label: 'China'},
                        {value: 'in', label: 'India'},
                        {value: 'br', label: 'Brazil'}
                    ];
                    filteredOptions = [...options];
                "
                class="relative w-64"
            >
                <!-- Select Button -->
                <button 
                    @click="toggle()"
                    class="w-full flex items-center justify-between px-4 py-2 text-left bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                    <span x-text="displayText" class="block truncate text-gray-900 dark:text-white"></span>
                    <svg class="w-5 h-5 text-gray-400" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </button>
                
                <!-- Dropdown -->
                <div 
                    x-show="open" 
                    x-transition
                    class="absolute z-10 w-full mt-1 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-lg"
                >
                    <!-- Search Input -->
                    <div x-show="searchable" class="p-2 border-b border-gray-200 dark:border-gray-600">
                        <input
                            x-model="searchQuery"
                            @input="filterOptions()"
                            class="search-input w-full px-3 py-2 text-sm border border-gray-300 dark:border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                            placeholder="Search..."
                        />
                    </div>
                    
                    <div class="max-h-60 overflow-auto">
                        <template x-for="(option, index) in filteredOptions" :key="option.value">
                            <button
                                @click="selectOption(option)"
                                :data-index="index"
                                class="option w-full px-4 py-2 text-left hover:bg-gray-100 dark:hover:bg-gray-700 focus:bg-gray-100 dark:focus:bg-gray-700 focus:outline-none"
                                :class="{'bg-blue-50 dark:bg-blue-900': isSelected(option)}"
                                tabindex="-1"
                            >
                                <span x-text="option.label" class="block text-gray-900 dark:text-white"></span>
                            </button>
                        </template>
                        <div x-show="filteredOptions.length === 0" class="px-4 py-2 text-gray-500 dark:text-gray-400">
                            No options found
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Multi Select -->
        <div class="mb-8">
            <h2 class="text-xl font-semibold text-gray-800 dark:text-gray-200 mb-4">Multi Select with Search</h2>
            <div 
                x-data="selectInput({
                    placeholder: 'Select multiple technologies...',
                    searchable: true,
                    multiple: true
                })"
                x-init="
                    options = [
                        {value: 'js', label: 'JavaScript'},
                        {value: 'ts', label: 'TypeScript'},
                        {value: 'py', label: 'Python'},
                        {value: 'java', label: 'Java'},
                        {value: 'go', label: 'Go'},
                        {value: 'rust', label: 'Rust'},
                        {value: 'php', label: 'PHP'},
                        {value: 'ruby', label: 'Ruby'},
                        {value: 'cpp', label: 'C++'},
                        {value: 'csharp', label: 'C#'}
                    ];
                    filteredOptions = [...options];
                "
                class="relative w-80"
            >
                <!-- Select Button -->
                <button 
                    @click="toggle()"
                    class="w-full flex items-center justify-between px-4 py-2 text-left bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 min-h-[42px]"
                >
                    <div class="flex flex-wrap gap-1 flex-1">
                        <template x-for="value in selectedValues" :key="value">
                            <span class="inline-flex items-center px-2 py-1 text-xs font-medium bg-blue-100 dark:bg-blue-900 text-blue-800 dark:text-blue-200 rounded">
                                <span x-text="options.find(opt => opt.value === value)?.label"></span>
                                <button @click.stop="removeSelected(value)" class="ml-1 hover:text-blue-600 dark:hover:text-blue-300">
                                    <svg class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                                    </svg>
                                </button>
                            </span>
                        </template>
                        <span x-show="selectedValues.length === 0" x-text="placeholder" class="text-gray-500 dark:text-gray-400"></span>
                    </div>
                    <svg class="w-5 h-5 text-gray-400 flex-shrink-0" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </button>
                
                <!-- Dropdown -->
                <div 
                    x-show="open" 
                    x-transition
                    class="absolute z-10 w-full mt-1 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-lg"
                >
                    <!-- Search Input -->
                    <div x-show="searchable" class="p-2 border-b border-gray-200 dark:border-gray-600">
                        <input
                            x-model="searchQuery"
                            @input="filterOptions()"
                            class="search-input w-full px-3 py-2 text-sm border border-gray-300 dark:border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                            placeholder="Search..."
                        />
                    </div>
                    
                    <div class="max-h-60 overflow-auto">
                        <template x-for="(option, index) in filteredOptions" :key="option.value">
                            <button
                                @click="selectOption(option)"
                                :data-index="index"
                                class="option w-full px-4 py-2 text-left hover:bg-gray-100 dark:hover:bg-gray-700 focus:bg-gray-100 dark:focus:bg-gray-700 focus:outline-none flex items-center"
                                :class="{'bg-blue-50 dark:bg-blue-900': isSelected(option)}"
                                tabindex="-1"
                            >
                                <input 
                                    type="checkbox" 
                                    :checked="isSelected(option)"
                                    class="mr-3 rounded border-gray-300 dark:border-gray-600"
                                    readonly
                                />
                                <span x-text="option.label" class="block text-gray-900 dark:text-white"></span>
                            </button>
                        </template>
                        <div x-show="filteredOptions.length === 0" class="px-4 py-2 text-gray-500 dark:text-gray-400">
                            No options found
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- URL Data Source -->
        <div class="mb-8">
            <h2 class="text-xl font-semibold text-gray-800 dark:text-gray-200 mb-4">URL Data Source (JSONPlaceholder)</h2>
            <div 
                x-data="selectInput({
                    url: 'https://jsonplaceholder.typicode.com/users',
                    placeholder: 'Select a user...',
                    searchable: true,
                    displayField: 'name',
                    valueField: 'id'
                })"
                class="relative w-80"
            >
                <!-- Select Button -->
                <button 
                    @click="toggle()"
                    class="w-full flex items-center justify-between px-4 py-2 text-left bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                    <span x-text="displayText" class="block truncate text-gray-900 dark:text-white"></span>
                    <svg class="w-5 h-5 text-gray-400" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </button>
                
                <!-- Loading indicator -->
                <div x-show="loading" class="absolute inset-0 bg-white dark:bg-gray-800 bg-opacity-75 flex items-center justify-center rounded-md">
                    <svg class="animate-spin h-5 w-5 text-blue-500" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                </div>
                
                <!-- Dropdown -->
                <div 
                    x-show="open" 
                    x-transition
                    class="absolute z-10 w-full mt-1 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-lg"
                >
                    <!-- Search Input -->
                    <div x-show="searchable" class="p-2 border-b border-gray-200 dark:border-gray-600">
                        <input
                            x-model="searchQuery"
                            @input="filterOptions()"
                            class="search-input w-full px-3 py-2 text-sm border border-gray-300 dark:border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                            placeholder="Search users..."
                        />
                    </div>
                    
                    <div class="max-h-60 overflow-auto">
                        <template x-for="(option, index) in filteredOptions" :key="option.id">
                            <button
                                @click="selectOption(option)"
                                :data-index="index"
                                class="option w-full px-4 py-2 text-left hover:bg-gray-100 dark:hover:bg-gray-700 focus:bg-gray-100 dark:focus:bg-gray-700 focus:outline-none"
                                :class="{'bg-blue-50 dark:bg-blue-900': isSelected(option)}"
                                tabindex="-1"
                            >
                                <div>
                                    <div x-text="option.name" class="font-medium text-gray-900 dark:text-white"></div>
                                    <div x-text="option.email" class="text-sm text-gray-500 dark:text-gray-400"></div>
                                </div>
                            </button>
                        </template>
                        <div x-show="filteredOptions.length === 0 && !loading" class="px-4 py-2 text-gray-500 dark:text-gray-400">
                            No options found
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Event Handling Demo -->
        <div class="mb-8">
            <h2 class="text-xl font-semibold text-gray-800 dark:text-gray-200 mb-4">Event Handling</h2>
            <div x-data="{ selectedValue: null, eventLog: [] }">
                <div 
                    x-data="selectInput({
                        placeholder: 'Select to see events...',
                        searchable: true
                    })"
                    x-init="
                        options = [
                            {value: 'event1', label: 'Event One'},
                            {value: 'event2', label: 'Event Two'},
                            {value: 'event3', label: 'Event Three'}
                        ];
                        filteredOptions = [...options];
                    "
                    @change="selectedValue = $event.detail.value; eventLog.unshift({
                        timestamp: new Date().toLocaleTimeString(),
                        value: $event.detail.value,
                        option: $event.detail.option
                    })"
                    class="relative w-64 mb-4"
                >
                    <!-- Select Button -->
                    <button 
                        @click="toggle()"
                        class="w-full flex items-center justify-between px-4 py-2 text-left bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                    >
                        <span x-text="displayText" class="block truncate text-gray-900 dark:text-white"></span>
                        <svg class="w-5 h-5 text-gray-400" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                        </svg>
                    </button>
                    
                    <!-- Dropdown -->
                    <div 
                        x-show="open" 
                        x-transition
                        class="absolute z-10 w-full mt-1 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-lg"
                    >
                        <!-- Search Input -->
                        <div x-show="searchable" class="p-2 border-b border-gray-200 dark:border-gray-600">
                            <input
                                x-model="searchQuery"
                                @input="filterOptions()"
                                class="search-input w-full px-3 py-2 text-sm border border-gray-300 dark:border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                                placeholder="Search..."
                            />
                        </div>
                        
                        <div class="max-h-60 overflow-auto">
                            <template x-for="(option, index) in filteredOptions" :key="option.value">
                                <button
                                    @click="selectOption(option)"
                                    :data-index="index"
                                    class="option w-full px-4 py-2 text-left hover:bg-gray-100 dark:hover:bg-gray-700 focus:bg-gray-100 dark:focus:bg-gray-700 focus:outline-none"
                                    :class="{'bg-blue-50 dark:bg-blue-900': isSelected(option)}"
                                    tabindex="-1"
                                >
                                    <span x-text="option.label" class="block text-gray-900 dark:text-white"></span>
                                </button>
                            </template>
                        </div>
                    </div>
                </div>

                <div class="bg-gray-50 dark:bg-gray-900 p-4 rounded-md">
                    <h3 class="font-medium text-gray-900 dark:text-white mb-2">Selected Value:</h3>
                    <code x-text="selectedValue || 'None'" class="text-sm text-gray-700 dark:text-gray-300"></code>
                    
                    <h3 class="font-medium text-gray-900 dark:text-white mb-2 mt-4">Event Log:</h3>
                    <div class="text-sm space-y-1 max-h-32 overflow-auto">
                        <template x-for="event in eventLog.slice(0, 5)" :key="event.timestamp">
                            <div class="text-gray-700 dark:text-gray-300">
                                <span x-text="event.timestamp" class="text-gray-500 dark:text-gray-400"></span> - 
                                Selected: <code x-text="event.option.label"></code> (value: <code x-text="event.value"></code>)
                            </div>
                        </template>
                        <div x-show="eventLog.length === 0" class="text-gray-500 dark:text-gray-400">
                            No events yet
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}
{/literal}
                <!-- Select Button -->
                <button 
                    @click="toggle()"
                    class="w-full flex items-center justify-between px-4 py-2 text-left bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                    <span x-text="displayText" class="block truncate text-gray-900 dark:text-white"></span>
                    <svg class="w-5 h-5 text-gray-400" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </button>
                
                <!-- Dropdown -->
                <div 
                    x-show="open" 
                    x-transition
                    class="absolute z-10 w-full mt-1 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-lg"
                >
                    <div class="max-h-60 overflow-auto">
                        <template x-for="(option, index) in filteredOptions" :key="option.value">
                            <button
                                @click="selectOption(option)"
                                :data-index="index"
                                class="option w-full px-4 py-2 text-left hover:bg-gray-100 dark:hover:bg-gray-700 focus:bg-gray-100 dark:focus:bg-gray-700 focus:outline-none"
                                :class="{'bg-blue-50 dark:bg-blue-900': isSelected(option)}"
                                tabindex="-1"
                            >
                                <span x-text="option.label" class="block text-gray-900 dark:text-white"></span>
                            </button>
                        </template>
                    </div>
                </div>
            </div>
        </div>

        <!-- Searchable Select -->
        <div class="mb-8">
            <h2 class="text-xl font-semibold text-gray-800 dark:text-gray-200 mb-4">Searchable Single Select</h2>
            <div 
                x-data="selectInput({
                    placeholder: 'Search and select a country...',
                    searchable: true
                })"
                x-init="
                    options = [
                        {value: 'us', label: 'United States'},
                        {value: 'uk', label: 'United Kingdom'},
                        {value: 'ca', label: 'Canada'},
                        {value: 'au', label: 'Australia'},
                        {value: 'de', label: 'Germany'},
                        {value: 'fr', label: 'France'},
                        {value: 'jp', label: 'Japan'},
                        {value: 'cn', label: 'China'},
                        {value: 'in', label: 'India'},
                        {value: 'br', label: 'Brazil'}
                    ];
                    filteredOptions = [...options];
                "
                class="relative w-64"
            >
                <!-- Select Button -->
                <button 
                    @click="toggle()"
                    class="w-full flex items-center justify-between px-4 py-2 text-left bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                    <span x-text="displayText" class="block truncate text-gray-900 dark:text-white"></span>
                    <svg class="w-5 h-5 text-gray-400" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </button>
                
                <!-- Dropdown -->
                <div 
                    x-show="open" 
                    x-transition
                    class="absolute z-10 w-full mt-1 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-lg"
                >
                    <!-- Search Input -->
                    <div x-show="searchable" class="p-2 border-b border-gray-200 dark:border-gray-600">
                        <input
                            x-model="searchQuery"
                            @input="filterOptions()"
                            class="search-input w-full px-3 py-2 text-sm border border-gray-300 dark:border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                            placeholder="Search..."
                        />
                    </div>
                    
                    <div class="max-h-60 overflow-auto">
                        <template x-for="(option, index) in filteredOptions" :key="option.value">
                            <button
                                @click="selectOption(option)"
                                :data-index="index"
                                class="option w-full px-4 py-2 text-left hover:bg-gray-100 dark:hover:bg-gray-700 focus:bg-gray-100 dark:focus:bg-gray-700 focus:outline-none"
                                :class="{'bg-blue-50 dark:bg-blue-900': isSelected(option)}"
                                tabindex="-1"
                            >
                                <span x-text="option.label" class="block text-gray-900 dark:text-white"></span>
                            </button>
                        </template>
                        <div x-show="filteredOptions.length === 0" class="px-4 py-2 text-gray-500 dark:text-gray-400">
                            No options found
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Multi Select -->
        <div class="mb-8">
            <h2 class="text-xl font-semibold text-gray-800 dark:text-gray-200 mb-4">Multi Select with Search</h2>
            <div 
                x-data="selectInput({
                    placeholder: 'Select multiple technologies...',
                    searchable: true,
                    multiple: true
                })"
                x-init="
                    options = [
                        {value: 'js', label: 'JavaScript'},
                        {value: 'ts', label: 'TypeScript'},
                        {value: 'py', label: 'Python'},
                        {value: 'java', label: 'Java'},
                        {value: 'go', label: 'Go'},
                        {value: 'rust', label: 'Rust'},
                        {value: 'php', label: 'PHP'},
                        {value: 'ruby', label: 'Ruby'},
                        {value: 'cpp', label: 'C++'},
                        {value: 'csharp', label: 'C#'}
                    ];
                    filteredOptions = [...options];
                "
                class="relative w-80"
            >
                <!-- Select Button -->
                <button 
                    @click="toggle()"
                    class="w-full flex items-center justify-between px-4 py-2 text-left bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500 min-h-[42px]"
                >
                    <div class="flex flex-wrap gap-1 flex-1">
                        <template x-for="value in selectedValues" :key="value">
                            <span class="inline-flex items-center px-2 py-1 text-xs font-medium bg-blue-100 dark:bg-blue-900 text-blue-800 dark:text-blue-200 rounded">
                                <span x-text="options.find(opt => opt.value === value)?.label"></span>
                                <button @click.stop="removeSelected(value)" class="ml-1 hover:text-blue-600 dark:hover:text-blue-300">
                                    <svg class="w-3 h-3" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd"></path>
                                    </svg>
                                </button>
                            </span>
                        </template>
                        <span x-show="selectedValues.length === 0" x-text="placeholder" class="text-gray-500 dark:text-gray-400"></span>
                    </div>
                    <svg class="w-5 h-5 text-gray-400 flex-shrink-0" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </button>
                
                <!-- Dropdown -->
                <div 
                    x-show="open" 
                    x-transition
                    class="absolute z-10 w-full mt-1 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-lg"
                >
                    <!-- Search Input -->
                    <div x-show="searchable" class="p-2 border-b border-gray-200 dark:border-gray-600">
                        <input
                            x-model="searchQuery"
                            @input="filterOptions()"
                            class="search-input w-full px-3 py-2 text-sm border border-gray-300 dark:border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                            placeholder="Search..."
                        />
                    </div>
                    
                    <div class="max-h-60 overflow-auto">
                        <template x-for="(option, index) in filteredOptions" :key="option.value">
                            <button
                                @click="selectOption(option)"
                                :data-index="index"
                                class="option w-full px-4 py-2 text-left hover:bg-gray-100 dark:hover:bg-gray-700 focus:bg-gray-100 dark:focus:bg-gray-700 focus:outline-none flex items-center"
                                :class="{'bg-blue-50 dark:bg-blue-900': isSelected(option)}"
                                tabindex="-1"
                            >
                                <input 
                                    type="checkbox" 
                                    :checked="isSelected(option)"
                                    class="mr-3 rounded border-gray-300 dark:border-gray-600"
                                    readonly
                                />
                                <span x-text="option.label" class="block text-gray-900 dark:text-white"></span>
                            </button>
                        </template>
                        <div x-show="filteredOptions.length === 0" class="px-4 py-2 text-gray-500 dark:text-gray-400">
                            No options found
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- URL Data Source -->
        <div class="mb-8">
            <h2 class="text-xl font-semibold text-gray-800 dark:text-gray-200 mb-4">URL Data Source (JSONPlaceholder)</h2>
            <div 
                x-data="selectInput({
                    url: 'https://jsonplaceholder.typicode.com/users',
                    placeholder: 'Select a user...',
                    searchable: true,
                    displayField: 'name',
                    valueField: 'id'
                })"
                class="relative w-80"
            >
                <!-- Select Button -->
                <button 
                    @click="toggle()"
                    class="w-full flex items-center justify-between px-4 py-2 text-left bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                >
                    <span x-text="displayText" class="block truncate text-gray-900 dark:text-white"></span>
                    <svg class="w-5 h-5 text-gray-400" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                    </svg>
                </button>
                
                <!-- Loading indicator -->
                <div x-show="loading" class="absolute inset-0 bg-white dark:bg-gray-800 bg-opacity-75 flex items-center justify-center rounded-md">
                    <svg class="animate-spin h-5 w-5 text-blue-500" fill="none" viewBox="0 0 24 24">
                        <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                        <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                    </svg>
                </div>
                
                <!-- Dropdown -->
                <div 
                    x-show="open" 
                    x-transition
                    class="absolute z-10 w-full mt-1 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-lg"
                >
                    <!-- Search Input -->
                    <div x-show="searchable" class="p-2 border-b border-gray-200 dark:border-gray-600">
                        <input
                            x-model="searchQuery"
                            @input="filterOptions()"
                            class="search-input w-full px-3 py-2 text-sm border border-gray-300 dark:border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                            placeholder="Search users..."
                        />
                    </div>
                    
                    <div class="max-h-60 overflow-auto">
                        <template x-for="(option, index) in filteredOptions" :key="option.id">
                            <button
                                @click="selectOption(option)"
                                :data-index="index"
                                class="option w-full px-4 py-2 text-left hover:bg-gray-100 dark:hover:bg-gray-700 focus:bg-gray-100 dark:focus:bg-gray-700 focus:outline-none"
                                :class="{'bg-blue-50 dark:bg-blue-900': isSelected(option)}"
                                tabindex="-1"
                            >
                                <div>
                                    <div x-text="option.name" class="font-medium text-gray-900 dark:text-white"></div>
                                    <div x-text="option.email" class="text-sm text-gray-500 dark:text-gray-400"></div>
                                </div>
                            </button>
                        </template>
                        <div x-show="filteredOptions.length === 0 && !loading" class="px-4 py-2 text-gray-500 dark:text-gray-400">
                            No options found
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Event Handling Demo -->
        <div class="mb-8">
            <h2 class="text-xl font-semibold text-gray-800 dark:text-gray-200 mb-4">Event Handling</h2>
            <div x-data="{ selectedValue: null, eventLog: [] }">
                <div 
                    x-data="selectInput({
                        placeholder: 'Select to see events...',
                        searchable: true
                    })"
                    x-init="
                        options = [
                            {value: 'event1', label: 'Event One'},
                            {value: 'event2', label: 'Event Two'},
                            {value: 'event3', label: 'Event Three'}
                        ];
                        filteredOptions = [...options];
                    "
                    @change="selectedValue = $event.detail.value; eventLog.unshift({
                        timestamp: new Date().toLocaleTimeString(),
                        value: $event.detail.value,
                        option: $event.detail.option
                    })"
                    class="relative w-64 mb-4"
                >
                    <!-- Select Button -->
                    <button 
                        @click="toggle()"
                        class="w-full flex items-center justify-between px-4 py-2 text-left bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-blue-500"
                    >
                        <span x-text="displayText" class="block truncate text-gray-900 dark:text-white"></span>
                        <svg class="w-5 h-5 text-gray-400" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
                        </svg>
                    </button>
                    
                    <!-- Dropdown -->
                    <div 
                        x-show="open" 
                        x-transition
                        class="absolute z-10 w-full mt-1 bg-white dark:bg-gray-800 border border-gray-300 dark:border-gray-600 rounded-md shadow-lg"
                    >
                        <!-- Search Input -->
                        <div x-show="searchable" class="p-2 border-b border-gray-200 dark:border-gray-600">
                            <input
                                x-model="searchQuery"
                                @input="filterOptions()"
                                class="search-input w-full px-3 py-2 text-sm border border-gray-300 dark:border-gray-600 rounded-md focus:outline-none focus:ring-2 focus:ring-blue-500 bg-white dark:bg-gray-700 text-gray-900 dark:text-white"
                                placeholder="Search..."
                            />
                        </div>
                        
                        <div class="max-h-60 overflow-auto">
                            <template x-for="(option, index) in filteredOptions" :key="option.value">
                                <button
                                    @click="selectOption(option)"
                                    :data-index="index"
                                    class="option w-full px-4 py-2 text-left hover:bg-gray-100 dark:hover:bg-gray-700 focus:bg-gray-100 dark:focus:bg-gray-700 focus:outline-none"
                                    :class="{'bg-blue-50 dark:bg-blue-900': isSelected(option)}"
                                    tabindex="-1"
                                >
                                    <span x-text="option.label" class="block text-gray-900 dark:text-white"></span>
                                </button>
                            </template>
                        </div>
                    </div>
                </div>

                <div class="bg-gray-50 dark:bg-gray-900 p-4 rounded-md">
                    <h3 class="font-medium text-gray-900 dark:text-white mb-2">Selected Value:</h3>
                    <code x-text="selectedValue || 'None'" class="text-sm text-gray-700 dark:text-gray-300"></code>
                    
                    <h3 class="font-medium text-gray-900 dark:text-white mb-2 mt-4">Event Log:</h3>
                    <div class="text-sm space-y-1 max-h-32 overflow-auto">
                        <template x-for="event in eventLog.slice(0, 5)" :key="event.timestamp">
                            <div class="text-gray-700 dark:text-gray-300">
                                <span x-text="event.timestamp" class="text-gray-500 dark:text-gray-400"></span> - 
                                Selected: <code x-text="event.option.label"></code> (value: <code x-text="event.value"></code>)
                            </div>
                        </template>
                        <div x-show="eventLog.length === 0" class="text-gray-500 dark:text-gray-400">
                            No events yet
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/block}