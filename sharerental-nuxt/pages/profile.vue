<template>
  <client-only>
    <Card class="m-1 p-1">
      <template #header class="m-1">
        <h2>Welkom, {{ username }}</h2>
      </template>
      <template #content>
        <div>
          <div class="mb-1">
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
      <template #content class="flexbox">
        <form @submit="onSubmitNewLessor">
          <!--private String addressLine1;
            private String addressLine2;
            private String addressLine3;
            private String street;
            private String houseNumber;
            private String houseNumberAddition;
            private String postalCode;
            private String city;
            private String country;-->
          <div class="formInputRow">
            <label for="fName">Weergavenaam</label>
            <InputText id="fName" v-model="fName"></InputText>
          </div>
          <div>
            <label for="fName">Omschrijving</label>
            <Editor id="fDescription" editorStyle="height: 120px" v-model="fDescription">
              <template v-slot:toolbar>
        <span class="ql-formats">
            <button v-tooltip.bottom="'Bold'" class="ql-bold"></button>
            <button v-tooltip.bottom="'Italic'" class="ql-italic"></button>
            <button v-tooltip.bottom="'Underline'" class="ql-underline"></button>
        </span>
              </template>
            </Editor>
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
const fDescription = ref<string>()

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
.formInputRow {
  margin: 1rem
}

.flexbox {
  display: flex;
  flex-direction: column
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