import {defineStore} from 'pinia'
import {type User} from "@firebase/auth";
import {getAnalytics} from "@firebase/analytics";


export type UserState = {
    user: User | null;
}

export const useUserStore = defineStore({
    id: 'userStore',
    state: () => ({
        user: null,
    } as UserState),
    getters: {
        getUser(state: UserState) {
            return this.user;
        },
    },
    actions: {
        async refreshUser(): Promise<void> {
            this.user = await getCurrentUser();
            console.log("Setting analytics uid: " + this.user?.uid)
            getAnalytics(useFirebaseApp()).setUserId(this.user?.uid)
        },
    },
})