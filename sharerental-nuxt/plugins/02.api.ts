import {defineNuxtPlugin, useRuntimeConfig} from "#app";
import SearchClient from "~/services/api/Search";
import LessorClient from "~/services/api/Lessor";
import {Configuration as SearchConfiguration} from '~/schemas/openapi/search';
import {Configuration as LessorConfiguration} from '~/schemas/openapi/lessor';
import {ApiMiddleware} from "~/services/api/ApiMiddleware";

export default defineNuxtPlugin((nuxtApp) => {

    let configuration = {
        basePath: useRuntimeConfig().public.backendUrl + "/backend",
        middleware: [new ApiMiddleware()]
    };


    const searchApiConfig = new SearchConfiguration(configuration)
    const lessorApiConfig = new LessorConfiguration(configuration)

    const searchClient = new SearchClient(searchApiConfig)
    const lessorClient = new LessorClient(lessorApiConfig)

    nuxtApp.provide('searchClient', searchClient)
    nuxtApp.provide('lessorClient', lessorClient)
})