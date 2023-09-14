import {
    Configuration as RentalItemConfiguration, RentalItemApi
} from '~/schemas/openapi/rentalItem';
import {RentalItemInput} from "~/schemas/openapi/merged";


class RentalItemClient {
    private rentalItemApi: RentalItemApi;

    constructor(searchConfiguration: RentalItemConfiguration) {
        this.rentalItemApi = new RentalItemApi(searchConfiguration);
    }

    findAll(page: number, size: number, sort: string[], filter: string) {
        return this.rentalItemApi.getRentalItems({
            page: page,
            size: size,
            sort: sort,
            filter: filter
        });
    }

    create(rentalItemInput: RentalItemInput) {
        return this.rentalItemApi.createRentalItem({
            rentalItemInput: rentalItemInput
        })
    }
}

export default RentalItemClient
