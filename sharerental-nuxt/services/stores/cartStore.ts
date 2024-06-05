import {defineStore} from 'pinia'
import type {RentalItem} from "~/schemas/openapi/search";

export type CartState = {
    rentalItem: RentalItem | null;
    amount: number | null;
    startDate: Date | null;
    endDate: Date | null;
    price: number | null;
}

export const useCartStore = defineStore('cartStore', {
    state: (): CartState => ({
        rentalItem: null,
        amount: null,
        endDate: null,
        startDate: null,
        price: null
    }),
    actions: {
        async setCart(rentalItem: RentalItem | null, amount: number, endDate: Date, startDate: Date, price: number ): Promise<void> {
            this.rentalItem = rentalItem ?? null;
            this.amount = amount;
            this.endDate = endDate;
            this.startDate = startDate;
            this.price = price;
        }
    },
    persist: {
        storage: persistedState.localStorage
    }
})