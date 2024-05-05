import {defineStore} from 'pinia'

export enum RenterType {
    Private = "private",
    Business = "business"
}

export type RenterTypeState = {
    renterType: RenterType | null;
}

export const useRenterTypeStore = defineStore('renterTypeStore', {
    state: (): RenterTypeState => ({
        renterType: null
    }),
    actions: {
        async setRenterType(renterType: RenterType): Promise<void> {
            this.renterType = renterType;
        }
    },
    persist: {
      storage: persistedState.localStorage
    }
})