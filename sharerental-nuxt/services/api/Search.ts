import {searchApiConfig} from './config'

import {
    SearchApi,
    SearchResult,
    SearchResultItem,
    Pageable, SearchGetRequest
} from '~~/schemas/openapi/search'

export type {
    SearchResult,
    SearchResultItem
}

export default {
    search(pageable?: Pageable, query?: string) {
        const searchApi = new SearchApi(searchApiConfig);
        return searchApi.searchGet({
            query: query ?? "",
            pageable: pageable
        })
    }
}