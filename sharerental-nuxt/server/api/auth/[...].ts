import {NuxtAuthHandler} from '#auth'
import OktaProvider from "next-auth/providers/okta";

const runtimeConfig = useRuntimeConfig()

export default NuxtAuthHandler({

    providers: [
        // @ts-ignore Import is exported on .default during SSR, so we need to call it this way. May be fixed via Vite at some point
        OktaProvider.default({
            clientId: runtimeConfig.okta_client_id,
            clientSecret: runtimeConfig.okta_client_secret,
            issuer: runtimeConfig.okta_domain
        })
    ]
})