import {defineNuxtPlugin, useRuntimeConfig} from "#app";
import SearchClient from "~/services/api/SearchClient";
import LessorClient from "~/services/api/LessorClient";
import RentalItemClient from "~/services/api/RentalItemClient";
import {Configuration as SearchConfiguration} from '~/schemas/openapi/search';
import {Configuration as LessorConfiguration} from '~/schemas/openapi/lessor';
import {Configuration as RentalItemConfiguration} from '~/schemas/openapi/rentalItem';
import {ApiMiddleware} from "~/services/api/ApiMiddleware";

export default defineNuxtPlugin((nuxtApp) => {

    let configuration = {
        basePath: useRuntimeConfig().public.backendUrl + "/backend",
        middleware: [new ApiMiddleware()]
    };

    const searchApiConfig = new SearchConfiguration(configuration)
    const lessorApiConfig = new LessorConfiguration(configuration)
    const rentalItemApiConfig = new RentalItemConfiguration(configuration)

    const searchClient = new SearchClient(searchApiConfig)
    const lessorClient = new LessorClient(lessorApiConfig)
    const rentalItemClient = new RentalItemClient(rentalItemApiConfig)

    nuxtApp.provide('searchClient', searchClient)
    nuxtApp.provide('lessorClient', lessorClient)
    nuxtApp.provide('rentalItemClient', rentalItemClient)
})