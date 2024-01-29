import {
    Configuration as RentalItemConfiguration, RenterApi
} from '~/schemas/openapi/renter';

class RenterClient {
    private renterApi: RenterApi;

    constructor(searchConfiguration: RentalItemConfiguration) {
        this.renterApi = new RenterApi(searchConfiguration);
    }

    getRenter() {
        return this.renterApi.getRenter();
    }
}

export default RenterClient
