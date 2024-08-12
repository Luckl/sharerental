import {defineStore} from 'pinia'
import type {Lessor} from "~/schemas/openapi/lessor";
import {useNuxtApp} from "#app";

export type LessorState = {
    activeLessor: Lessor | null;
    loaded: boolean;
    availableLessors: Lessor[];
}


export const useLessorStore = defineStore({
    id: 'lessorStore',
    state: () => ({
        activeLessor: null,
        loaded: false,
        availableLessors: [],
    } as LessorState),
    getters: {
        getActiveLessor(state: LessorState) {
            return this.activeLessor;
        },
    },
    actions: {
        async loadLessors(): Promise<void> {

            if (this.loaded) {
                return;
            } else {
                await this.reloadLessors();
            }

        },
        async reloadLessors(): Promise<void> {
            const $lessorApi = useNuxtApp().$lessorApi;

            this.availableLessors = await $lessorApi.getLessor({
                page: 0,
                size: 20,
                sort: [],
            })
                .then((result) => {
                    this.loaded = true;
                    return result.embedded;
                }, (error) => {
                    this.loaded = true;
                    return [];
                });

            if (this.availableLessors.length > 0) {
                this.activeLessor = this.availableLessors[0];
            } else {
                this.activeLessor = null;
            }
        }
    },
})