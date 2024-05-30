import {defineStore} from 'pinia'

export enum RenterTypeEnum {
    Private = "PRIVATE",
    Business = "BUSINESS"
}

export type RenterTypeState = {
    renterType: RenterTypeEnum | null;
}

export const useRenterTypeStore = defineStore('renterTypeStore', {
    state: (): RenterTypeState => ({
        renterType: null
    }),
    actions: {
        async setRenterType(renterType: RenterTypeEnum): Promise<void> {
            this.renterType = renterType;
        }
    },
    persist: {
      storage: persistedState.localStorage
    }
})