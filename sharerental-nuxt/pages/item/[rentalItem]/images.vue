<template>
  <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>

  <FormPage>
    <template #header>
      <span class="font-bold text-xl m-1">Afbeeldingen uploaden voor {{ rentalItem.name }} ({{
          rentalItem.number
        }})</span>
    </template>

    <template #content>
      <FileUpload name="demo[]" @upload="onUpload($event)" custom-upload @uploader="customUploader" :multiple="true" accept="image/*"
                  :maxFileSize="1000000">
        <template #empty>
          <p>Drag and drop files to here to upload.</p>
        </template>
      </FileUpload>
    </template>

  </FormPage>
</template>
<script setup lang="ts">
import {useRoute, useRuntimeConfig} from "#app";
import RentalItemClient from "~/services/api/RentalItemClient";
import {RentalItem} from "~/schemas/openapi/merged";

const route = useRoute();
let itemIdString = Array.isArray(route.params.rentalItem) ? route.params.rentalItem[0] : route.params.rentalItem;

const uploadUrl = ref(useRuntimeConfig().public.backendUrl + "/backend/rentalItem/" + itemIdString + "/images");

const itemId = Number.parseInt(itemIdString);
const error = ref<String | undefined>(undefined)
const $rentalItemClient: RentalItemClient = useNuxtApp().$rentalItemClient;
const rentalItem = ref<RentalItem>({
  id: 0,
  name: ""
})

onMounted(() => {
  fetchItemInformation()
})

function onUpload(event) {
  debugger;
}
const customBase64Uploader = async (event) => {
  const file = event.files[0];
  const reader = new FileReader();
  let blob = await fetch(file.objectURL).then((r) => r.blob()); //blob:url

  reader.readAsDataURL(blob);

  reader.onloadend = function () {
    const base64data = reader.result;
  };
};

function fetchItemInformation() {
  $rentalItemClient.get(itemId)
      .then(
          success => {
            success.name
            rentalItem.value = success
          },
          failure => {
            error.value = "Er is iets mis gegaan"
            console.log(failure)
          }
      )
}
</script>