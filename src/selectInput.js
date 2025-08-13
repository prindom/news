export default (config = {}) => ({
    // Configuration options
    url: config.url || '',
    searchable: config.searchable !== false, // default true
    multiple: config.multiple || false,
    placeholder: config.placeholder || 'Select an option...',
    displayField: config.displayField || 'label',
    valueField: config.valueField || 'value',
    
    // Component state
    open: false,
    loading: false,
    options: [],
    filteredOptions: [],
    searchQuery: '',
    selectedValues: [],
    selectedValue: null,
    
    // Computed properties
    get selectedLabels() {
        if (this.multiple) {
            return this.selectedValues.map(value => {
                const option = this.options.find(opt => opt[this.valueField] === value);
                return option ? option[this.displayField] : value;
            });
        }
        const option = this.options.find(opt => opt[this.valueField] === this.selectedValue);
        return option ? option[this.displayField] : '';
    },
    
    get displayText() {
        if (this.multiple) {
            if (this.selectedValues.length === 0) return this.placeholder;
            if (this.selectedValues.length === 1) return this.selectedLabels[0];
            return `${this.selectedValues.length} items selected`;
        }
        return this.selectedValue ? this.selectedLabels : this.placeholder;
    },
    
    async init() {
        // Load data from URL if provided
        if (this.url) {
            await this.loadData();
        }
        
        // Handle clicks outside to close dropdown
        document.addEventListener('click', (event) => {
            if (!this.$el.contains(event.target)) {
                this.close();
            }
        });
        
        // Handle keyboard navigation
        this.$el.addEventListener('keydown', this.handleKeydown.bind(this));
    },
    
    async loadData() {
        if (!this.url) return;
        
        this.loading = true;
        try {
            const response = await fetch(this.url);
            const data = await response.json();
            
            // Handle both array and object responses
            if (Array.isArray(data)) {
                this.options = data;
            } else if (data.data && Array.isArray(data.data)) {
                this.options = data.data;
            } else if (data.results && Array.isArray(data.results)) {
                this.options = data.results;
            } else {
                console.warn('Unexpected data format from URL:', data);
                this.options = [];
            }
            
            this.filteredOptions = [...this.options];
        } catch (error) {
            console.error('Error loading data from URL:', error);
            this.options = [];
            this.filteredOptions = [];
        } finally {
            this.loading = false;
        }
    },
    
    toggle() {
        if (this.open) {
            this.close();
        } else {
            this.openDropdown();
        }
    },
    
    openDropdown() {
        this.open = true;
        this.filterOptions();
        // Focus search input if searchable
        if (this.searchable) {
            this.$nextTick(() => {
                const searchInput = this.$el.querySelector('.search-input');
                if (searchInput) searchInput.focus();
            });
        }
    },
    
    close() {
        this.open = false;
        this.searchQuery = '';
        this.filterOptions();
    },
    
    filterOptions() {
        if (!this.searchQuery.trim()) {
            this.filteredOptions = [...this.options];
            return;
        }
        
        const query = this.searchQuery.toLowerCase();
        this.filteredOptions = this.options.filter(option => {
            const label = String(option[this.displayField] || '').toLowerCase();
            const value = String(option[this.valueField] || '').toLowerCase();
            return label.includes(query) || value.includes(query);
        });
    },
    
    selectOption(option) {
        const value = option[this.valueField];
        
        if (this.multiple) {
            const index = this.selectedValues.indexOf(value);
            if (index === -1) {
                this.selectedValues.push(value);
            } else {
                this.selectedValues.splice(index, 1);
            }
            // Don't close dropdown in multiple mode
        } else {
            this.selectedValue = value;
            this.close();
        }
        
        // Emit custom event for parent components
        this.$el.dispatchEvent(new CustomEvent('change', {
            detail: {
                value: this.multiple ? this.selectedValues : this.selectedValue,
                option: option,
                multiple: this.multiple
            },
            bubbles: true
        }));
    },
    
    isSelected(option) {
        const value = option[this.valueField];
        if (this.multiple) {
            return this.selectedValues.includes(value);
        }
        return this.selectedValue === value;
    },
    
    removeSelected(value) {
        if (this.multiple) {
            const index = this.selectedValues.indexOf(value);
            if (index !== -1) {
                this.selectedValues.splice(index, 1);
            }
        } else {
            this.selectedValue = null;
        }
    },
    
    clearAll() {
        if (this.multiple) {
            this.selectedValues = [];
        } else {
            this.selectedValue = null;
        }
    },
    
    handleKeydown(event) {
        if (!this.open) {
            if (event.key === 'Enter' || event.key === ' ') {
                event.preventDefault();
                this.openDropdown();
            }
            return;
        }
        
        switch (event.key) {
            case 'Escape':
                event.preventDefault();
                this.close();
                break;
            case 'ArrowDown':
                event.preventDefault();
                this.focusNext();
                break;
            case 'ArrowUp':
                event.preventDefault();
                this.focusPrevious();
                break;
            case 'Enter':
                event.preventDefault();
                const focused = this.$el.querySelector('.option:focus');
                if (focused) {
                    const index = parseInt(focused.dataset.index);
                    if (!isNaN(index) && this.filteredOptions[index]) {
                        this.selectOption(this.filteredOptions[index]);
                    }
                }
                break;
        }
    },
    
    focusNext() {
        const options = this.$el.querySelectorAll('.option');
        const focused = this.$el.querySelector('.option:focus');
        let index = 0;
        
        if (focused) {
            index = Array.from(options).indexOf(focused) + 1;
        }
        
        if (index >= options.length) index = 0;
        if (options[index]) options[index].focus();
    },
    
    focusPrevious() {
        const options = this.$el.querySelectorAll('.option');
        const focused = this.$el.querySelector('.option:focus');
        let index = options.length - 1;
        
        if (focused) {
            index = Array.from(options).indexOf(focused) - 1;
        }
        
        if (index < 0) index = options.length - 1;
        if (options[index]) options[index].focus();
    }
});