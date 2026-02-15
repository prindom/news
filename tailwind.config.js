export default {
    darkMode: 'class',
    content: [
        'index.html',
        './src/**/*.{js,jsx,ts,tsx,vue,html}',
        'views/*.tpl',
    ],
    theme: {
        extend: {
            colors: {
                surface: {
                    DEFAULT: 'var(--bg-primary)',
                    secondary: 'var(--bg-secondary)',
                    tertiary: 'var(--bg-tertiary)',
                    active: 'var(--bg-active)',
                    hover: 'var(--bg-hover)',
                },
                content: {
                    DEFAULT: 'var(--text-primary)',
                    secondary: 'var(--text-secondary)',
                    heading: 'var(--text-heading)',
                },
                edge: {
                    DEFAULT: 'var(--border-primary)',
                    secondary: 'var(--border-secondary)',
                },
                accent: {
                    DEFAULT: 'var(--accent)',
                    hover: 'var(--accent-hover)',
                },
            },
            boxShadowColor: {
                theme: 'var(--shadow-color)',
            },
        },
    },
    plugins: [],
}
