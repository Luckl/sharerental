import {defineNuxtPlugin, useRuntimeConfig} from "#app";
import {useCurrentUser} from "vuefire";
import SearchClient from "~/services/api/Search";
import {Configuration as SearchConfiguration, HTTPHeaders} from '~/schemas/openapi/search';
import {ApiMiddleware} from "~/services/api/ApiMiddleware";

export default defineNuxtPlugin((nuxtApp) => {

    const searchApiConfig = new SearchConfiguration({
        basePath: useRuntimeConfig().public.backendUrl,
        middleware: [new ApiMiddleware()],
        headers: {

        }
    })

    const searchClient: SearchClient = new SearchClient(searchApiConfig)

    nuxtApp.provide('searchClient', searchClient)
})