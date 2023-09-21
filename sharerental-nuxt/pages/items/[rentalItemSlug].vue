<template>

</template>
<script setup lang="ts">

import {useRoute} from "#app";
import {RentalItem} from "~/schemas/openapi/merged";
import SearchClient from "~/services/api/SearchClient";

const router = useRouter()
const error = ref<String | undefined>(undefined)
const $searchClient: SearchClient = useNuxtApp().$searchClient;
const route = useRoute();
const slug = Array.isArray(route.params.rentalItemSlug) ? route.params.rentalItemSlug[0] : route.params.rentalItemSlug;
const item = ref<RentalItem>();

onMounted(() => {
  fetchItem();
})

function fetchItem() {
  $searchClient.details(slug)
      .then(
          success => {
            Object.assign(item, success)
          }
      )
}
</script>