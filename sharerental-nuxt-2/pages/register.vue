<script lang="ts">
import {GoogleAuthProvider} from 'firebase/auth'

export const googleAuthProvider = new GoogleAuthProvider()
</script>

<script lang="ts" setup>
import {
  createUserWithEmailAndPassword
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

function register() {
  createUserWithEmailAndPassword(auth, email.value, password.value).catch((reason) => {
    console.error('Failed registration', reason)
    error.value=reason
  })
}

// display errors if any
const error = ref<Error | null>(null)

const sticky = ref(false)
const route = useRoute()
</script>

<template>
  <main>
    <template v-if="user === undefined">
      <p>Loading...</p>
    </template>
    <template v-else>
      <Message severity="error" v-if="error" v-bind:sticky="false">{{ error.value?.message }}</Message>
      <template v-if="!user">
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
          <Button label="Register" @click="register()"></Button>
        </div>
      </template>
    </template>
  </main>
</template>

<style scoped>

</style>