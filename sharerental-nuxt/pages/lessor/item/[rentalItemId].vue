<template>
  <Head>
    <Title>Artikelen</Title>
  </Head>
  <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>

  <FormPage>
    <template #header>
      <span class="font-bold text-xl m-1">Artikel toevoegen</span>
    </template>
    <template #content class="flexbox-column">
      <RentalItemForm :rentalItem="formInput" :submit="onSubmitNewItem" submitButtonText="Aanpassen"></RentalItemForm>
    </template>
  </FormPage>
</template>
<script setup lang="ts">
import type {RentalItemInput} from "~/schemas/openapi/rentalItem";
import {useRoute} from "#app";

const router = useRouter()
const error = ref<String | undefined>(undefined)
const $rentalItemApi = useNuxtApp().$rentalItemApi;
const route = useRoute();
const itemId = Number.parseInt(Array.isArray(route.params.rentalItemId) ? route.params.rentalItemId[0] : route.params.rentalItemId);

const formInput = reactive<RentalItemInput>({
  name: ""
})

onMounted(() => {
  fetchItem();
})

function fetchItem() {
  $rentalItemApi.getRentalItem({id: itemId})
      .then(
          success => {
            Object.assign(formInput, success)
          }
      )
}

function onSubmitNewItem() {

  $rentalItemApi.updateRentalItem({
    id: itemId,
    rentalItemInput: formInput
  })
      .then(success => {
            router.push('/lessor/items')
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

</style>