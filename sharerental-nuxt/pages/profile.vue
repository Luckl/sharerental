<template>
  <Head>
    <Title>Gegevens - ShareRental</Title>
  </Head>
  <client-only>
    <Message severity="error" v-if="message" v-bind:sticky="false">{{ message }}</Message>
    <Message severity="success" v-if="message" v-bind:sticky="false">{{ message }}</Message>
    <div v-show="loaded && lessors.length == 0">
      <form-page>
        <template #header>
          <h3>Registreren als verhuurder</h3>
        </template>
        <template #content class="flexbox-column">
          <form @submit.prevent>
            <div class="flexbox-column">
              <label for="fName" class="mb-1">Weergavenaam</label>
              <InputText id="fName" class="mb-1" v-model="formInput.name"></InputText>
            </div>
            <div class="flexbox-column">
              <label for="fDescription" class="mb-1">Omschrijving</label>
              <InputText id="fDescription" class="mb-1" v-model="formInput.description"></InputText>
            </div>
            <div class="flexbox-column">
              <label for="fPostalCode" class="mb-1">Postcode</label>
              <InputText id="fPostalCode" class="mb-1" v-model="formInput.postalCode"></InputText>
            </div>
            <div class="flexbox-column">
              <label for="fHouseNumber" class="mb-1">Huisnummer</label>
              <InputText id="fHouseNumber" class="mb-1" v-model="formInput.houseNumber"></InputText>
            </div>
            <div class="flexbox-column">
              <label for="fHouseNumberAddition" class="mb-1">Toevoeging</label>
              <InputText id="fHouseNumberAddition" class="mb-1 fit"
                         v-model="formInput.houseNumberAddition"></InputText>
            </div>
            <div class="flexbox-column">
              <label for="fCity" class="mb-1">Woonplaats</label>
              <InputText id="fCity" class="mb-1 fit" v-model="formInput.city"></InputText>
            </div>
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
              <label for="fCity" class="mb-1">Telefoonnummer</label>
              <InputText id="fCity" class="mb-1 fit" v-model="formInput.phoneNumber"></InputText>
            </div>
            <div>
              <Button @Click="onSubmitNewLessor">Aanmaken</Button>
            </div>
          </form>
        </template>
      </form-page>
    </div>
    <div v-show="loaded && lessors.length > 0">
      <form-page>
        <template #header>
          <h3>Gegevens</h3>
        </template>
      </form-page>
    </div>
  </client-only>

</template>
<script setup lang="ts">

import {useAsyncData, useNuxtApp} from "#app";
import {signOut} from "firebase/auth";
import LessorClient, {Lessor} from "~/services/api/Lessor";

let user = useCurrentUser();
const auth = useFirebaseAuth()!!
const username = user.value?.displayName
const lessors = ref<Lessor[]>([])
const loaded = ref(false)
const message = ref<String | undefined>(undefined)

const formInput = reactive({
  name: "",
  description: "",
  postalCode: "",
  houseNumber: "",
  houseNumberAddition: "",
  city: "",
  country: "",
  phoneNumber: ""
})

const showCreateLessor = ref(false)

const $lessorClient: LessorClient = useNuxtApp().$lessorClient;

const result = useAsyncData('findLessors', async () => {
  return await $lessorClient.findAll(0, 20, []);
}).then(succes => {
      loaded.value = true;
      lessors.value = succes.data.value?.embedded
    },
    failure => {
      loaded.value = true;
    })

function onSubmitNewLessor() {
  $lessorClient.create(formInput)
      .then(success => {
            message.value = "Succesvol aangemaakt"
          },
          failureReason => {
            message.value = "Er is iets fout gegaan"
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

.m-1 {
  margin: 1rem
}

.p-1 {
  padding: 1rem
}

</style>