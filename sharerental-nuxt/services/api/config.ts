import {Configuration as SearchConfiguration} from '~~/schemas/openapi/search';
import {useRuntimeConfig} from "#app";


const searchApiConfig = new SearchConfiguration({
    basePath: useRuntimeConfig().public.backendUrl
})
export {searchApiConfig};