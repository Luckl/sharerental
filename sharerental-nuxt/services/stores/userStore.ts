import {defineStore} from 'pinia'
import {type User} from "@firebase/auth";
import {getAnalytics, setUserId} from "@firebase/analytics";

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

            if (this.user?.uid) {
                setUserId(getAnalytics(), this.user?.uid)
            } else {
                setUserId(getAnalytics(), null)
            }
        },
    },
})