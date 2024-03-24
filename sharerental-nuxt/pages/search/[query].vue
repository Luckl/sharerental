<template>
  <Head>
    <Title>Zoeken - ShareRental</Title>
  </Head>
  <SrTopBar>
    <Search></Search>
  </SrTopBar>
  <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0 bg-white">
    <div class="flex pt-10 justify-center">
      <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-5 md:gap-10">
        <RentalItemCard v-for="rentalItem in rentalItems" :item="rentalItem" @submit="submit(rentalItem)"/>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import RentalItemCard from "~/components/RentalItemCard.vue";
import {reactive, ref} from "vue";
import {useAsyncData, useNuxtApp, useRoute} from "#app";
import SearchClient from '~/services/api/SearchClient';
import type { SearchResultItem } from '~/schemas/openapi/search';

definePageMeta({
  layout: 'no-header'
})

const state = reactive({
  results: undefined as SearchResultItem[] | undefined,
  pageable: {
    page: 0,
    pageSize: 30,
    sort: [],
  },
});

const $searchClient: SearchClient = useNuxtApp().$searchClient;
const rentalItems = ref<SearchResultItem[]>();
const route = useRoute();
const query = Array.isArray(route.params.query) ? route.params.query[0] : route.params.query;

// Search here

onMounted(async () => {
  await fetchResult()
})

function submit(data: SearchResultItem) {
  console.log("clicked " + data)
}

async function fetchResult() {
  useAsyncData('searchWithText', async () => {
    return await $searchClient.search(state.pageable.page, state.pageable.pageSize, state.pageable.sort, query);
  }).then(
      success => {
        rentalItems.value = success.data.value?.embedded
      },
      failure => {

      }
  )
}

</script>

<style scoped>



@media screen and (min-width: 2270px) {
  .side-padding {
    padding-left: 20%;
    padding-right: 20%;
  }
}
</style>