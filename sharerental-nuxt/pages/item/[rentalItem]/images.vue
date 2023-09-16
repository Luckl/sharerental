<template>
    <div>
      <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>

      <FormPage>
        <template #header>
      <span class="font-bold text-xl m-1">Afbeeldingen uploaden voor {{ rentalItem.name }} ({{
          rentalItem.number
        }})</span>
        </template>

        <template #content>
          <FileUpload name="demo[]" :auto="true" custom-upload @uploader="customUploader" :multiple="true"
                      accept="image/*"
                      :maxFileSize="1000000">
            <template #empty>
              <p>Sleep afbeeldingen hier naartoe om te uploaden.</p>
            </template>
          </FileUpload>

          <div v-for="image in images">
            <Image :src="image.url" preview width="250" />
          </div>
        </template>

      </FormPage>
    </div>
</template>

<script setup lang="ts">
import {useRoute, useRuntimeConfig} from "#app";
import RentalItemClient from "~/services/api/RentalItemClient";
import RentalItemImageClient from "~/services/api/RentalItemImageClient";
import {Image as HttpImage, RentalItem} from "~/schemas/openapi/merged";

const route = useRoute();
let itemIdString = Array.isArray(route.params.rentalItem) ? route.params.rentalItem[0] : route.params.rentalItem;

const itemId = Number.parseInt(itemIdString);
const error = ref<String | undefined>(undefined)
const $rentalItemClient: RentalItemClient = useNuxtApp().$rentalItemClient;
const $rentalItemImageClient: RentalItemImageClient = useNuxtApp().$rentalItemImageClient;
const rentalItem = ref<RentalItem>({
  id: 0,
  name: ""
})
const images = ref<HttpImage[]>([])

onMounted(() => {
  fetchItemInformation()
  fetchImagesForItem()
})

const customUploader = async (event) => {
  const file = event.files[0];
  let blob = await fetch(file.objectURL).then((r) => r.blob()); //blob:url

  $rentalItemImageClient.upload(itemId, blob.type, blob)
      .then(success => {
            fetchImagesForItem()
          },
          failure => {
            if (failure.response.status === 429) {
              error.value = "Te veel afbeeldingen geupload"
            } else {
              error.value = "Afbeeldingen upload mislukt"
            }
            console.log(failure)
          })
};

function fetchImagesForItem() {
  $rentalItemImageClient.get(itemId)
      .then(
          success => {
            if (success.embedded !== undefined) {
              images.value = success.embedded
            } else {
              console.log("no images found")
            }
          },
          failure => {
            error.value = "Afbeeldingen ophalen mislukt"
            console.log(failure)
          }
      )
}

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