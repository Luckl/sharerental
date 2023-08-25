<script lang="ts" setup>
import {signInWithEmailAndPassword, signOut,} from 'firebase/auth'
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

function signIn() {
  signInWithEmailAndPassword(auth, email.value, password.value)
      .then(() => {
        router.push("/profile")
      }, (reason) => {
        error.value = errorParser.exec(reason.message)?.pop()
      })
}

// display errors if any
const error = ref<String | undefined>(undefined)

const sticky = ref(false)
</script>

<template>
  <form-page>
    <main>
      <template v-if="user === undefined">
        <p>Laden...</p>
      </template>
      <template v-else>
        <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>
        <template v-if="user">
          <p>
            Je bent ingelogd als:
            <br/>
            <img
                class="avatar"
                v-if="user.photoURL"
                :src="user.photoURL"
                referrerpolicy="no-referrer"
            />
            <br/>
            <strong>{{ user.displayName }}</strong>
            <strong>{{ user.email }}</strong>
          </p>

          <Button @click="signOut(auth)">Uitloggen</Button>
        </template>
        <template v-else>
          <h2>Inloggen</h2>
          <form>
            <div class="form-input">
              <label for="username">Email</label>
              <div>
                <InputText type="text" v-model="email"/>
              </div>
            </div>
            <div class="form-input">
              <label for="password">Wachtwoord</label>
              <div>
                <Password v-model="password" :feedback="false"/>
              </div>
            </div>
            <div class="form-input">
              <Button label="Login" @click="signIn()"></Button>
            </div>
          </form>
        </template>
      </template>
    </main>
  </form-page>
</template>

<style scoped>
.form-input {
  margin: 1em;
}
</style>