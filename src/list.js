export default () => ({
    items: [],
    hasServerRenderedContent: true,

    init() {
        // Check if this is a client-side navigation or initial page load
        const urlParams = new URLSearchParams(window.location.search)
        const isSearch =
            urlParams.has('query') && urlParams.get('type') === 'search'

        // For search or if no server content, load immediately
        if (isSearch || !this.hasServerRenderedContent) {
            this.load()
        }

        document.addEventListener('reload', this.load.bind(this))
    },

    reload() {
        console.log('reload')
    },

    async load() {
        // Only remove server-rendered content when doing client-side navigation
        if (!this.hasServerRenderedContent) {
            this.$el
                .querySelectorAll('article')
                .forEach((article) => article.remove())
        } else {
            // Mark that we no longer have server-rendered content after first client load
            this.hasServerRenderedContent = false
        }

        // check if search param is set
        let search = window.location.search
        let data = []
        if (search && search.includes('?type=search')) {
            // Clear server-rendered content for search
            this.$el
                .querySelectorAll('article')
                .forEach((article) => article.remove())

            const BASEURL = 'https://hn.algolia.com/api/v1/search?'
            let query = search.replace('?type=search&query', 'query')
            let url = BASEURL + query
            data = await fetch(url).then((response) => response.json())
            data = data.hits
            // map data to match hn api
            data = data.map((item) => {
                return item.objectID
            })
        } else {
            // For non-search navigation, remove server content and load fresh
            if (this.hasServerRenderedContent) {
                this.$el
                    .querySelectorAll('article')
                    .forEach((article) => article.remove())
            }

            const BASEURL = 'https://hacker-news.firebaseio.com/v0/'
            let type = this.$store.current
            let url = BASEURL + type + 'stories.json'
            data = await fetch(url).then((response) => response.json())
        }

        this.items = data
    },
})
