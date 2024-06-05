import {defineNuxtPlugin, useRuntimeConfig} from "#app";
import {ApiMiddleware} from "~/services/api/ApiMiddleware";
import {Configuration as LessorConfiguration, LessorApi} from "~/schemas/openapi/lessor";
import {Configuration as SearchConfiguration,SearchApi} from "~/schemas/openapi/search";
import {Configuration as TransactionConfiguration,TransactionApi} from "~/schemas/openapi/transaction";
import {Configuration as RenterConfiguration,RenterApi} from "~/schemas/openapi/renter";
import {Configuration as RentalItemConfiguration,RentalItemApi, RentalItemImageApi} from "~/schemas/openapi/rentalItem";
import {
    Configuration as ContactFormConfiguration,
    ContactFormApi,
    UserApi,
    ZipcodeApi
} from "~/schemas/openapi/contactForm";

export default defineNuxtPlugin((nuxtApp) => {

    let configuration = {
        basePath: useRuntimeConfig().public.backendUrl + "/backend",
        middleware: [new ApiMiddleware()]
    };

    const searchApi = new SearchApi(new SearchConfiguration(configuration));
    const transactionApi = new TransactionApi(new TransactionConfiguration(configuration));
    const lessorApi = new LessorApi(new LessorConfiguration(configuration));
    const renterApi = new RenterApi(new RenterConfiguration(configuration));
    const rentalItemApi = new RentalItemApi(new RentalItemConfiguration(configuration));
    const rentalItemImageApi = new RentalItemImageApi(new RentalItemConfiguration(configuration));
    const contactFormApi = new ContactFormApi(new ContactFormConfiguration(configuration));
    const userApi = new UserApi(new ContactFormConfiguration(configuration));
    const zipcodeApi = new ZipcodeApi(new ContactFormConfiguration(configuration));

    console.log("API Clients initialized")

    return {
        provide: {
            searchApi: searchApi,
            lessorApi: lessorApi,
            rentalItemApi: rentalItemApi,
            rentalItemImageApi: rentalItemImageApi,
            transactionApi: transactionApi,
            renterApi: renterApi,
            contactFormApi: contactFormApi,
            userApi: userApi,
            zipcodeApi: zipcodeApi
        }
    }
})