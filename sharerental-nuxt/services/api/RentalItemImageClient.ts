
import {Configuration, RentalItemImageApi, RentalItemInput} from "~/schemas/openapi/merged";


class RentalItemImageClient {
    private rentalItemImageApi: RentalItemImageApi;

    constructor(configuration: Configuration) {
        this.rentalItemImageApi = new RentalItemImageApi(configuration);
    }

    upload(id: number, fileType: string, file: Blob) {
        return this.rentalItemImageApi.uploadRentalItemImage({
            id,  body: file, fileType
        })
    }

    get(id: number) {
        return this.rentalItemImageApi.getRentalItemImages({id})
    }
}

export default RentalItemImageClient
