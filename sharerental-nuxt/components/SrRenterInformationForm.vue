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

const $renterClient: RenterClient = useNuxtApp().$renterClient;
const contactFormClient: ContactFormClient = useNuxtApp().$contactFormClient;

const props = defineProps<{
  modelValue: Renter,
  saveAction: () => void
}>()

const auth = useFirebaseAuth()! // only exists on client side
const userStore = useUserStore()
const toast = useToast()

const emits = defineEmits(['update:modelValue'])

const renter = ref<Renter>({
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
});

onMounted(() => {
  getRenter()
})

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

const editRenterInfo = ref(false);

function enableRenterEditMode() {
  firstName.value = renter.value.firstName
  lastName.value = renter.value.lastName
  email.value = renter.value.email
  phoneNumber.value = renter.value.phoneNumber
  street.value = renter.value.location?.street
  houseNumber.value = renter.value.location?.houseNumber
  postalCode.value = renter.value.location?.postalCode
  city.value = renter.value.location?.city
  country.value = renter.value.location?.country

  editRenterInfo.value = true
}

const options = ['Nederland', 'België'].map((o) => ({
  name: o,
  value: o.toLowerCase(),
}));


const onSubmit = handleSubmit(async () => {
  renter.value = {
    id: renter.value.id,
    firstName: firstName.value,
    lastName: lastName.value,
    email: email.value,
    phoneNumber: phoneNumber.value,
    location: {
      street: street.value,
      houseNumber: houseNumber.value,
      postalCode: postalCode.value,
      city: city.value,
      country: country.value
    }
  }
  emits('update:modelValue', renter.value)

  if (createAccount.value) {
    await createUserWithEmailAndPassword(auth, email.value, password.value)
        .then(() => {
              userStore.refreshUser()
                  .then(() =>
                      contactFormClient.registerUser(UserUserTypeEnum.Renter)
                          .then(() => props.saveAction()))
            },
            (reason) => {
              toast.add({
                severity: 'error', summary: 'Er is iets fout gegaan', detail: reason,
                life: 5000
              })
            })
  } else {
    props.saveAction()
  }
})

function getRenter() {
  $renterClient.getRenter().then(
      success => {
        renter.value = success
      },
      () => {
        editRenterInfo.value = true
      }
  )
}
</script>
<template>
  <div v-if="!editRenterInfo">
    <span class="p-text-secondary block mb-5">Controleer je gegevens.</span>
    <div class="flexbox-column">
      <label for="fName" class="data-label mb-1">Naam</label>
      <span>{{ renter.firstName }}</span>
    </div>
    <div class="flexbox-column">
      <label for="lName" class="data-label mb-1">Achternaam</label>
      <span>{{ renter.lastName }}</span>
    </div>
    <div class="flexbox-column">
      <label for="email" class="data-label mb-1">Email</label>
      <span>{{ renter.email }}</span>
    </div>
    <div class="flexbox-column">
      <label for="phoneNumber" class="data-label mb-1">Telefoonnummer</label>
      <span>{{ renter.phoneNumber }}</span>
    </div>
    <div class="flexbox-column">
      <label for="street" class="data-label mb-1">Straat</label>
      <span>{{ renter.location?.street }}</span>
    </div>
    <div class="flexbox-column">
      <label for="houseNumber" class="data-label mb-1">Huisnummer</label>
      <span>{{ renter.location?.houseNumber }}</span>
    </div>
    <div class="flexbox-column">
      <label for="postalCode" class="data-label mb-1">Postcode</label>
      <span>{{ renter.location?.postalCode }}</span>
    </div>
    <div class="flexbox-column">
      <label for="city" class="data-label mb-1">Stad</label>
      <span>{{ renter.location?.city }}</span>
    </div>
    <div class="flexbox-column">
      <label for="country" class="data-label mb-1">Land</label>
      <span>{{ renter.location?.country }}</span>
    </div>
  </div>
  <div class="flex flex-col" v-else>
    <form novalidate @submit="onSubmit">
      <span class="p-text-secondary block mb-5">Vul je gegevens in.</span>
      <div class="flex gap-2">
        <sr-text-field label="Emailadres" type="email" v-model="email" :errors="errors.email"></sr-text-field>
        <div class="flex gap-2 items-center">
          <div>
            <label for="createAccount">Maak een account aan</label>
          </div>
          <Checkbox v-model="createAccount"
                    :class="{ 'p-invalid': errors.terms }"
                    binary
          ></Checkbox>
        </div>
      </div>
      <div class="flex gap-2" v-if="createAccount">
        <sr-text-field label="Wachtwoord" type="password" v-model="password" :errors="errors.password"></sr-text-field>
        <sr-text-field label="Wachtwoord herhalen" type="password" v-model="passwordConfirm"
                       :errors="errors.passwordConfirm"></sr-text-field>
      </div>
      <divider></divider>
      <div class="flex gap-2">
        <sr-text-field label="Voornaam" v-model="firstName" :errors="errors.firstName"></sr-text-field>
        <sr-text-field label="Achternaam" v-model="lastName" :errors="errors.lastName"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Telefoonnummer" v-model="phoneNumber" :errors="errors.phoneNumber"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Postcode" v-model="postalCode" :errors="errors.postalCode"></sr-text-field>
        <sr-text-field label="Huisnummer" v-model="houseNumber" :errors="errors.houseNumber"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Straat" v-model="street" :errors="errors.street"></sr-text-field>
        <sr-text-field label="Plaatsnaam" v-model="city" :errors="errors.city"></sr-text-field>
      </div>
      <label for="country">Land</label>
      <div>
        <Dropdown
            v-model="country"
            :options="options"
            optionLabel="name"
            optionValue="value"
            :class="{ 'p-invalid': errors.country }"
            placeholder="Selecteer een land"
        />
      </div>
      <small id="country-help" class="p-error">{{ errors.country }}</small>
      <div class="flex justify-content-end gap-2">
        <Button type="submit" label="Huren"></Button>
      </div>
    </form>
  </div>
  <div v-if="!editRenterInfo">
    <Button type="button" label="Aanpassen" @click="enableRenterEditMode()"></Button>
  </div>
  <div v-if="!editRenterInfo" class="flex justify-content-end gap-2">
    <Button type="button" label="Huren" @click="onSubmit"></Button>
  </div>
</template>
