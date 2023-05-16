export default () => (
    {
        current: 'top',
        items: ['new', 'top', 'best', 'show'],
        init() {
            let params = new URLSearchParams(window.location.search)
            this.$store.current = params.get('type') || 'top'
        },

    }
)