<template>
  <div>
    <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>

    <FormPage>
      <template #header>
      <span class="font-bold text-xl m-1">Afbeeldingen uploaden voor {{ rentalItem.name }} ({{
          rentalItem.externalReference
        }})</span>
      </template>

      <template #content>
        <FileUpload name="demo[]" custom-upload @uploader="customUploader" :multiple="true"
                    accept="image/*">
          <template #empty>
            <p>Sleep afbeeldingen hier naartoe om te uploaden.</p>
          </template>
        </FileUpload>

        <div class="mt-20 flex flex-row gap-2">
          <div v-for="image in images">
            <div class="m-2 flex flex-col justify-center">
              <Image :src="image.url" preview width="250"/>
              <Button label="Verwijderen" @click="removeImage(image.id)"></Button>
            </div>
          </div>
        </div>
      </template>

    </FormPage>
  </div>
</template>

<script setup lang="ts">
import {useRoute, useRuntimeConfig} from "#app";
import {
  type Image as HttpImage,
  type RentalItem,
  RentalItemApi,
  RentalItemImageApi
} from "~/schemas/openapi/rentalItem";

const route = useRoute();
let itemIdString = Array.isArray(route.params.rentalItem) ? route.params.rentalItem[0] : route.params.rentalItem;

const itemId = Number.parseInt(itemIdString);
const error = ref<String | undefined>(undefined)
const $rentalItemApi: RentalItemApi = useNuxtApp().$rentalItemApi;
const $rentalItemImageApi: RentalItemImageApi = useNuxtApp().$rentalItemImageApi;
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

  const blobs: Blob[] = []

  for (const file of event.files) {

    let blob = await fetch(file.objectURL).then((r) => r.blob()); //blob:url
    blobs.push(blob)
  }

  $rentalItemImageApi.uploadRentalItemImage({
    id: itemId,
    files: blobs
  })
      .then(success => {
            fetchImagesForItem()
          },
          failure => {
            if (failure.response.status === 429) {
              error.value = "Te veel afbeeldingen geupload"
            } else {
              error.value = "Afbeeldingen upload mislukt"
            }
          })
};

function removeImage(id: number) {
  $rentalItemImageApi.deleteRentalItemImage({
    imageId: id,
    id: itemId
  })
      .then(
          success => {
            fetchImagesForItem()
          },
          failure => {
            error.value = "Afbeelding verwijderen mislukt"
          }
      )
}

function fetchImagesForItem() {
  $rentalItemImageApi.getRentalItemImages({
    id: itemId
  })
      .then(
          success => {
            if (success.embedded !== undefined) {
              images.value = success.embedded
            }
          },
          failure => {
            error.value = "Afbeeldingen ophalen mislukt"
          }
      )
}

function fetchItemInformation() {
  $rentalItemApi.getRentalItem({
    id: itemId
  })
      .then(
          success => {
            success.name
            rentalItem.value = success
          },
          failure => {
            error.value = "Er is iets mis gegaan"
          }
      )
}
</script>