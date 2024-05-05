import {defineNuxtPlugin, useRuntimeConfig} from "#app";
import SearchClient from "~/services/api/SearchClient";
import LessorClient from "~/services/api/LessorClient";
import RentalItemClient from "~/services/api/RentalItemClient";
import {Configuration as TransactionConfiguration} from '~/schemas/openapi/transaction';
import {Configuration as RentalItemConfiguration} from '~/schemas/openapi/rentalItem';
import {Configuration as LessorConfiguration} from '~/schemas/openapi/lessor';
import {Configuration as SearchConfiguration} from '~/schemas/openapi/search';
import {Configuration as RenterConfiguration} from '~/schemas/openapi/renter';
import {Configuration as ContactFormConfiguration} from '~/schemas/openapi/contactForm';
import {ApiMiddleware} from "~/services/api/ApiMiddleware";
import RentalItemImageClient from "~/services/api/RentalItemImageClient";
import TransactionClient from "~/services/api/TransactionClient";
import RenterClient from "~/services/api/RenterClient";
import ContactFormClient from "~/services/api/ContactFormClient";

export default defineNuxtPlugin((nuxtApp) => {

    let configuration = {
        basePath: useRuntimeConfig().public.backendUrl + "/backend",
        middleware: [new ApiMiddleware()]
    };

    const transactionConfiguration = new TransactionConfiguration(configuration)
    const rentalItemConfiguration = new RentalItemConfiguration(configuration)
    const lessorConfiguration = new LessorConfiguration(configuration)
    const searchConfiguration = new SearchConfiguration(configuration)
    const renterConfiguration = new RenterConfiguration(configuration)
    const contactFormConfiguration = new ContactFormConfiguration(configuration)

    const searchClient = new SearchClient(searchConfiguration)
    const lessorClient = new LessorClient(lessorConfiguration)
    const rentalItemClient = new RentalItemClient(rentalItemConfiguration)
    const renterClient = new RenterClient(renterConfiguration)
    const rentalItemImageClient = new RentalItemImageClient(rentalItemConfiguration)
    const transactionClient = new TransactionClient(transactionConfiguration)
    const contactFormClient = new ContactFormClient(contactFormConfiguration)

    return {
        provide: {
            searchClient: searchClient,
            lessorClient: lessorClient,
            rentalItemClient: rentalItemClient,
            rentalItemImageClient: rentalItemImageClient,
            transactionClient: transactionClient,
            renterClient: renterClient,
            contactFormClient: contactFormClient
        }
    }
})