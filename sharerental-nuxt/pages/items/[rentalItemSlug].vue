<template>
<form-page>
  <template #header>
    <span class="font-bold text-xl m-1">{{ item.name }}</span>
  </template>
  <template #content>
    <div class="grid grid-cols-1 lg:grid-cols-2">
      <div class="p-5 flex flex-col gap-2">
        <Calendar v-model="dates" selectionMode="range" inline :minDate="new Date()"/>
        <div class="flex justify-end">
          <Button label="Huren" ></Button>
        </div>
      </div>
      <div class="p-5 flex justify-center">
        <Galleria :value="images" :numVisible="5" containerStyle="max-width: 240px"
                  :showThumbnails="false" :showIndicators="true">
          <template #item="slotProps: {item: Image}">
            <img :src="slotProps.item.url" alt="image" style="width: 100%; display: block" />
          </template>
        </Galleria>
      </div>
    </div>
    <div>details</div>
  </template>
</form-page>
</template>
<script setup lang="ts">

import {useRoute} from "#app";
import {Image, RentalItem} from "~/schemas/openapi/merged";
import SearchClient from "~/services/api/SearchClient";

const router = useRouter()
const error = ref<String | undefined>(undefined)
const $searchClient: SearchClient = useNuxtApp().$searchClient;
const route = useRoute();
const slug = Array.isArray(route.params.rentalItemSlug) ? route.params.rentalItemSlug[0] : route.params.rentalItemSlug;
const item = ref<RentalItem>({
  name: "",
  id: 0
});
const dates = ref();
const images = ref<Image[]>([]);

onMounted(() => {
  fetchItem();
})

function fetchItem() {
  $searchClient.details(slug)
      .then(
          success => {
            Object.assign(item, success)
            if (success.images != undefined) {
              images.value = success.images
            }
          }
      )
}
</script>