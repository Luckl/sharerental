// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
    modules: ['nuxt-vuefire',  '@nuxt/image', '@pinia/nuxt', '@nuxtjs/google-fonts'],
    ssr: true,
    devtools: {enabled: true},
    image: {
        inject: true
    },
    vuefire: {
        auth: true,
        admin: {},
        config: {
            apiKey: process.env.FB_API_KEY,
            authDomain: process.env.FB_AUTH_DOMAIN,
            projectId: process.env.FB_PROJECT_ID,
            storageBucket: process.env.FB_STORAGE_BUCKET,
            messagingSenderId: process.env.FB_MESSAGING_SENDER_ID,
            appId: process.env.FB_APP_ID,
            measurementId: process.env.FB_MEASUREMENT_ID
        }
    },
    runtimeConfig: {
        public: {
            backendUrl: process.env.SR_BACKEND_URL
        }
    },
    routeRules: {
        '/backend/**': {
            proxy: { to: "http://localhost:8080/backend/**", },
        }
    },
    css: [
        '~/assets/css/reset.css',
        '~/assets/css/main.css',
        'primevue/resources/primevue.css',
        'primevue/resources/themes/saga-orange/theme.css',
        'primeicons/primeicons.css',
        'quill/dist/quill.core.css'
    ],
    nitro: {
        logLevel: 5
    },
    $meta: {
        title: 'ShareRental'
    },
    build: {
        transpile: ['primevue']
    },
    postcss: {
        plugins: {
            tailwindcss: {},
            autoprefixer: {}
        }
    },
    googleFonts: {
        families: {
            Roboto: true
        }
    },
})
