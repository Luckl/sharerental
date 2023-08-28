import {
    Configuration as LessorConfiguration,
    Pageable,
    LessorApi,
    GetLessorResult,
    Lessor, LessorInput,
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

    findAll(pageable?: Pageable) {
        return this.lessorApi.getLessor({
                pageable: pageable
            });
    }

    create(lessorInput: LessorInput) {
        return this.lessorApi.createLessor({
            lessorInput: lessorInput
        })
    }
}

export default LessorClient
