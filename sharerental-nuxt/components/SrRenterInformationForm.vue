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

defineProps<{
  modelValue: Renter | undefined
}>()

const auth = useFirebaseAuth()! // only exists on client side
const userStore = useUserStore()
const toast = useToast()

const emits = defineEmits(['update:modelValue'])

const updateModelValue = (value: Renter | undefined) => {
  console.log(JSON.stringify(value))
  emits('update:modelValue', value);
};

onMounted(() => {
  if (userStore.user) {
    email.value = userStore.user.email ?? ""
    getRenter()
  } else {
    loadEmptyRenterObject()
  }
  subscribeToNewsletter.value = true
})

const loadEmptyRenterObject = () => {
  editRenterInfo.value = true
}

const schema = yup.object({
  renter: yup.object({
    firstName: yup.string().required().label("Voornaam"),
    lastName: yup.string().required().label("Achternaam"),
    email: yup.string().email().required().label("Emailadres"),
    phoneNumber: yup.string().required().label("Telefoonnummer"),
    location: yup.object({
      street: yup.string().required().label("Straat"),
      houseNumber: yup.string().required().label("Huisnummer"),
      postalCode: yup.string().required().label("Postcode"),
      city: yup.string().required().label("Stad"),
      country: yup.string().required().label("Land"),
    })
  }),
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
  subscribeToNewsletter: yup.boolean().label("Hou me op de hoogte over nieuws en aanbiedingen")
});

const {defineField, errors, values, validate} = useForm({
  validationSchema: schema,
  initialValues: {
    renter: {
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
    },
    createAccount: false,
    password: "",
    passwordConfirm: "",
    subscribeToNewsletter: true
  }
});

watch(values, (value) => {
  const tmpRenter = { ...value.renter }
  tmpRenter.id = existingRenterId.value
  updateModelValue(tmpRenter)
})

const [createAccount] = defineField("createAccount")
const [firstName] = defineField("renter.firstName")
const [lastName] = defineField("renter.lastName")
const [email] = defineField("renter.email")
const [phoneNumber] = defineField("renter.phoneNumber")
const [street] = defineField("renter.location.street")
const [houseNumber] = defineField("renter.location.houseNumber")
const [postalCode] = defineField("renter.location.postalCode")
const [city] = defineField("renter.location.city")
const [country] = defineField("renter.location.country")
const [password] = defineField("password")
const [passwordConfirm] = defineField("passwordConfirm")
const [subscribeToNewsletter] = defineField("subscribeToNewsletter")

const existingRenterId = ref(0);
const editRenterInfo = ref(false);

const createUserIfSelected = async () => {
  if (!createAccount.value) {
    return
  }
  await validate()
      .then(() => {
        createUserWithEmailAndPassword(auth, email.value, password.value)
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
      })
}

const fetchZipInfo = async () => {
  if (postalCode.value.length === 6 && houseNumber.value.length > 0) {
    const response = await contactFormClient.zipcode(postalCode.value, houseNumber.value)
    street.value = response.street ?? ""
    city.value = response.city ?? ""
    country.value = response.country ?? ""
  }
}

function getRenter() {
  $renterClient.getRenter().then(
      success => {

        existingRenterId.value = success.id
        email.value = success.email
        firstName.value = success.firstName
        lastName.value = success.lastName
        phoneNumber.value = success.phoneNumber
        street.value = success.location.street ?? ""
        houseNumber.value = success.location.houseNumber ?? ""
        postalCode.value = success.location.postalCode ?? ""
        city.value = success.location.city ?? ""
        country.value = success.location.country ?? ""

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
      <div class="flex gap-2">
        <sr-text-field label="Emailadres" :disabled="userStore.user" placeholder="Emailadres" type="email" v-model="email"
                       :errors="errors['renter.email']"></sr-text-field>
      </div>
      <div class="flex gap-2 my-1 items-center">
        <Checkbox v-model="subscribeToNewsletter" binary></Checkbox>
        <div>
          <label for="subscribeToNewsletter">Hou me op de hoogte over nieuws en aanbiedingen</label>
        </div>
      </div>
      <div v-if="!userStore.user" class="flex gap-2 my-1 items-center">
        <Checkbox v-model="createAccount"
                  :class="{ 'p-invalid': errors.createAccount }"
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
        <sr-text-field label="Voornaam" v-model="firstName" :errors="errors['renter.firstName']"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Achternaam" v-model="lastName" :errors="errors['renter.lastName']"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Telefoonnummer" v-model="phoneNumber"
                       :errors="errors['renter.phoneNumber']"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Postcode" @change="fetchZipInfo()" v-model="postalCode"
                       :errors="errors['renter.location.postalCode']"></sr-text-field>
        <sr-text-field label="Huisnummer" @change="fetchZipInfo()" v-model="houseNumber"
                       :errors="errors['renter.location.houseNumber']"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Straat" disabled v-model="street"
                       :errors="errors['renter.location.street']"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Plaatsnaam" disabled v-model="city"
                       :errors="errors['renter.location.city']"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Land" disabled v-model="country"
                       :errors="errors['renter.location.country']"></sr-text-field>
      </div>
    </form>
  </div>
  <div v-if="!editRenterInfo">
    <Button type="button" label="Aanpassen" @click="editRenterInfo = true; existingRenterId = 0"></Button>
  </div>
</template>
