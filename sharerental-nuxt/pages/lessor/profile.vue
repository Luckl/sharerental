<template>
  <Head>
    <Title>Gegevens</Title>
  </Head>
  <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>
  <Message severity="success" v-if="message" v-bind:sticky="false">{{ message }}</Message>
  <div class="md:max-w-[1240px] md:mx-auto mt-10 md:grid md:grid-cols-2 gap-8 flex flex-col px-4">
    <form-page>
      <template #header>
        <span class="font-bold text-xl m-1">Profiel</span>
      </template>
      <template #content>
        <Button v-if="user" @click="signOut()">Uitloggen</Button>
      </template>
    </form-page>

    <form-page v-show="loaded && availableLessors?.length == 0">
      <template #header>
        <span class="font-bold text-xl m-1">Registreren als verhuurder</span>
      </template>
      <template #content class="flexbox-column">
        <form @submit="onSubmit">
          <span class="text-xl font-bold block mb-5">Vul je gegevens in.</span>
          <div class="flex gap-2">
            <sr-text-field label="Weergavenaam" v-model="name"
                           :errors="errors['lessor.name']"></sr-text-field>
          </div>
          <div class="flex gap-2">
            <sr-text-field label="Omschrijving" v-model="description"
                           :errors="errors['lessor.description']"></sr-text-field>
          </div>
          <div class="flex gap-2">
            <sr-text-field label="Telefoonnummer" v-model="phoneNumber"
                           :errors="errors['lessor.phoneNumber']"></sr-text-field>
          </div>
          <div class="flex gap-2">
            <sr-text-field label="Postcode" v-model="postalCode" @change="fetchZipInfo()"
                           :errors="errors['lessor.location.postalCode']"></sr-text-field>
            <sr-text-field label="Huisnummer" v-model="houseNumber" @change="fetchZipInfo()"
                           :errors="errors['lessor.location.houseNumber']"></sr-text-field>
          </div>
          <small id="help" class="p-error">{{ postalCodeLookupError }}</small>
          <div class="flex gap-2">
            <sr-text-field label="Straat" v-model="street" disabled
                           :errors="errors['lessor.location.street']"></sr-text-field>
            <sr-text-field label="Stad" v-model="city" disabled
                           :errors="errors['lessor.location.city']"></sr-text-field>
          </div>
          <div class="flex gap-2">
            <div class="h-8 align-middle">
              <label for="Nederland" class="mr-2">Nederland</label>
              <RadioButton v-model="country" value="Nederland" binary inputId="Nederland"></RadioButton>
            </div>
            <div>
              <label for="België" class="mr-2">België</label>
              <RadioButton v-model="country" value="België" binary inputId="België"></RadioButton>
            </div>
          </div>

          <Button type="submit" label="Verhuurder aanmaken"></Button>
        </form>
      </template>
    </form-page>
    <form-page v-show="loaded && availableLessors?.length > 0">
      <template #header>
        <span class="font-bold text-xl m-1">Paginas</span>
      </template>
      <template #content>
        <div class="flex gap-2">
          <nuxt-link to="/lessor/items">
            <Button>Artikelen</Button>
          </nuxt-link>
          <nuxt-link to="/lessor/transactions">
            <Button>Transacties</Button>
          </nuxt-link>
        </div>
      </template>
    </form-page>
    <form-page v-show="loaded && availableLessors?.length > 0">
      <template #header>
        <span class="font-bold text-xl m-1">Gegevens</span>
      </template>
      <template #content>
        <div class="flexbox-column">
          <span class="data-label mb-1">Weergavenaam</span>
          <span class="mb-1">{{ activeLessor?.name }}</span>
        </div>
        <div class="flexbox-column">
          <span class="data-label mb-1">Omschrijving</span>
          <span class="mb-1">{{ activeLessor?.description }}</span>
        </div>
        <Divider align="left" type="solid" class="mb-1">
          <span>Locatiegegevens</span>
        </Divider>
        <div class="flexbox-column">
          <span class="data-label mb-1">Adres</span>
          <span>{{
              activeLessor?.primaryLocation?.street
            }} {{ activeLessor?.primaryLocation?.houseNumber }}</span>
        </div>
        <div class="flexbox-column">
          <span class="data-label mb-1">Plaatsnaam</span>
          <span>{{ activeLessor?.primaryLocation?.postalCode }}, {{ activeLessor?.primaryLocation?.city }}</span>
        </div>
        <Divider align="left" type="solid" class="mb-1">
          <span>Contactgegevens</span>
        </Divider>
        <div class="flexbox-column">
          <span class="data-label mb-1">Telefoonnummer</span>
          <span>{{ activeLessor?.phoneNumber }}</span>
        </div>
      </template>

    </form-page>
  </div>
</template>
<script setup lang="ts">

import {useUserStore} from "~/services/stores/userStore";
import {signOut as signOutFirebase} from "@firebase/auth";
import {useLessorStore} from "~/services/stores/lessorStore";
import {storeToRefs} from "pinia";
import {LessorApi} from "~/schemas/openapi/lessor";
import {RenterType} from "~/schemas/openapi/renter";

let user = useCurrentUser();
const auth = useFirebaseAuth()!!
const userStore = useUserStore()
const lessorStore = useLessorStore()
const router = useRouter()
const {availableLessors, activeLessor} = storeToRefs(lessorStore)
const loaded = ref(false)
const message = ref<String | undefined>(undefined)
const error = ref<String | undefined>(undefined)
import * as yup from "yup";
import {useForm} from "vee-validate";
import SrTextField from "~/components/SrTextField.vue";
import {ZipcodeApi} from "~/schemas/openapi/contactForm";

const zipcodeApi: ZipcodeApi = useNuxtApp().$zipcodeApi;
const postalCodeLookupError = ref<String | undefined>(undefined)

const schema = yup.object({
  lessor: yup.object({
    name: yup.string().required().label("Weergavenaam"),
    description: yup.string().required().label("Omschrijving"),
    phoneNumber: yup.string().required().label("Telefoonnummer"),
    location: yup.object({
      street: yup.string().required().label("Straat"),
      houseNumber: yup.string().required().label("Huisnummer"),
      postalCode: yup.string().required().label("Postcode"),
      city: yup.string().required().label("Stad"),
      country: yup.mixed().oneOf(["Nederland", "België"]).required().label("Land"),
    })
  }),
});

const {defineField, errors, handleSubmit} = useForm({
  validationSchema: schema,
  initialValues: {
    lessor: {
      name: "",
      description: "",
      phoneNumber: "",
      location: {
        street: "",
        houseNumber: "",
        postalCode: "",
        city: "",
        country: "Nederland",
      }
    }
  }
});

const [name] = defineField("lessor.name");
const [description] = defineField("lessor.description");
const [phoneNumber] = defineField("lessor.phoneNumber");
const [street] = defineField("lessor.location.street");
const [houseNumber] = defineField("lessor.location.houseNumber");
const [postalCode] = defineField("lessor.location.postalCode");
const [city] = defineField("lessor.location.city");
const [country] = defineField("lessor.location.country");

const fetchZipInfo = async () => {
  if (postalCode.value.length === 6 && houseNumber.value.length > 0) {
    await zipcodeApi.getAddressByZipcode({
      zipcode: postalCode.value,
      houseNumber: houseNumber.value
    }).then((response) => {
          street.value = response.street ?? ""
          city.value = response.city ?? ""
          country.value = response.country ?? ""
        },

        () => {
          postalCodeLookupError.value = "Adres niet gevonden"
        })
  }
}

const $lessorApi: LessorApi = useNuxtApp().$lessorApi;

async function signOut() {
  await signOutFirebase(auth)
      .then(() => {
        userStore.refreshUser()
            .then(() => {
              lessorStore.reloadLessors()
            }).then(() => {
          router.push("/")
        })
      })
}

onMounted(() => {
  lessorStore.reloadLessors()
      .then(() => {
        loaded.value = true
      })

})

const onSubmit = handleSubmit(values => {
      $lessorApi.createLessor({

        lessorInput: {
          name: values.lessor.name,
          description: values.lessor.description,
          phoneNumber: values.lessor.phoneNumber,
          street: values.lessor.location.street,
          houseNumber: values.lessor.location.houseNumber,
          postalCode: values.lessor.location.postalCode,
          city: values.lessor.location.city,
          country: values.lessor.location.country
        }
      })

          .then(success => {
                message.value = "Succesvol aangemaakt"
                lessorStore.reloadLessors()
                userStore.refreshUser()
              },
              failureReason => {
                error.value = "Er is iets fout gegaan"
              })
    })
;

</script>
<style>

.flexbox-column {
  display: flex;
  flex-direction: column
}

.mb-1 {
  margin-bottom: 1rem
}

.data-label {
  font-weight: bold;
}

</style>