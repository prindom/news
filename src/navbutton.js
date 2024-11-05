export default (name) => ({
    name: name,
    init() {
        if (Alpine.store('current') !== this.name) {
            this.$el.classList.add('hidden')
        }
    },
    click() {},
})
