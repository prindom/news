export default (initialID = null) => ({
    open: false,
    id: initialID,
    title: 'loading...',
    url: '',
    score: 0,
    by: 'author',
    time: 0,
    descendants: 0,
    text: '',
    by_url() {
        return 'https://news.ycombinator.com/user?id=' + this.by
    },

    toggle() {
        this.open = !this.open
    },


    async init() {
        //console.log('item init')
        //if (this.id) {
        //    console.log('item id:', this.id)
        //    let url = 'https://hacker-news.firebaseio.com/v0/item/' + this.id + '.json'
        //    let data = await fetch(url).then(response => response.json())
        //    this.handleData(data)
        //}
    },

    handleData(data) {
        console.log('handleData', data, this)
        this.title = data.title
        this.url = data.url
        this.score = data.score
        this.by = data.by
        this.time = data.time
        this.descendants = data.descendants
        if (data.text) {
            let element = document.createElement('div')
            element.innerHTML = data.text
            this.text = element.innerText
        }
    },

    async loadFull() {
    
        if (this.id) {
            console.log('item id:', this.id)
            let url = 'https://hacker-news.firebaseio.com/v0/item/' + this.id + '.json'
            let data = await fetch(url).then(response => response.json())
            this.handleData(data)
        }

    },

})