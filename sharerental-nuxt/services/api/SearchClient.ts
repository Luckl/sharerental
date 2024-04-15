import {
    Configuration as SearchConfiguration,
    SearchApi,
} from '~~/schemas/openapi/search';
import type {
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

    details(slug: string) {
        return this.searchApi.searchDetails({slug: slug})
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
