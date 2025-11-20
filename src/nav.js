export default () => ({
    current: 'top',
    items: ['top', 'new', 'best', 'show', 'ask', 'job'],
    init() {
        let params = new URLSearchParams(window.location.search)
        this.$store.current = params.get('type') || 'top'
    },
})
