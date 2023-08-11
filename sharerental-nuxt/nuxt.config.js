// https://nuxt.com/docs/api/configuration/nuxt-config
const baseUrl = '/';
export default defineNuxtConfig({
  modules: ['nuxt-vuefire'],
  ssr: true,
  devtools: { enabled: true },
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
  googleFonts: {

    families: {
      Roboto: true
    }
  },
  nitro: {
    logLevel: 5
  },
  css: [
    'primevue/resources/themes/saga-orange/theme.css',
    'primevue/resources/primevue.css',
    'primeicons/primeicons.css',
    'reset-css/reset.css',

  ],
  build: {
    transpile: ['primevue']
  },
})
