import {defineNuxtPlugin, useRuntimeConfig} from "#app";
import SearchClient from "~/services/api/SearchClient";
import LessorClient from "~/services/api/LessorClient";
import RentalItemClient from "~/services/api/RentalItemClient";
import {Configuration} from '~/schemas/openapi/merged';
import {ApiMiddleware} from "~/services/api/ApiMiddleware";
import RentalItemImageClient from "~/services/api/RentalItemImageClient";

export default defineNuxtPlugin((nuxtApp) => {

    let configuration = {
        basePath: useRuntimeConfig().public.backendUrl + "/backend",
        middleware: [new ApiMiddleware()]
    };

    const config = new Configuration(configuration)

    const searchClient = new SearchClient(config)
    const lessorClient = new LessorClient(config)
    const rentalItemClient = new RentalItemClient(config)
    const rentalItemImageClient = new RentalItemImageClient(config)

    nuxtApp.provide('searchClient', searchClient)
    nuxtApp.provide('lessorClient', lessorClient)
    nuxtApp.provide('rentalItemClient', rentalItemClient)
    nuxtApp.provide('rentalItemImageClient', rentalItemImageClient)
})