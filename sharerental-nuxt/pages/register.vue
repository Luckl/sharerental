<script lang="ts" setup>
import {createUserWithEmailAndPassword, GoogleAuthProvider} from 'firebase/auth'
import {useFirebaseAuth} from 'vuefire'
import {useUserStore} from "~/services/stores/userStore";
import {useForm} from "vee-validate";
import * as yup from 'yup';

definePageMeta({
  linkTitle: 'Login'
})

const auth = useFirebaseAuth()! // only exists on client side
auth.languageCode = "nl"
const provider = new GoogleAuthProvider()
const userStore = useUserStore()
const user = ref(userStore.user)
const router = useRouter()
const errorParser = new RegExp('.*\\((.*)\\).*')

const schema = yup.object({
  email: yup.string().email().required().label("Emailadres"),
  password: yup.string().required().length(6).label("Wachtwoord"),
  passwordConfirm: yup.string().required().oneOf([yup.ref('password')], 'Wachtwoorden moeten overeenkomen')
      .label("Wachtwoord herhalen"),
  type: yup.string().required().label('Gebruikerstype'),
})

const {defineField, handleSubmit, errors} = useForm({
  validationSchema: schema,
});

const options = ['Huren', 'Verhuren'].map((o) => ({
  name: o,
  value: o.toLowerCase(),
}));

const [email] = defineField("email")
const [password] = defineField("password")
const [passwordConfirm] = defineField("passwordConfirm")
const [type] = defineField('type');

const onSubmit = handleSubmit(async () => {
  await createUserWithEmailAndPassword(auth, email.value, password.value)
      .then(() => {
        userStore.refreshUser()
            .then(() => router.push("/lessor/profile"))
      })
      .catch((reason) => {
        error.value = errorParser.exec(reason.message)?.pop()
      })
})

onMounted(() => {
  userStore.refreshUser()
  if (userStore.user) {
    router.push("/lessor/profile")
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
      <form novalidate @submit="onSubmit">
        <div class="form-input">
          <label for="email">Email</label>
          <div>
            <InputText inputId="email"
                       type="email"
                       v-model="email"
                       aria-describedby="email-help"
                       :class="{ 'p-invalid': errors.email }"
            />
          </div>
          <small id="email-help" class="p-error">{{ errors.email }}</small>
        </div>
        <div class="form-input">
          <label for="password">Wachtwoord</label>
          <div>
            <Password inputId="password"
                      v-model="password"
                      :feedback="false"
                      aria-describedby="password-help"
                      :class="{ 'p-invalid': errors.password }"
            />
          </div>
          <small id="password-help" class="p-error">
            {{ errors.password }}
          </small>
        </div>
        <div class="form-input">
          <label for="passwordConfirm">Wachtwoord herhalen</label>
          <div>
            <Password inputId="passwordConfirm"
                      v-model="passwordConfirm"
                      :feedback="false"
                      aria-describedby="passwordConfirm-help"
                      :class="{ 'p-invalid': errors.passwordConfirm }"
            />
          </div>
          <small id="passwordConfirm-help" class="p-error">
            {{ errors.passwordConfirm }}
          </small>
        </div>
        <div class="form-input">
          <label for="type">Gebruikerstype</label>
          <div>
            <Dropdown
                v-model="type"
                :options="options"
                optionLabel="name"
                optionValue="value"
                :class="{ 'p-invalid': errors.type }"
                placeholder="Wat wil je doen?"
            />
          </div>
          <small id="email-help" class="p-error">{{ errors.type }}</small>
        </div>
        <div class="form-input">
          <Button type="submit" label="Registreer"></Button>
        </div>
      </form>
    </div>
  </div>
</template>
<style scoped>
.form-input {
  margin: 1em;
}
</style>