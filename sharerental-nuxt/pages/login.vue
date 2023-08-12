<script lang="ts" setup>
import {
  signInWithEmailAndPassword,
  signOut,
} from 'firebase/auth'
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

function signIn() {
  signInWithEmailAndPassword(auth, email.value, password.value).then(() => {
    router.push("/")
  }, (reason) => {
    console.error('Failed signIn', reason)
    error.value = reason
  })
}

// display errors if any
const error = ref<Error | null>(null)

const sticky = ref(false)
</script>

<template>
  <form-page>
    <main>
      <template v-if="user === undefined">
        <p>Loading...</p>
      </template>
      <template v-else>
        <Message severity="error" v-if="error" v-bind:sticky="false">{{ error.value?.message }}</Message>
        <template v-if="user">
          <p>
            You are currently logged in as:
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

          <Button @click="signOut(auth)">Logout</Button>
        </template>
        <template v-else>
          <h2>Login</h2>
          <form>
            <div class="form-input">
              <label for="username">Email</label>
              <div>
                <InputText type="text" v-model="email"/>
              </div>
            </div>
            <div class="form-input">
              <label for="password">Password</label>
              <div>
                <Password v-model="password" :feedback="false"/>
              </div>
            </div>
            <div class="form-input">
              <Button type="submit" label="Login" on-submit="signIn()"></Button>
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