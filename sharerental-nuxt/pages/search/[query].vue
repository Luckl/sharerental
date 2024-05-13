<template>
  <sr-category-page category-description="" :query="query">
  </sr-category-page>
</template>

<script setup lang="ts">
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

onMounted(async () => {
  await fetchResult()
})

async function fetchResult() {

    $searchClient.search(state.pageable.page, state.pageable.pageSize, state.pageable.sort, undefined, query)
  .then(
      success => {
        rentalItems.value = success.embedded
      },
      failure => {

      }
  )
}

</script>

<style scoped>

</style>