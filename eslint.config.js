import js from '@eslint/js'
import globals from 'globals'

export default [
    js.configs.recommended,
    {
        ignores: ['**/dist'],
        rules: {
            'no-unused-vars': 'warn',
            'no-undef': 'warn',
        },
        languageOptions: {
            ecmaVersion: 2022,
            sourceType: 'module',
            globals: {
                ...globals.browser,
                ...globals.node,
                Alpine: 'readonly',
                TinyGesture: 'readonly',
            },
        },
    },
]
