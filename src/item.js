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
    meta_image: '',

    toggle() {
        this.open = !this.open
    },


    async init() {
        if (this.id == null) {
            this.id = new URLSearchParams(window.location.search).get('id')
            this.loadWithChildren()
        }
    },

    handleData(data) {
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
        } else {
            this.text = this.url
        }

        if (this.url) {
            const encodedUrl = encodeURIComponent(this.url)
            /*fetch("https://news.redslate.net/getMetaData.php?url="+encodedUrl).then(response => {
                let image = new DOMParser().parseFromString(response.text(), 'text/html').querySelector('meta[property="og:image"]').getAttribute('content')
                console.log(image)
                this.image = image
            })*/
        }
    },

    async loadFull() {

        if (this.id) {
            let url = 'https://hacker-news.firebaseio.com/v0/item/' + this.id + '.json'
            let data = await fetch(url).then(response => response.json())
            this.handleData(data)
        }

    },

    loadWithChildren() {
        if (!this.id)
            return
        let url = "https://hn.algolia.com/api/v1/items/:id".replace(":id", this.id)
        fetch(url).then(response => response.json()).then(data => {
            Alpine.store('itemID', data.objectID)
            // map all fields to match hn api
            this.id = data.objectID
            this.title = data.title
            this.url = data.url
            this.score = data.points
            this.by = data.author
            this.time = data.created_at_i
            this.descendants = data.children.length
            if (data.text) {
                let element = document.createElement('div')
                element.innerHTML = data.text
                this.text = element.innerText
            } else {
                this.text = this.url
            }
            this.children = data.children
            this.printComments(data.children, document.querySelector('#comments'))
        })
    },
    printComments(comments, target, hidden = false) {
        // recursively print comments for this children
        if (!comments)
            return
        comments.forEach(child => {
            // create a list item for each comment
            // if it has children, create new ul and call printComments
            let li = document.createElement('li')
            li.classList.add('comment', 'border-l-2', 'border-gray-200', 'dark:border-gray-700', 'pl-4', 'py-2', 'mb-2')
            if (child.children.length > 0) {
                let span = document.createElement('span')
                span.innerHTML = unescape(child.text)

                let button = document.createElement('button')
                button.innerText = 'hide replies'
                button.classList.add('ml-2','inline-block', 'rounded-md', 'px-4', 'py-2', 'text-sm', 'focus:relative', 'text-gray-500', 'hover:text-gray-700', 'dark:text-gray-400', 'dark:hover:text-gray-200', 'focus:text-white', 'bg-gray-200','dark:bg-gray-800')

                let authorA = document.createElement('a')
                authorA.href = 'https://news.ycombinator.com/user?id=' + child.author
                authorA.target = '_blank'
                authorA.innerText = child.author
                authorA.classList.add('text-gray-500', 'dark:text-gray-400', 'hover:text-gray-700', 'dark:hover:text-gray-200', 'underline')

                let dateSpan = document.createElement('span')
                dateSpan.innerText = ' ' + new Date(child.created_at_i * 1000).toLocaleString()
                dateSpan.classList.add('text-gray-500', 'dark:text-gray-400')

                button.addEventListener('click', (event) => {
                    let childrenElements = event.target.parentElement.querySelector('ul')
                    console.log(childrenElements)
                    if (childrenElements) {
                        if (childrenElements.classList.contains('hidden')) {
                            childrenElements.classList.remove('hidden')
                            event.target.innerText = 'hide replies'
                        } else {
                            childrenElements.classList.add('hidden')
                            event.target.innerText = 'show replies'
                        }
                    }
                })

                let ul = document.createElement('ul')
                ul = this.printComments(child.children, ul, true)
                if (hidden) {
                    ul.classList.add('hidden')
                    button.innerText = 'show replies'
                }

                li.appendChild(authorA)
                li.appendChild(dateSpan)
                li.appendChild(button)
                li.appendChild(document.createElement('br'))
                li.appendChild(span)
                li.appendChild(ul)
            } else {
                li.innerHTML = unescape(child.text)
            }
            target.appendChild(li)
        })
        return target
    }

})