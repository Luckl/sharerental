<script lang="ts" setup>
import {GoogleAuthProvider, signInWithEmailAndPassword, signOut,} from 'firebase/auth'
import {useCurrentUser, useFirebaseAuth} from 'vuefire'
import {useRouter} from "#app";

definePageMeta({
  linkTitle: 'Login',
  order: 1,
})

const auth = useFirebaseAuth()! // only exists on client side
const user = useCurrentUser()
const router = useRouter()
const email = ref("")
const password = ref("")
const errorParser = new RegExp('.*\\((.*)\\).*')

const googleProvider = new GoogleAuthProvider();

googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');

function signIn() {
  signInWithEmailAndPassword(auth, email.value, password.value)
      .then(() => {
        router.push("/")
      }, (reason) => {
        error.value = errorParser.exec(reason.message)?.pop()
      })
}

// display errors if any
const error = ref<String | undefined>(undefined)

const sticky = ref(false)
</script>

<template>
  <Head>
    <Title>Inloggen - ShareRental</Title>
  </Head>
  <form-page>
    <template #header></template>
    <template #content>
      <main>
        <template v-if="user === undefined">
          <p>Laden...</p>
        </template>
        <template v-else>
          <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>
          <template v-if="user">
            <Button @click="signOut(auth)">Uitloggen</Button>
          </template>
          <template v-else>
            <h2>Inloggen</h2>
            <form @submit.prevent>
              <div class="form-input">
                <label for="username">Email</label>
                <div>
                  <InputText inputId="email" type="text" v-model="email"/>
                </div>
              </div>
              <div class="form-input">
                <label for="password">Wachtwoord</label>
                <div>
                  <Password inputId="password" v-model="password" :feedback="false"/>
                </div>
              </div>
              <div class="form-input">
                <Button type="submit" @click="signIn()" label="Login"></Button>
              </div>
            </form>
          </template>
        </template>
      </main>
    </template>
  </form-page>

</template>

<style scoped>
.form-input {
  margin: 1em;
}
</style>