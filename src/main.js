import './index.css'
import Alpine from 'alpinejs'
import intersect from '@alpinejs/intersect'
import focus from '@alpinejs/focus'

import item from './item'
import themeToggle from './themeToggle'
import themeSelector from './themeSelector'
import nav from './nav'
import list from './list'
import search from './search'
import navbutton from './navbutton'

Alpine.plugin(intersect)
Alpine.plugin(focus)

window.Alpine = Alpine
Alpine.store('current', 'top')

Alpine.store('theme', {
    name: localStorage.getItem('hn-theme') || 'default',
    dark: false,

    init() {
        // Migrate old localStorage key
        const oldTheme = localStorage.getItem('color-theme')
        if (oldTheme) {
            localStorage.setItem(
                'hn-theme-mode',
                oldTheme === 'dark' ? 'dark' : 'light'
            )
            localStorage.removeItem('color-theme')
        }

        // Apply theme name
        document.documentElement.setAttribute('data-theme', this.name)

        // Determine dark/light mode
        const savedMode = localStorage.getItem('hn-theme-mode')
        if (savedMode === 'dark') {
            this.dark = true
        } else if (savedMode === 'light') {
            this.dark = false
        } else {
            this.dark = window.matchMedia(
                '(prefers-color-scheme: dark)'
            ).matches
        }

        this._applyDark()
    },

    toggleDark() {
        this.dark = !this.dark
        localStorage.setItem('hn-theme-mode', this.dark ? 'dark' : 'light')
        this._applyDark()
    },

    setTheme(name) {
        this.name = name
        localStorage.setItem('hn-theme', name)
        document.documentElement.setAttribute('data-theme', name)
    },

    _applyDark() {
        if (this.dark) {
            document.documentElement.classList.add('dark')
        } else {
            document.documentElement.classList.remove('dark')
        }
    },
})

Alpine.data('nav', nav)

Alpine.data('list', list)
Alpine.data('search', search)
Alpine.data('navbutton', navbutton)

Alpine.data('item', item)
Alpine.data('themeToggle', themeToggle)
Alpine.data('themeSelector', themeSelector)

Alpine.start()
