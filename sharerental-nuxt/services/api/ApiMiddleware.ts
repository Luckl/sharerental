import type {
    FetchParams,
    Middleware,
    ResponseContext,
} from '~~/schemas/openapi/transaction';
import {getCurrentUser} from "vuefire";

export class ApiMiddleware implements Middleware {
    public async pre(context: ResponseContext): Promise<FetchParams | void> {

        const accessToken = await this.acquireToken();
        let xsrfToken = useCookie("XSRF-TOKEN").value;
        let headers = new Headers({
            ...context.init.headers
        });
        if (xsrfToken != null) {
            headers.append("X-XSRF-TOKEN", xsrfToken);
        }
        if (accessToken != null) {
            headers.append("Authorization", "Bearer " + accessToken);
        }
        return {
            url: context.url,
            init: {
                ...context.init,
                headers: headers,
            },
        };
    }

    public post(context: ResponseContext): Promise<Response | void> {
        return Promise.resolve(context.response);
    }

    private async acquireToken(): Promise<string | undefined> {
        let result = await getCurrentUser();
        return result?.getIdToken();
    }
}