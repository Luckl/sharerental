import {
    Configuration as LessorConfiguration,
    LessorApi,
} from '~/schemas/openapi/lessor';

import type {
    GetLessorResult,
    Lessor, LessorInput
} from '~/schemas/openapi/lessor';

export type {
    GetLessorResult,
    Lessor
}

class LessorClient {
    private lessorApi: LessorApi;

    constructor(searchConfiguration: LessorConfiguration) {
        this.lessorApi = new LessorApi(searchConfiguration);
    }

    findAll(page: number, size: number, sort: string[]) {
        return this.lessorApi.getLessor({
            page: page,
            size: size,
            sort: sort
        });
    }

    create(lessorInput: LessorInput) {
        return this.lessorApi.createLessor({
            lessorInput: lessorInput
        })
    }
}

export default LessorClient
