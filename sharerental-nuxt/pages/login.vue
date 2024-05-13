<script lang="ts" setup>
import {
  GoogleAuthProvider,
  signInWithEmailAndPassword,
  signInWithPopup,
  signOut as signOutFirebase
} from 'firebase/auth'
import {useFirebaseAuth} from 'vuefire'
import {useRouter} from "#app";
import {useUserStore} from "~/services/stores/userStore";
import {useLessorStore} from "~/services/stores/lessorStore";

definePageMeta({
  linkTitle: 'Login'
})

const auth = useFirebaseAuth()! // only exists on client side
const userStore = useUserStore()
const lessorStore = useLessorStore()
const user = userStore.user
const router = useRouter()
const email = ref("")
const password = ref("")
const errorParser = new RegExp('.*\\((.*)\\).*')

const googleProvider = new GoogleAuthProvider();

function signInCredentials() {
  signInWithEmailAndPassword(auth, email.value, password.value)
      .then(() => {
        userStore.refreshUser()
            .then(() => {
              lessorStore.loadLessors()
            }).then(() => {
          router.push("/")
        })
      }, (reason) => {
        error.value = errorParser.exec(reason.message)?.pop()
      })
}

function signInGoogle() {
  signInWithPopup(auth, googleProvider)
      .then(() => {
        userStore.refreshUser()
            .then(() => {
              lessorStore.loadLessors()
            }).then(() => {
          router.push("/")
        })
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
  <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">
    <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>
    <div class="max-w-[620px] mx-auto flex flex-col mt-10 gap-4">
      <h1 class=" text-4xl font-bold text-green-900">ShareRental</h1>
      <h1 class=" text-2xl">Inloggen</h1>

      <form @submit.prevent>
        <div class="flex flex-col gap-2 w-full">
          <InputText placeholder="E-mailadres" inputId="email" type="text" v-model="email"/>
          <Password :pt="{ input: 'w-full' }"  placeholder="Wachtwoord" inputId="password"
                    toggleMask v-model="password" :feedback="false"/>
          <Button type="submit" @click="signInCredentials()" label="Inloggen"></Button>
          <Button type="button" @click="router.push('/register')" label="Registreren"></Button>
          <Button type="button" @click="signInGoogle()" label="Inloggen met Google"></Button>

        </div>
      </form>

    </div>
  </div>

</template>

<style scoped>
</style>