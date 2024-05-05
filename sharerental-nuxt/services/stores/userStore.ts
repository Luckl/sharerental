import {defineStore} from 'pinia'
import {type User} from "@firebase/auth";
import {getAnalytics, setUserId} from "@firebase/analytics";

export type UserState = {
    user: User | null;
}

export const useUserStore = defineStore({
    id: 'userStore',
    state: () => ({
        user: null
    } as UserState),
    actions: {
        async refreshUser(): Promise<void> {
            this.user = await getCurrentUser();

            if (this.user?.uid) {
                setUserId(getAnalytics(), this.user?.uid)
            } else {
                setUserId(getAnalytics(), null)
            }
        },
    },
})