import {
    FetchParams,
    Middleware,
    ResponseContext,
} from '~~/schemas/openapi/search';

export class ApiMiddleware implements Middleware {
    public async pre(context: ResponseContext): Promise<FetchParams | void> {
        const accessToken = await this.acquireToken();
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
    }

    public post(context: ResponseContext): Promise<Response | void> {
        return Promise.resolve(context.response);
    }

    private acquireToken(): Promise<string> {
        return Promise.resolve().then(() => {
            return 'ACCESS_TOKEN';
        });
    }
}