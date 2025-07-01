import { defineConfig } from 'vite'

// https://vitejs.dev/config/
export default defineConfig({
    build: {
        lib: {
            entry: 'src/main.js',
            name: 'MyLib'
        },
        outDir: 'public/dist',
        rollupOptions: {
            output: {
                assetFileNames: (assetInfo) => {
                     if (assetInfo.name.endsWith('.css')) {
                         return `css/style.css`
                     }
                     if (assetInfo.name.endsWith('.js')) {
                         return `js/${assetInfo.name}`
                     }
                    return `assets/${assetInfo.name}`
                },
                entryFileNames: 'js/[name].js',
            }

        }
    },
    publicDir: false
})
