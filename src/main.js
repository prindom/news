import './index.css'
import Alpine from 'alpinejs'
import intersect from '@alpinejs/intersect'

import item from './item'
import themeToggle from './themeToggle'
import nav from './nav'
import list from './list'


// redirect to same location with url param type=new if no url param type is set
if (window.location.search === '') {
    window.location = window.location.origin + "?type=new"
}


Alpine.plugin(intersect)

window.Alpine = Alpine
Alpine.store('current', 'top')

Alpine.data('nav', nav)

Alpine.data('list', list)


Alpine.data('item', item)
Alpine.data('themeToggle', themeToggle)



Alpine.start()