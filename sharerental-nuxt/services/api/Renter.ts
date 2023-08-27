import {
    Configuration as RenterConfiguration,
    Pageable,
    RenterApi,
    GetRenterResult,
    Renter, RenterInput,
} from '~/schemas/openapi/renter';

export type {
    GetRenterResult,
    Renter
}

class RenterClient {
    private renterApi: RenterApi;

    constructor(searchConfiguration: RenterConfiguration) {
        this.renterApi = new RenterApi(searchConfiguration);
    }

    findAll(pageable?: Pageable) {
        return this.renterApi.getRenter({
                pageable: pageable
            });
    }

    create(renterInput: RenterInput) {
        return this.renterApi.createRenter({
            renterInput: renterInput
        })
    }
}

export default RenterClient
