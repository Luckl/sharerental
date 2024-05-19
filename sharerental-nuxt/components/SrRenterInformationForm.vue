<script setup lang="ts">
import RenterClient from "~/services/api/RenterClient";
import type {Renter} from "~/schemas/openapi/renter";
import * as yup from "yup";
import {useForm} from "vee-validate";
import {useUserStore} from "~/services/stores/userStore";
import {useToast} from "primevue/usetoast";
import {createUserWithEmailAndPassword} from "firebase/auth";
import {UserUserTypeEnum} from "~/schemas/openapi/contactForm";
import type ContactFormClient from "~/services/api/ContactFormClient";
import container from "parchment/src/blot/abstract/container";

const $renterClient: RenterClient = useNuxtApp().$renterClient;
const contactFormClient: ContactFormClient = useNuxtApp().$contactFormClient;

const props = defineProps<{
  modelValue: Renter | undefined
}>()

const auth = useFirebaseAuth()! // only exists on client side
const userStore = useUserStore()
const toast = useToast()

const emits = defineEmits(['update:modelValue'])

const updateModelValue = (value: Renter | undefined) => {
  emits('update:modelValue', value);
};

onMounted(() => {
  if (userStore.user) {
    getRenter()
  } else {
    loadEmptyRenterObject()
  }
  subscribeToNewsletter.value = true

  firstName.value = props.modelValue?.firstName
  lastName.value = props.modelValue?.lastName
  email.value = props.modelValue?.email
  phoneNumber.value = props.modelValue?.phoneNumber
  street.value = props.modelValue?.location?.street
  houseNumber.value = props.modelValue?.location?.houseNumber
  postalCode.value = props.modelValue?.location?.postalCode
  city.value = props.modelValue?.location?.city
  country.value = props.modelValue?.location?.country
})

const loadEmptyRenterObject = () => {
  updateModelValue({
    id: 0,
    firstName: "",
    lastName: "",
    email: "",
    phoneNumber: "",
    location: {
      street: "",
      houseNumber: "",
      postalCode: "",
      city: "",
      country: ""
    }
  })
  editRenterInfo.value = true
}

const schema = yup.object({
  firstName: yup.string().required().label("Voornaam"),
  lastName: yup.string().required().label("Achternaam"),
  email: yup.string().email().required().label("Emailadres"),
  phoneNumber: yup.string().required().label("Telefoonnummer"),
  street: yup.string().required().label("Straat"),
  houseNumber: yup.string().required().label("Huisnummer"),
  postalCode: yup.string().required().label("Postcode"),
  city: yup.string().required().label("Stad"),
  country: yup.string().required().label("Land"),

  createAccount: yup.boolean().label("Maak een account aan"),

  password: yup.string()
      .when('createAccount',
          ([createAccount], password) =>
              createAccount === true
                  ? password.label("Wachtwoord").required().min(6)
                  : password),

  passwordConfirm: yup.string()
      .when('createAccount',
          ([createAccount], passwordConfirm) =>
              createAccount === true
                  ? passwordConfirm.label("Wachtwoord herhalen").required().oneOf([yup.ref('password')], 'Wachtwoorden moeten overeenkomen')
                  : passwordConfirm),

});

const {defineField, handleSubmit, errors} = useForm({
  validationSchema: schema,
});

const [createAccount] = defineField("createAccount")
const [firstName] = defineField("firstName")
const [lastName] = defineField("lastName")
const [email] = defineField("email")
const [phoneNumber] = defineField("phoneNumber")
const [street] = defineField("street")
const [houseNumber] = defineField("houseNumber")
const [postalCode] = defineField("postalCode")
const [city] = defineField("city")
const [country] = defineField("country")
const [password] = defineField("password")
const [passwordConfirm] = defineField("passwordConfirm")
const [subscribeToNewsletter] = defineField("subscribeToNewsletter")

const editRenterInfo = ref(false);

watch(() => props.modelValue, (value) => {
  updateModelValue(value)
})

const createUserIfSelected = async () => {
  console.log("Successfully called child function")
  if (createAccount.value) {
    await createUserWithEmailAndPassword(auth, email.value, password.value)
        .then(() => {
              userStore.refreshUser()
                  .then(() =>
                      contactFormClient.registerUser(UserUserTypeEnum.Renter)
                  )
            },
            (reason) => {
              toast.add({
                severity: 'error', summary: 'Er is iets fout gegaan', detail: reason,
                life: 5000
              })
            })
  }
}

const fetchZipInfo = async () => {
  if (postalCode.value.length === 6 && houseNumber.value.length > 0) {
    const response = await contactFormClient.zipcode(postalCode.value, houseNumber.value)
    street.value = response.street
    city.value = response.city
    country.value = response.country
  }
}

function getRenter() {
  $renterClient.getRenter().then(
      success => {
        updateModelValue(success)
      },
      () => {
        loadEmptyRenterObject()
      }
  )
}

defineExpose({
  createUserIfSelected
})
</script>
<template>
  <div v-if="!editRenterInfo">
    <span class="p-text-secondary block mb-5">Controleer je gegevens.</span>
    <div class="flexbox-column">
      <label for="email" class="data-label mb-1">Email</label>
      <span>{{ modelValue?.email }}</span>
    </div>
    <div class="flexbox-column">
      <label for="fName" class="data-label mb-1">Naam</label>
      <span>{{ modelValue?.firstName }}</span>
    </div>
    <div class="flexbox-column">
      <label for="lName" class="data-label mb-1">Achternaam</label>
      <span>{{ modelValue?.lastName }}</span>
    </div>
    <div class="flexbox-column">
      <label for="phoneNumber" class="data-label mb-1">Telefoonnummer</label>
      <span>{{ modelValue?.phoneNumber }}</span>
    </div>
    <div class="flexbox-column">
      <label for="street" class="data-label mb-1">Straat</label>
      <span>{{ modelValue?.location?.street }}</span>
    </div>
    <div class="flexbox-column">
      <label for="houseNumber" class="data-label mb-1">Huisnummer</label>
      <span>{{ modelValue?.location?.houseNumber }}</span>
    </div>
    <div class="flexbox-column">
      <label for="postalCode" class="data-label mb-1">Postcode</label>
      <span>{{ modelValue?.location?.postalCode }}</span>
    </div>
    <div class="flexbox-column">
      <label for="city" class="data-label mb-1">Stad</label>
      <span>{{ modelValue?.location?.city }}</span>
    </div>
    <div class="flexbox-column">
      <label for="country" class="data-label mb-1">Land</label>
      <span>{{ modelValue?.location?.country }}</span>
    </div>
  </div>
  <div class="flex flex-col" v-else>
    <form novalidate>
      <span class="text-xl font-bold block mb-5">Vul je gegevens in.</span>
      <div v-if="userStore.user" class="flex gap-2 mb-5 w-full">
        <sr-text-field label="Emailadres" disabled placeholder="Emailadres" type="email" v-model="userStore.user.email"
                       :errors="errors.email"></sr-text-field>
      </div>
      <div v-if="!userStore.user" class="flex gap-2">
        <sr-text-field label="Emailadres" placeholder="Emailadres" type="email" v-model="email"
                       :errors="errors.email"></sr-text-field>
      </div>
      <div class="flex gap-2 my-1 items-center">
        <Checkbox v-model="subscribeToNewsletter" binary></Checkbox>
        <div>
          <label for="subscribeToNewsletter">Hou me op de hoogte over nieuws en aanbiedingen</label>
        </div>
      </div>
      <div v-if="!userStore.user" class="flex gap-2 my-1 items-center">
        <Checkbox v-model="createAccount"
                  :class="{ 'p-invalid': errors.terms }"
                  binary
        ></Checkbox>
        <div>
          <label for="createAccount">Maak een account aan</label>
        </div>
      </div>
      <div class="flex gap-2" v-if="createAccount && !userStore.user">
        <sr-text-field label="Wachtwoord" type="password" v-model="password" :errors="errors.password"></sr-text-field>
      </div>
      <div class="flex gap-2" v-if="createAccount && !userStore.user">
        <sr-text-field label="Wachtwoord herhalen" type="password" v-model="passwordConfirm"
                       :errors="errors.passwordConfirm"></sr-text-field>
      </div>
      <divider></divider>
      <div class="flex gap-2">
        <sr-text-field label="Voornaam" v-model="firstName" :errors="errors.firstName"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Achternaam" v-model="lastName" :errors="errors.lastName"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Telefoonnummer" v-model="phoneNumber" :errors="errors.phoneNumber"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Postcode" @change="fetchZipInfo()" v-model="postalCode"
                       :errors="errors.postalCode"></sr-text-field>
        <sr-text-field label="Huisnummer" @change="fetchZipInfo()" v-model="houseNumber"
                       :errors="errors.houseNumber"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Straat" disabled v-model="street" :errors="errors.street"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Plaatsnaam" disabled v-model="city" :errors="errors.city"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Land" disabled v-model="country" :errors="errors.country"></sr-text-field>
      </div>
    </form>
  </div>
  <div v-if="!editRenterInfo">
    <Button type="button" label="Aanpassen" @click="editRenterInfo = true"></Button>
  </div>
</template>
