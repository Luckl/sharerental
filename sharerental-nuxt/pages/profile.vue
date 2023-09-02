<template>
  <client-only>
    <Card class="m-1 p-1">
      <template #header class="m-1">
        <h2>Welkom, {{ username }}</h2>
      </template>
      <template #content>
        <div>
          <div class="mb-1" >
            <Button @click="showCreateLessor = true">Verhuurder worden</Button>
          </div>
          <div class="mb-1">
            <Button @click="signOut(auth)">Uitloggen</Button>
          </div>
        </div>
      </template>
    </Card>

    <Card v-if="showCreateLessor" class="m-1 p-1">
      <template #header class="m-1">
        <h3>Registreren als verhuurder</h3>
      </template>
      <template #content class="flexbox-column">
        <form @submit="onSubmitNewLessor">
          <div class="flexbox-column">
            <label for="fName" class="mb-1">Weergavenaam</label>
            <InputText id="fName" class="mb-1" v-model="fName"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="fZipCode" class="mb-1">Postcode</label>
            <InputText id="fZipCode" class="mb-1" v-model="fZipCode"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="fHouseNumber" class="mb-1">Huisnummer</label>
            <InputText id="fHouseNumber" class="mb-1" v-model="fHouseNumber"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="fHouseNumberAddition" class="mb-1">Toevoeging</label>
            <InputText id="fHouseNumberAddition" class="mb-1 fit" v-model="fHouseNumberAddition"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="fCity" class="mb-1">Woonplaats</label>
            <InputText id="fCity" class="mb-1 fit" v-model="fCity"></InputText>
          </div>
          <div class="flexbox-row mb-1">
            <div class="flex align-items-center ">
              <RadioButton v-model="fCountry" inputId="NL" name="fCountry" value="Nederland"/>
              <label for="NL" class="ml-2">Nederland</label>
            </div>
            <div class="flex align-items-center">
              <RadioButton v-model="fCountry" inputId="BE" name="fCountry" value="België"/>
              <label for="BE" class="ml-2">België</label>
            </div>
          </div>
          <div >
          <Button type="submit">Aanmaken</Button>
          </div>
        </form>
      </template>
    </Card>
  </client-only>
</template>
<script setup lang="ts">

import {useAsyncData, useNuxtApp} from "#app";
import {signOut} from "firebase/auth";

let user = useCurrentUser();
const auth = useFirebaseAuth()!!
const username = user.value?.displayName

const showCreateLessor = ref(false)
const fName = ref<string>()
const fZipCode = ref<string>()
const fHouseNumber = ref<string>()
const fHouseNumberAddition = ref<string>()
const fCity = ref<string>()
const fCountry = ref<string>()

const {$lessorClient} = useNuxtApp();
const pageable = {
  page: 0,
  pageSize: 20,
  sort: []
}

const result = await useAsyncData('findLessors', async () => {
  return await $lessorClient.findAll(pageable);
})

function onSubmitNewLessor() {

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