export default defineNuxtConfig({
  head: {
    title: "todolist-article",
    htmlAttrs: {
      lang: "en",
    },
    meta: [
      { charset: "utf-8" },
      { name: "viewport", content: "width=device-width, initial-scale=1" },
      { hid: "description", name: "description", content: "" },
      { name: "format-detection", content: "telephone=no" },
    ],
    link: [{ rel: "icon", type: "image/x-icon", href: "/favicon.ico" }],
  },

  css: [
    'primevue/resources/themes/saga-blue/theme.css',
    'primevue/resources/primevue.css',
    'primeicons/primeicons.css',
    'primeflex/primeflex.css'
  ],
  runtimeConfig: {
    okta_domain: process.env.OKTA_DOMAIN,
    okta_client_id: process.env.OKTA_CLIENT_ID,
    okta_client_secret: process.env.OKTA_CLIENT_SECRET
  },
  modules: ['@sidebase/nuxt-auth'],
  build: {
    transpile: ['primevue']
  },
})