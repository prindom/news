export default () => ({
    items: [],

    init() {
        this.load()
        document.addEventListener('reload', this.load.bind(this))
    },

    reload() {
        console.log('reload')
    },

    async load() {
        console.log(this.$el.querySelectorAll('article'))
        this.$el.querySelectorAll('article').forEach(article => article.remove())
        // check if search param is set
        let search = window.location.search
        let data = []
        if (search && search.includes('?search')) {
            const BASEURL = 'https://hn.algolia.com/api/v1/search?'
            let query = search.replace('?search', 'query')
            let url = BASEURL + query
            data = await fetch(url).then(response => response.json())
            data = data.hits
            // map data to match hn api
            data = data.map(item => {
                return item.objectID
            })
            console.log('search data', data)
        } else {
            const BASEURL = 'https://hacker-news.firebaseio.com/v0/'
            let type = this.$store.current
            let url = BASEURL + type + 'stories.json'
            data = await fetch(url).then(response => response.json())
        }

        this.items = data
        //console.log('list items', this.items)
    }

})