# Select Input Web Component

A powerful and flexible select input component built with Alpine.js that supports URL data fetching, searching, and both single and multi-select modes.

## Features

- ✅ **Single Select Mode**: Traditional dropdown selection
- ✅ **Multi-Select Mode**: Select multiple options with tag display
- ✅ **Search Functionality**: Optional search field to filter options
- ✅ **URL Data Loading**: Fetch options from any API endpoint
- ✅ **Custom Events**: Emits change events for integration
- ✅ **Keyboard Navigation**: Full keyboard support (Arrow keys, Escape, Enter)
- ✅ **Loading States**: Built-in loading indicators
- ✅ **Responsive Design**: Tailwind CSS styling with dark mode support
- ✅ **Configurable Fields**: Customize display and value fields

## Installation

1. Include the component in your Alpine.js setup:

```javascript
// In your main.js
import selectInput from './selectInput'
Alpine.data('selectInput', selectInput)
```

2. Make sure you have Alpine.js and Tailwind CSS installed.

## Basic Usage

### Single Select

```html
<div 
    x-data="selectInput({
        placeholder: 'Choose an option...',
        searchable: false
    })"
    x-init="
        options = [
            {value: 'option1', label: 'Option 1'},
            {value: 'option2', label: 'Option 2'},
            {value: 'option3', label: 'Option 3'}
        ];
        filteredOptions = [...options];
    "
    class="relative w-64"
>
    <!-- Select Button -->
    <button 
        @click="toggle()"
        class="w-full flex items-center justify-between px-4 py-2 text-left bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500"
    >
        <span x-text="displayText" class="block truncate"></span>
        <svg class="w-5 h-5 text-gray-400" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
        </svg>
    </button>
    
    <!-- Dropdown -->
    <div 
        x-show="open" 
        x-transition
        class="absolute z-10 w-full mt-1 bg-white border border-gray-300 rounded-md shadow-lg"
    >
        <div class="max-h-60 overflow-auto">
            <template x-for="(option, index) in filteredOptions" :key="option.value">
                <button
                    @click="selectOption(option)"
                    class="w-full px-4 py-2 text-left hover:bg-gray-100 focus:outline-none"
                    :class="{'bg-blue-50': isSelected(option)}"
                >
                    <span x-text="option.label"></span>
                </button>
            </template>
        </div>
    </div>
</div>
```

### Multi-Select

```html
<div 
    x-data="selectInput({
        placeholder: 'Select multiple items...',
        searchable: true,
        multiple: true
    })"
    x-init="/* your options */"
    class="relative w-80"
>
    <!-- Multi-select button with tags -->
    <button 
        @click="toggle()"
        class="w-full flex items-center justify-between px-4 py-2 text-left bg-white border border-gray-300 rounded-md shadow-sm focus:outline-none focus:ring-2 focus:ring-blue-500 min-h-[42px]"
    >
        <div class="flex flex-wrap gap-1 flex-1">
            <template x-for="value in selectedValues" :key="value">
                <span class="inline-flex items-center px-2 py-1 text-xs font-medium bg-blue-100 text-blue-800 rounded">
                    <span x-text="options.find(opt => opt.value === value)?.label"></span>
                    <button @click.stop="removeSelected(value)" class="ml-1 hover:text-blue-600">×</button>
                </span>
            </template>
            <span x-show="selectedValues.length === 0" x-text="placeholder" class="text-gray-500"></span>
        </div>
        <svg class="w-5 h-5 text-gray-400 flex-shrink-0" :class="{'rotate-180': open}" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M19 9l-7 7-7-7"></path>
        </svg>
    </button>
    <!-- Dropdown with checkboxes -->
</div>
```

### URL Data Source

```html
<div 
    x-data="selectInput({
        url: '/api/users',
        placeholder: 'Select a user...',
        searchable: true,
        displayField: 'name',
        valueField: 'id'
    })"
    class="relative w-64"
>
    <!-- Component automatically loads data from URL -->
</div>
```

## Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `url` | string | `''` | URL to fetch options from |
| `searchable` | boolean | `true` | Enable/disable search functionality |
| `multiple` | boolean | `false` | Enable multi-select mode |
| `placeholder` | string | `'Select an option...'` | Placeholder text |
| `displayField` | string | `'label'` | Field to display in options |
| `valueField` | string | `'value'` | Field to use as value |

## Event Handling

The component emits a custom `change` event when selections are made:

```html
<div 
    x-data="selectInput(config)"
    @change="handleChange($event)"
>
    <!-- component template -->
</div>

<script>
function handleChange(event) {
    console.log('Selected value:', event.detail.value);
    console.log('Selected option:', event.detail.option);
    console.log('Is multiple:', event.detail.multiple);
}
</script>
```

## Methods

| Method | Description |
|--------|-------------|
| `toggle()` | Toggle dropdown open/closed |
| `open()` | Open dropdown |
| `close()` | Close dropdown |
| `selectOption(option)` | Select an option |
| `removeSelected(value)` | Remove selected value (multi-select) |
| `clearAll()` | Clear all selections |
| `loadData()` | Reload data from URL |

## Data Format

### Expected JSON Format

```json
[
    {"value": "1", "label": "Option 1"},
    {"value": "2", "label": "Option 2"}
]
```

Or with custom fields:

```json
[
    {"id": 1, "name": "John Doe", "email": "john@example.com"},
    {"id": 2, "name": "Jane Smith", "email": "jane@example.com"}
]
```

The component also supports nested data responses:
- `data.data` (common API pattern)
- `data.results` (another common pattern)

## Styling

The component uses Tailwind CSS classes and supports dark mode. You can customize the styling by modifying the CSS classes in the template.

### Dark Mode Support

All components automatically support dark mode when using Tailwind's dark mode classes:

```css
class="bg-white dark:bg-gray-800 text-gray-900 dark:text-white"
```

## Examples

See the demo page at `/demo.html` for complete examples of all features:

1. Basic single select
2. Searchable single select  
3. Multi-select with search
4. URL data source
5. Event handling

## Browser Support

- Modern browsers supporting ES6+
- Requires Alpine.js 3.x
- Requires Tailwind CSS for styling