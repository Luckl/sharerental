<script lang="ts" setup>
import {GoogleAuthProvider, signInWithEmailAndPassword, signOut as signOutFirebase} from 'firebase/auth'
import {useFirebaseAuth} from 'vuefire'
import {useRouter} from "#app";
import {useUserStore} from "~/services/stores/userStore";

definePageMeta({
  linkTitle: 'Login',
  order: 1,
})

const auth = useFirebaseAuth()! // only exists on client side
const userStore = useUserStore()
const user = userStore.user
const router = useRouter()
const email = ref("")
const password = ref("")
const errorParser = new RegExp('.*\\((.*)\\).*')

const googleProvider = new GoogleAuthProvider();

googleProvider.addScope('https://www.googleapis.com/auth/contacts.readonly');

function signOut() {
  signOutFirebase(auth)
  userStore.refreshUser()
}

function signIn() {
  signInWithEmailAndPassword(auth, email.value, password.value)
      .then(() => {
        userStore.refreshUser()
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
    <Title>Inloggen</Title>
  </Head>
  <div class="md:max-w-[1240px] md:mx-auto flex gap-2 md:gap-10 px-4 md:px-0 md:flex-row flex-col mt-5">

    <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>
    <template v-if="user">
      <NuxtLink @click="signOut()" to="/">
        <Button>Uitloggen</Button>
      </NuxtLink>
    </template>
    <template v-else>
      <div>
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
          <div class="form-input flex gap-2">
            <Button type="submit" @click="signIn()" label="Inloggen"></Button>
            <NuxtLink to="/register">
              <Button type="button" label="Registreren"></Button>
            </NuxtLink>
          </div>
        </form>
      </div>
    </template>
  </div>

</template>

<style scoped>
.form-input {
  margin: 1em;
}
</style>