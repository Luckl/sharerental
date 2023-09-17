
import {Configuration, RentalItemImageApi, RentalItemInput} from "~/schemas/openapi/merged";


class RentalItemImageClient {
    private rentalItemImageApi: RentalItemImageApi;

    constructor(configuration: Configuration) {
        this.rentalItemImageApi = new RentalItemImageApi(configuration);
    }

    upload(id: number, files: Blob[]) {
        return this.rentalItemImageApi.uploadRentalItemImage({
            id, files
        })
    }

    get(id: number) {
        return this.rentalItemImageApi.getRentalItemImages({id})
    }
}

export default RentalItemImageClient
