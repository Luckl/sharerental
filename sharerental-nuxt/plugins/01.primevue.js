import PrimeVue from 'primevue/config'
import Button from 'primevue/button'
import InputText from 'primevue/inputtext'
import Toast from 'primevue/toast'
import ToastService from 'primevue/toastservice'
import Password from "primevue/password";
import Message from "primevue/message";
import Card from "primevue/card";
import Sidebar from "primevue/sidebar";
import Editor from "primevue/editor";
import {defineNuxtPlugin} from "#app";

export default defineNuxtPlugin(nuxtApp => {
    nuxtApp.vueApp.use(PrimeVue, { ripple: true })
    nuxtApp.vueApp.use(ToastService)
    nuxtApp.vueApp.component('Button', Button)
    nuxtApp.vueApp.component('InputText', InputText)
    nuxtApp.vueApp.component('Toast', Toast)
    nuxtApp.vueApp.component('Password', Password)
    nuxtApp.vueApp.component('Message', Message)
    nuxtApp.vueApp.component('Card', Card)
    nuxtApp.vueApp.component('Sidebar', Sidebar)
    nuxtApp.vueApp.component('Editor', Editor)

    //other components that you need
})
