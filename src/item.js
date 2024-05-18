import TinyGesture from "tinygesture";
import nav from "./nav";

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

        this.handleGestures()
    },

    handleGestures() {
        let swiped = false;
        let startOffset = 0;
        const decelerationOnOverflow = 4;
        const revealWidth = 50;
        const snapWidth = revealWidth / 1.5;
        // Options object is optional. These are the defaults.
        const options = {
            // Used to calculate the threshold to consider a movement a swipe. it is
            // passed type of 'x' or 'y'.
            threshold: (type, self) =>
                Math.max(
                    25,
                    Math.floor(
                        0.15 *
                        (type === 'x'
                            ? window.innerWidth || document.body.clientWidth
                            : window.innerHeight || document.body.clientHeight)
                    )
                ),
            // Minimum velocity the gesture must be moving when the gesture ends to be
            // considered a swipe.
            velocityThreshold: 10,
            // Used to calculate the distance threshold to ignore the gestures velocity
            // and always consider it a swipe.
            disregardVelocityThreshold: (type, self) =>
                Math.floor(0.5 * (type === 'x' ? self.element.clientWidth : self.element.clientHeight)),
            // Point at which the pointer moved too much to consider it a tap or longpress
            // gesture.
            pressThreshold: 8,
            // If true, swiping in a diagonal direction will fire both a horizontal and a
            // vertical swipe.
            // If false, whichever direction the pointer moved more will be the only swipe
            // fired.
            diagonalSwipes: false,
            // The degree limit to consider a swipe when diagonalSwipes is true.
            diagonalLimit: Math.tan(((45 * 1.5) / 180) * Math.PI),
            // Listen to mouse events in addition to touch events. (For desktop support.)
            mouseSupport: true,
        };

        const target = this.$el
        const gesture = new TinyGesture(target, options);
        // swipe gestures
        gesture.on("panmove", (event) => {
            if (gesture.animationFrame) {
                return;
            }
            //event.preventDefault();
            gesture.animationFrame = window.requestAnimationFrame(() => {
                let getX = (x) => {
                    if (x < revealWidth && x > -revealWidth) {
                        return x;
                    }
                    if (x < -revealWidth) {
                        return (x + revealWidth) / decelerationOnOverflow - revealWidth;
                    }
                    if (x > revealWidth) {
                        return (x - revealWidth) / decelerationOnOverflow + revealWidth;
                    }
                };
                const newX = getX(startOffset + gesture.touchMoveX);
                target.style.transform = "translateX(" + newX + "px)";
                if (newX >= snapWidth || newX <= -snapWidth) {
                    swiped = newX < 0 ? -revealWidth : revealWidth;
                } else {
                    swiped = false;
                }
                window.requestAnimationFrame(() => {
                    target.style.transition = null;
                });
                gesture.animationFrame = null;
            });
        });

        gesture.on("panend", () => {
            window.cancelAnimationFrame(gesture.animationFrame);
            gesture.animationFrame = null;
            window.requestAnimationFrame(() => {
                target.style.transition = "transform .2s ease-in";
                if (!swiped) {
                    startOffset = 0;
                    target.style.transform = null;
                } else {
                    startOffset = swiped;
                    target.style.transform = "translateX(" + swiped + "px)";
                }
            });
        });

        // reset on tap
        gesture.on("doubletap", (event) => {
            // we could also use 'doubletap' here
            window.requestAnimationFrame(() => {
                target.style.transition = "transform .2s ease-in";
                swiped = false;
                startOffset = 0;
                target.style.transform = null;
            });
        });

        const saveButton = this.$el.parentElement.querySelector('.reveal-right')
        const shareButton = this.$el.parentElement.querySelector('.reveal-left')

        saveButton?.addEventListener('click', (event) => {
            // todo save item
        })

        shareButton?.addEventListener('click', (event) => {
            const shareData = {
                title: this.title,
                url: this.url
            }
            if (navigator.canShare(shareData)) {
                navigator.share(shareData)
            }
        })
    },

    handleData(data) {
        this.title = data.title
        this.url = data.url
        if (!this.url) {
            this.url = '/item.html?id=' + this.id
        }
        this.score = data.score
        this.by = data.by
        this.time = data.time
        this.descendants = data.descendants
        if (data.text) {
            let element = document.createElement('div')
            element.innerHTML = data.text
            this.text = element.innerHTML
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
                this.text = element.innerHTML
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
            li.classList.add('comment', 'border-l-2', 'border-gray-200', 'dark:border-gray-700', 'pl-4', 'py-2', 'mb-2', 'hover:border-gray-300', 'dark:hover:border-gray-600')
            if (child.children.length > 0) {
                let span = document.createElement('span')
                span.innerHTML = unescape(child.text)

                let button = document.createElement('button')
                button.innerText = 'hide replies'
                button.classList.add('ml-2', 'inline-block', 'rounded-md', 'px-4', 'py-2', 'text-sm', 'focus:relative', 'text-gray-500', 'hover:text-gray-700', 'dark:text-gray-400', 'dark:hover:text-gray-200', 'focus:text-white', 'bg-gray-200', 'dark:bg-gray-800')

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