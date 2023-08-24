import {
    Configuration as SearchConfiguration,
    Pageable,
    SearchApi,
    SearchResult,
    SearchResultItem,
} from '~~/schemas/openapi/search';

export type {
    SearchResult,
    SearchResultItem
}

class SearchClient {
    private searchApi: SearchApi;

    constructor(searchConfiguration: SearchConfiguration) {
        this.searchApi = new SearchApi(searchConfiguration);
    }

    search(pageable?: Pageable, query?: string) {
        return this.searchApi.search({
                query: query ?? "",
                pageable: pageable
            });
    }
}

export default SearchClient
