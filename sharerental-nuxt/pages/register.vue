<script lang="ts" setup>
import {createUserWithEmailAndPassword, GoogleAuthProvider} from 'firebase/auth'
import {useFirebaseAuth} from 'vuefire'
import {useUserStore} from "~/services/stores/userStore";
import {useForm} from "vee-validate";
import * as yup from 'yup';
import {UserApi, UserUserTypeEnum} from "~/schemas/openapi/contactForm";

definePageMeta({
  linkTitle: 'Login'
})

const auth = useFirebaseAuth()! // only exists on client side
auth.languageCode = "nl"
const userStore = useUserStore()
const router = useRouter()
const errorParser = new RegExp('.*\\((.*)\\).*')
const userApi: UserApi = useNuxtApp().$userApi;

const schema = yup.object({
  email: yup.string().email().required().label("Emailadres"),
  password: yup.string().required().min(6).label("Wachtwoord"),
  passwordConfirm: yup.string().required().oneOf([yup.ref('password')], 'Wachtwoorden moeten overeenkomen')
      .label("Wachtwoord herhalen"),
  type: yup.string().required().label('Gebruikerstype'),
})

const {defineField, handleSubmit, errors} = useForm({
  validationSchema: schema,
});

const [email] = defineField("email")
const [password] = defineField("password")
const [passwordConfirm] = defineField("passwordConfirm")
const [type] = defineField('type');

const onSubmit = handleSubmit(async () => {
  await createUserWithEmailAndPassword(auth, email.value, password.value)
      .then(() => {
        userStore.refreshUser()
            .then(() =>
                userApi.registerUser({
                  user: {
                    userType: type.value.toLowerCase() === 'huren' ? UserUserTypeEnum.Renter : UserUserTypeEnum.Lessor
                  }
                })
                    .then(() =>
                        router.push("/lessor/profile")))
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
  <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">
    <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>
    <div class="max-w-[620px] mx-auto flex flex-col mt-10 gap-4">
      <h1 class=" text-4xl font-bold text-green-900">ShareRental</h1>
      <h1 class=" text-2xl">Registreren</h1>

      <form @submit.prevent @submit="onSubmit">
        <div class="flex flex-col gap-2 w-full">
          <InputText inputId="email"
                     placeholder="E-mailadres"
                     type="email"
                     v-model="email"
                     aria-describedby="email-help"
                     :class="{ 'p-invalid': errors.email }"
          />
          <small id="email-help" class="p-error">{{ errors.email }}</small>
          <Password inputId="password"
                    v-model="password"
                    :feedback="false"
                    placeholder="Wachtwoord"
                    aria-describedby="password-help"
                    :class="{ 'p-invalid': errors.password }"
                    :pt="{input: 'w-full'}"
                    toggleMask
          />
          <small id="password-help" class="p-error">
            {{ errors.password }}
          </small>
          <Password inputId="passwordConfirm"
                    v-model="passwordConfirm"
                    :feedback="false"
                    placeholder="Wachtwoord herhalen"
                    aria-describedby="passwordConfirm-help"
                    :class="{ 'p-invalid': errors.passwordConfirm }"
                    :pt="{input: 'w-full'}"
                    toggleMask
          />
          <small id="passwordConfirm-help" class="p-error">
            {{ errors.passwordConfirm }}
          </small>
          Wat kom je doen?
          <div class="flex flex-row gap-8">
            <div class=" h-8 align-middle">
              <RadioButton v-model="type" inputId="Huren" name="fCountry" value="huren"/>
              <label for="Huren" class="ml-2">Huren</label>
            </div>
            <div>
              <RadioButton v-model="type" inputId="Verhuren" name="fCountry" value="verhuren"/>
              <label for="Verhuren" class="ml-2">Verhuren</label>
            </div>
          </div>
          <Button type="submit" label="Registreren"></Button>

        </div>
      </form>

    </div>
  </div>
</template>