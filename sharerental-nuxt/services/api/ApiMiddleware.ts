import {
    FetchParams,
    Middleware,
    ResponseContext,
} from '~~/schemas/openapi/search';
import {getCurrentUser} from "vuefire";

export class ApiMiddleware implements Middleware {
    public async pre(context: ResponseContext): Promise<FetchParams | void> {
        const accessToken = await this.acquireToken();
        if (accessToken != null) {
            return {
                url: context.url,
                init: {
                    ...context.init,
                    headers: new Headers({
                        ...context.init.headers,
                        Authorization: `Bearer ${accessToken}`,
                    }),
                },
            };
        } else {
            return {
                url: context.url,
                init: {
                    ...context.init,
                    headers: new Headers({
                        ...context.init.headers
                    }),
                },
            };
        }
    }

    public post(context: ResponseContext): Promise<Response | void> {
        return Promise.resolve(context.response);
    }

    private async acquireToken(): Promise<string | undefined> {
        let result = await getCurrentUser();
        return result?.getIdToken();
    }
}