import {
    Configuration as SearchConfiguration,
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

    search(page: number, size: number, sort: string[], query?: string) {
        return this.searchApi.search({
            query: query ?? "",
            page: page,
            size: size,
            sort: sort
        });
    }
}

export default SearchClient
