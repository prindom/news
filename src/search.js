export default () => ({
    open: false,
    init() {
        this.open = false
        // on ctrl or cmd + k open search
        document.addEventListener('keydown', (event) => {
            if (event.ctrlKey || event.metaKey) {
                if (event.key === 'k') {
                    event.preventDefault()
                    if (this.open) {
                        this.open = false
                    } else {
                        this.open = true
                        setTimeout(() => {
                            this.$el.querySelector('input#Search').focus()
                        }, 0)
                    }
                }
            }
            // if is open and enter is pressed, redirect with url param search
            if (this.open && event.key === 'Enter') {
                Alpine.store('current', 'search')
                window.location =
                    window.location.origin +
                    '?type=search&query=' +
                    this.$el.querySelector('input').value
            }
        })
    },
})
