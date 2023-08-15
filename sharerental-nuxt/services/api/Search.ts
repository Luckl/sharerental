import {
    Configuration as SearchConfiguration,
    Pageable,
    SearchApi,
    SearchResult,
    SearchResultItem,
} from '~~/schemas/openapi/search';
import {User} from "@firebase/auth";

export type {
    SearchResult,
    SearchResultItem
}

class SearchClient {
    private user: User | null |undefined;
    private searchApi: SearchApi;

    constructor(user: User | null | undefined, searchConfiguration: SearchConfiguration) {
        this.user = user
        this.searchApi = new SearchApi(searchConfiguration);
    }

    search(pageable?: Pageable, query?: string) {
        return new Promise(() => {
            return this.user?.getIdToken()
        }).then((token) => {
            console.log(token)

            return this.searchApi.searchGet({
                query: query ?? "",
                pageable: pageable
            });
        });
    }
}

export default SearchClient
