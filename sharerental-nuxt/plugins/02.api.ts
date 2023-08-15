import {defineNuxtPlugin, useRuntimeConfig} from "#app";
import {useCurrentUser} from "vuefire";
import SearchClient from "~/services/api/Search";
import {Configuration as SearchConfiguration} from '~/schemas/openapi/search';

export default defineNuxtPlugin((nuxtApp) => {

    // TODO: user not accessible server-side. share state to SSR context somehow
    const user = useCurrentUser();
    const searchApiConfig = new SearchConfiguration({
        basePath: useRuntimeConfig().public.backendUrl
    })

    const searchClient: SearchClient = new SearchClient(user.value, searchApiConfig)

    nuxtApp.provide('searchClient', searchClient)
})