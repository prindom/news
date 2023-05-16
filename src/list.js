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
        const BASEURL = 'https://hacker-news.firebaseio.com/v0/'
        let type = this.$store.current
        let url = BASEURL + type + 'stories.json'
        let data = await fetch(url).then(response => response.json())
        this.items = data
        //console.log('list items', this.items)
    }

})