import {
    Configuration as RentalItemConfiguration, RentalItemApi
} from '~/schemas/openapi/merged';
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

    update(rentalItemInput: RentalItemInput, id: number) {
        return this.rentalItemApi.updateRentalItem({rentalItemInput, id})
    }

    get(id: number) {
        return this.rentalItemApi.getRentalItem({id})
    }
}

export default RentalItemClient
