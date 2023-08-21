import {defineNuxtPlugin, useRuntimeConfig} from "#app";
import {useCurrentUser} from "vuefire";
import SearchClient from "~/services/api/Search";
import {Configuration as SearchConfiguration} from '~/schemas/openapi/search';

export default defineNuxtPlugin((nuxtApp) => {

    const searchApiConfig = new SearchConfiguration({
        basePath: useRuntimeConfig().public.backendUrl
    })

    const searchClient: SearchClient = new SearchClient(searchApiConfig)

    nuxtApp.provide('searchClient', searchClient)
})