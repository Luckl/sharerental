<template>

</template>
<script setup lang="ts">

import RentalItemClient from "~/services/api/RentalItemClient";
import {useRoute} from "#app";
import {RentalItem} from "~/schemas/openapi/merged";

const router = useRouter()
const error = ref<String | undefined>(undefined)
const $rentalItemClient: RentalItemClient = useNuxtApp().$rentalItemClient;
const route = useRoute();
const itemId = Number.parseInt(Array.isArray(route.params.rentalItemId) ? route.params.rentalItemId[0] : route.params.rentalItemId);
const item = ref<RentalItem>();

onMounted(() => {
  fetchItem();
})

function fetchItem() {
  $rentalItemClient.get(itemId)
      .then(
          success => {
            Object.assign(item, success)
          }
      )
}
</script>