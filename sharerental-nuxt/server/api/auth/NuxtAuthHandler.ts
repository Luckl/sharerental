import { NuxtAuthHandler } from '#auth'
import OktaProvider from "next-auth/providers/okta";

const runtimeConfig = useRuntimeConfig()

export default NuxtAuthHandler({

    providers: [
        OktaProvider({
            clientId: runtimeConfig.okta_client_id,
            clientSecret: runtimeConfig.okta_client_secret,
            issuer: runtimeConfig.okta_domain
        })
    ]
})