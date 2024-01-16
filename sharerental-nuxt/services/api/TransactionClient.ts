import {
    Configuration,
    TransactionApi, TransactionStatus
} from '~/schemas/openapi/transaction';

class TransactionClient {
    private transactionApi: TransactionApi;

    constructor(configuration: Configuration) {
        this.transactionApi = new TransactionApi(configuration);
    }

    startTransaction(id: number, startDate: Date, endDate: Date, amount: number) {
        return this.transactionApi.startTransaction({
            createTransactionRequest: {
                endDate: endDate,
                startDate: startDate,
                rentalItemId: id,
                amount: amount
            }
        })
    }

    calculatePrice(id: number, startDate: Date, endDate: Date, amount: number) {
        return this.transactionApi.calculatePrice({
            transactionCalculationInput: {
                endDate: endDate,
                startDate: startDate,
                rentalItemId: id,
                amount: amount
            }
        })
    }

    getAvailableItems(startDate: Date, endDate: Date, id: number) {
        return this.transactionApi.getAmountAvailableForDate({
            getAmountAvailableRequest: {
                endDate: endDate,
                startDate: startDate,
                rentalItemId: id
            }
        })
    }

    getTransactions(page: number, size: number, sort: string[], filter: string, status: TransactionStatus[]) {
        return this.transactionApi.getTransactions({
            page: page,
            size: size,
            sort: sort,
            filter: filter,
            status: status
        })
    }
}

export default TransactionClient
