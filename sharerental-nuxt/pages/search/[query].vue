<template>
  <div class="results">
    <RentalItemCard v-for="rentalItem in rentalItems" :item="rentalItem"/>
  </div>
</template>

<script setup lang="ts">
import RentalItemCard, {RentalItem} from "~/components/RentalItemCard.vue";
import {reactive, ref} from "vue";
import {useAsyncData, useNuxtApp, useRoute} from "#app";
import {SearchResultItem} from '~/services/api/Search';

const state = reactive({
  shifts: undefined as SearchResultItem[] | undefined,
  pageable: {
    page: 0,
    pageSize: 30,
    sort: [],
  },
});

const { $searchClient } = useNuxtApp();
const route = useRoute();
const rentalItems = ref<RentalItem[]>();
const query = Array.isArray(route.params.query) ? route.params.query[0] : route.params.query;

// Search here
const result = await useAsyncData('searchWithText', async () => {
  console.log("querying " + query)
  debugger;
  return await $searchClient.search(state.pageable, query);
})

rentalItems.value = result.data.value?.embedded
    .map((result: SearchResultItem) => {
      return new RentalItem(result.id, result.title, result.subtitle, result.shortDescription, result.imageUrl, result.pricePerDay)
    });

</script>

<style scoped>
.results {
  justify-content: center;
  padding: 1rem;
  display: flex;
  flex-wrap: wrap;
  gap: 5rem;
}

@media screen and (max-width: 678px) {

}


@media screen and (min-width: 678px) {

}
</style>