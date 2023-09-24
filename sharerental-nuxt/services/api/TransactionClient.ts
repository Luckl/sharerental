import {
    Configuration,
    TransactionApi
} from '~/schemas/openapi/merged';

class LessorClient {
    private transactionApi: TransactionApi;

    constructor(configuration: Configuration) {
        this.transactionApi = new TransactionApi(configuration);
    }


    calculatePrice(id: number, startDate: Date, endDate: Date) {
        return this.transactionApi.calculatePrice({
            transactionCalculationInput: {
                endDate: endDate,
                startDate: startDate,
                rentalItemId: id
            }
        })
    }
}

export default LessorClient
