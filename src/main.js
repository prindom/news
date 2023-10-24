import './index.css'
import Alpine from 'alpinejs'
import intersect from '@alpinejs/intersect'
import focus from '@alpinejs/focus'

import item from './item'
import themeToggle from './themeToggle'
import nav from './nav'
import list from './list'
import search from './search'
import navbutton from "./navbutton";


// redirect to same location with url param type=new if no url param type is set
if (window.location.search === '') {
    window.location = window.location.origin + "?type=new"
}


Alpine.plugin(intersect)
Alpine.plugin(focus)

window.Alpine = Alpine
Alpine.store('current', 'top')

Alpine.data('nav', nav)

Alpine.data('list', list)
Alpine.data('search', search)
Alpine.data('navbutton', navbutton)


Alpine.data('item', item)
Alpine.data('themeToggle', themeToggle)



Alpine.start()

