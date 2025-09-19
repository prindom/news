export default () => ({
    items: [],
    hasServerRenderedContent: true,

    init() {
        // Check if this is a client-side navigation or initial page load
        const urlParams = new URLSearchParams(window.location.search)
        const isSearch =
            urlParams.has('query') && urlParams.get('type') === 'search'

        // For search, always load immediately (replaces server content)
        if (isSearch) {
            this.load()
        }

        document.addEventListener('reload', this.load.bind(this))
    },

    reload() {
        console.log('reload')
    },

    async load() {
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
            this.hasServerRenderedContent = false
        } else {
            // For regular navigation
            if (this.hasServerRenderedContent) {
                // First client-side load: only load articles that aren't already rendered
                const BASEURL = 'https://hacker-news.firebaseio.com/v0/'
                let type = this.$store.current
                let url = BASEURL + type + 'stories.json'
                let allData = await fetch(url).then((response) =>
                    response.json()
                )

                // Filter out articles that were already rendered server-side
                const serverRenderedIds = this.$store.serverRenderedIds || []
                data = allData.filter((id) => !serverRenderedIds.includes(id))

                this.hasServerRenderedContent = false
            } else {
                // Subsequent client-side loads: remove all and load fresh
                this.$el
                    .querySelectorAll('article')
                    .forEach((article) => article.remove())

                const BASEURL = 'https://hacker-news.firebaseio.com/v0/'
                let type = this.$store.current
                let url = BASEURL + type + 'stories.json'
                data = await fetch(url).then((response) => response.json())
            }
        }

        this.items = data
    },
})
