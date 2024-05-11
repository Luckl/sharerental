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
        <form @submit.prevent>
          <div class="flexbox-column">
            <label for="fName" class="data-label mb-1">Weergavenaam</label>
            <InputText inputId="fName" class="mb-1" v-model="formInput.name"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="fDescription" class="data-label mb-1">Omschrijving</label>
            <InputText inputId="fDescription" class="mb-1" v-model="formInput.description"></InputText>
          </div>
          <Divider align="left" type="solid" class="mb-1">
            <span>Locatiegegevens</span>
          </Divider>
          <div class="flexbox-row mb-1">
            <div class="flex align-items-center ">
              <RadioButton v-model="formInput.country" inputId="NL" name="fCountry" value="Nederland"/>
              <label for="NL" class="ml-2">Nederland</label>
            </div>
            <div class="flex align-items-center">
              <RadioButton v-model="formInput.country" inputId="BE" name="fCountry" value="België"/>
              <label for="BE" class="ml-2">België</label>
            </div>
          </div>
          <div class="flexbox-column">
            <label for="fPostalCode" class="data-label mb-1">Postcode</label>
            <InputText inputId="fPostalCode" class="mb-1" v-model="formInput.postalCode"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="fHouseNumber" class="data-label mb-1">Huisnummer</label>
            <InputText inputId="fHouseNumber" class="mb-1" v-model="formInput.houseNumber"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="fHouseNumberAddition" class="data-label mb-1">Toevoeging</label>
            <InputText inputId="fHouseNumberAddition" class="mb-1 fit"
                       v-model="formInput.houseNumberAddition"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="fStreet" class="data-label mb-1">Straat</label>
            <InputText inputId="fStreet" class="mb-1 fit" v-model="formInput.street"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="fCity" class="data-label mb-1">Plaatsnaam</label>
            <InputText inputId="fCity" class="mb-1 fit" v-model="formInput.city"></InputText>
          </div>
          <Divider align="left" type="solid" class="mb-1">
            <span>Contactgegevens</span>
          </Divider>
          <div class="flexbox-column">
            <label for="fCity" class="data-label mb-1">Telefoonnummer</label>
            <InputText inputId="fCity" class="mb-1 fit" v-model="formInput.phoneNumber"></InputText>
          </div>
          <div>
            <Button @Click="onSubmitNewLessor">Aanmaken</Button>
          </div>
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
            }} {{ activeLessor?.primaryLocation?.houseNumber }}{{
              activeLessor?.primaryLocation?.houseNumberAddition
            }}</span>
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

import LessorClient, {type Lessor} from "~/services/api/LessorClient";
import {useUserStore} from "~/services/stores/userStore";
import {signOut as signOutFirebase} from "@firebase/auth";
import {useLessorStore} from "~/services/stores/lessorStore";
import {storeToRefs} from "pinia";

let user = useCurrentUser();
const auth = useFirebaseAuth()!!
const username = user.value?.displayName
const userStore = useUserStore()
const lessorStore = useLessorStore()
const router = useRouter()
const {availableLessors, activeLessor} = storeToRefs(lessorStore)
const loaded = ref(false)
const message = ref<String | undefined>(undefined)
const error = ref<String | undefined>(undefined)
const formInput = reactive({
  name: "",
  description: "",
  street: "",
  postalCode: "",
  houseNumber: "",
  houseNumberAddition: "",
  city: "",
  country: "",
  phoneNumber: ""
})

const $lessorClient: LessorClient = useNuxtApp().$lessorClient;

async function signOut() {
  await signOutFirebase(auth)
      .then(() => {
        userStore.refreshUser()
            .then(() => {
              lessorStore.loadLessors()
            }).then(() => {
          router.push("/")
        })
      })
}

onMounted(() => {
  lessorStore.loadLessors()
      .then(() => {
        loaded.value = true
        console.log(availableLessors.value)
      })

})

function onSubmitNewLessor() {
  $lessorClient.create(formInput)
      .then(success => {
            message.value = "Succesvol aangemaakt"
            lessorStore.loadLessors()
            userStore.refreshUser()
          },
          failureReason => {
            error.value = "Er is iets fout gegaan"
          })
}

</script>
<style>

.flexbox-column {
  display: flex;
  flex-direction: column
}

.flexbox-row {
  display: flex;
  flex-direction: row;
  gap: 2rem
}

.mb-1 {
  margin-bottom: 1rem
}

.data-label {
  font-weight: bold;
}

</style>