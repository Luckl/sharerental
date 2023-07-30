<script lang="ts" setup>
import {
  signInWithEmailAndPassword,
  signOut,
} from 'firebase/auth'
import {useCurrentUser, useFirebaseAuth} from 'vuefire'

definePageMeta({
  linkTitle: 'Login',
  order: 1,
})

const auth = useFirebaseAuth()! // only exists on client side
const user = useCurrentUser()

const email = ref("")
const password = ref("")

function signIn() {
  signInWithEmailAndPassword(auth, email.value, password.value).catch((reason) => {
    console.error('Failed signIn', reason)
    error.value=reason
  })
}

// display errors if any
const error = ref<Error | null>(null)

const sticky = ref(false)
</script>

<template>
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
          <strong>{{ user.displayName }}.</strong>
        </p>

        <button @click="signOut(auth)">Logout</button>
      </template>
      <template v-else>
        <div>
          <label for="username">Email</label>
          <div>
            <InputText type="text" v-model="email"/>
          </div>
        </div>
        <div>
          <label for="password">Password</label>
          <div>
            <Password v-model="password" :feedback="false"/>
          </div>
        </div>
        <div>
          <Button label="Login" @click="signIn()"></Button>
        </div>
      </template>
    </template>
  </main>
</template>

<style scoped>

</style>