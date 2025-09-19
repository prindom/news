// const colors = require('tailwindcss/colors')

export default {
  darkMode: 'class',
  content: ['index.html','./src/**/*.{js,jsx,ts,tsx,vue,html}', 'views/*.tpl'],
  theme: {
    extend: {},
  },
  plugins: [
    function({ addUtilities }) {
      addUtilities({
        '.scrollbar-hide': {
          /* Hide scrollbar for WebKit browsers */
          '-webkit-overflow-scrolling': 'touch',
          '&::-webkit-scrollbar': {
            display: 'none',
          },
          /* Hide scrollbar for IE, Edge and Firefox */
          '-ms-overflow-style': 'none',
          'scrollbar-width': 'none',
        }
      })
    }
  ],
}
