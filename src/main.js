import './index.css'
import Alpine from 'alpinejs'
import intersect from '@alpinejs/intersect'
import focus from '@alpinejs/focus'

import item from './item'
import themeToggle from './themeToggle'
import nav from './nav'
import list from './list'
import search from './search'
import navbutton from './navbutton'
import selectInput from './selectInput'

Alpine.plugin(intersect)
Alpine.plugin(focus)

window.Alpine = Alpine
Alpine.store('current', 'top')

Alpine.data('nav', nav)

Alpine.data('list', list)
Alpine.data('search', search)
Alpine.data('navbutton', navbutton)
Alpine.data('selectInput', selectInput)

Alpine.data('item', item)
Alpine.data('themeToggle', themeToggle)

Alpine.start()
