import {defineStore} from 'pinia'
import type {Lessor} from "~/schemas/openapi/lessor";
import {useNuxtApp} from "#app";
import type LessorClient from "~/services/api/LessorClient";

export type LessorState = {
    activeLessor: Lessor | null;
    availableLessors: Lessor[];
}


export const useLessorStore = defineStore({
    id: 'lessorStore',
    state: () => ({
        activeLessor: null,
        availableLessors: [],
    } as LessorState),
    getters: {
        getActiveLessor(state: LessorState) {
            return this.activeLessor;
        },
    },
    actions: {
        async loadLessors(): Promise<void> {
            const $lessorClient: LessorClient = useNuxtApp().$lessorClient;

            this.availableLessors = await $lessorClient.findAll(0, 20, [])
                .then((result) => {
                    return result.embedded;
                }, (error) => {
                    return [];
                });

            if (this.availableLessors.length > 0) {
                this.activeLessor = this.availableLessors[0];
            } else {
                this.activeLessor = null;
            }
        },
    },
})