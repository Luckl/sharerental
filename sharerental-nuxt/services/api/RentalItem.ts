import {
    Configuration as RentalItemConfiguration, RentalItemApi, RentalItemInput,
} from '~/schemas/openapi/rentalItem';

class RentalItemClient {
    private rentalItemApi: RentalItemApi;

    constructor(searchConfiguration: RentalItemConfiguration) {
        this.rentalItemApi = new RentalItemApi(searchConfiguration);
    }

    findAll(page: number, size: number, sort: string[]) {
        return this.rentalItemApi.getRentalItems({
            page: page,
            size: size,
            sort: sort
        });
    }

    create(rentalItemInput: RentalItemInput) {
        return this.rentalItemApi.createRentalItem({
            rentalItemInput: rentalItemInput
        })
    }
}

export default RentalItemClient
