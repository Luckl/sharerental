import {NuxtAuthHandler} from '#auth'
import CredentialsProvider from "next-auth/providers/credentials";
import {useFirebaseAuth} from "#imports";

const auth = useFirebaseAuth()

export default NuxtAuthHandler({

    providers: [
        // @ts-ignore Import is exported on .default during SSR, so we need to call it this way. May be fixed via Vite at some point
        CredentialsProvider.default({
            // The name to display on the sign in form (e.g. "Sign in with...")
            name: "Credentials",
            // `credentials` is used to generate a form on the sign in page.
            // You can specify which fields should be submitted, by adding keys to the `credentials` object.
            // e.g. domain, username, password, 2FA token, etc.
            // You can pass any HTML attribute to the <input> tag through the object.
            credentials: {
                username: { label: "Username", type: "text", placeholder: "jsmith" },
                password: { label: "Password", type: "password" }
            },
            async authorize(credentials, req) {
                await auth.loginUser(credentials.username.value, credentials.password.value)
                return auth.user
            }
        })
    ]
})