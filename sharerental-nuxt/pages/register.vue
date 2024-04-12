<script lang="ts" setup>
import {createUserWithEmailAndPassword, GoogleAuthProvider, updateProfile} from 'firebase/auth'
import {useCurrentUser, useFirebaseAuth} from 'vuefire'
import {useUserStore} from "~/services/stores/userStore";

definePageMeta({
  linkTitle: 'Login',
  order: 1,
})

const auth = useFirebaseAuth()! // only exists on client side
auth.languageCode = "nl"
const provider = new GoogleAuthProvider()
const userStore = useUserStore()
const user = ref(userStore.user)
const router = useRouter()
const email = ref("")
const password = ref("")
const username = ref("")
const errorParser = new RegExp('.*\\((.*)\\).*')

function register() {
  createUserWithEmailAndPassword(auth, email.value, password.value)
      .then((result) => updateProfile(result.user, {displayName: username.value, photoURL: "null"}))
      .then(() => {
        userStore.refreshUser()
        router.push("/lessor/profile")
      })
      .catch((reason) => {
        error.value = errorParser.exec(reason.message)?.pop()
      })
}

onMounted(() => {
  userStore.refreshUser()
  if (userStore.user) {
    router.push("/")
  }
})

// display errors if any
const error = ref<String | undefined>(undefined)

const sticky = ref(false)
</script>

<template>
  <Head>
    <Title>Registreren</Title>
  </Head>
  <div class="md:max-w-[1240px] md:mx-auto flex gap-2 md:gap-10 px-4 md:px-0 md:flex-row flex-col mt-5">

  <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>
    <div v-if="!user">
      <h2>Registreren</h2>
      <div class="form-input">
        <label for="username">Gebruikersnaam</label>
        <div>
          <InputText inputId="username" type="text" v-model="username"/>
        </div>
      </div>
      <div class="form-input">
        <label for="email">Email</label>
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
        <Button type="submit" label="Registreer" @click="register()"></Button>
      </div>
    </div>
  </div>
</template>
  <style scoped>
    .form-input {
      margin: 1em;
    }
  </style>