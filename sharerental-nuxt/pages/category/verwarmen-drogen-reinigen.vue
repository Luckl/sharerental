<script lang="ts" setup>

import {useFilterStore} from "~/services/stores/filterStore";
import {useAsyncData} from "#app";
import {reactive} from "vue";
import type {FilterOption, SearchRequestFiltersInner, SearchResultItem} from "~/schemas/openapi/search";
import type SearchClient from "~/services/api/SearchClient";
import RentalItemCard from "~/components/RentalItemCard.vue";

definePageMeta({
  layout: 'no-header'
})

const category = ref('Verwarmen, drogen en reinigen')
const {filters} = useFilterStore();

const getFilterName = (filter: FilterOption) => {
  return filters.find(f => f.key === filter.field)?.name || filter.field
}

const usedFilters = ref<SearchRequestFiltersInner[]>([
  {
    field: 'category',
    values: [category.value]
  }
])
const availableFilters = ref<FilterOption[]>([])

const $searchClient: SearchClient = useNuxtApp().$searchClient;

const state = reactive({
  results: undefined as SearchResultItem[] | undefined,
  pageable: {
    page: 0,
    pageSize: 30,
    sort: [],
  },
});

onMounted(() => {
  useAsyncData('searchWithText', async () => {
    return await $searchClient.search(state.pageable.page, state.pageable.pageSize, state.pageable.sort, {
      filters: usedFilters.value
    }, "");
  }).then(
      success => {
        state.results = success.data.value?.embedded
        availableFilters.value = success.data.value?.filterOptions || []
      },
      failure => {

      }
  )
})

const priceRange = ref([0, 1000])

</script>
<template>
  <Head>
    <Title>{{ category }}</Title>
  </Head>
  <SrTopBar>
    <Search></Search>
  </SrTopBar>

  <div class="md:max-w-[1240px] md:mx-auto mt-10 flex px-4 md:px-0">

    <div class="w-1/6 m-5">
      <div class="w-full text-xl font-bold">Filteren</div>
      <Divider></Divider>
      <Accordion unstyled>
        <AccordionTab v-for="filter in availableFilters" :header="getFilterName(filter)">
          <div class="p-2 m-2">
            <span v-for="value in filter.options">{{ value.value }} ({{ value.count }} beschikbaar)</span>
          </div>
        </AccordionTab>
      </Accordion>
    </div>
    <div class="w-5/6">
      <div>
        <span class=" text-4xl font-bold text-center">Verwarmen, drogen en reinigen</span>
        <div class="mt-5">
          Welkom bij onze selectie voor verwarmen, drogen en reinigen. Of je nu bezig bent met bouwwerkzaamheden,
          renovaties of het organiseren van evenementen, wij hebben de juiste apparatuur om je te helpen. Van
          bouwdrogers en heaters tot hogedrukreinigers en stoomreinigers, ons assortiment biedt hoogwaardige oplossingen
          voor het verwarmen, drogen en reinigen van verschillende ruimtes en oppervlakken. Ontdek ons aanbod en maak
          jouw projecten efficiënter en effectiever met onze kwaliteitsapparatuur.
        </div>
      </div>
      <div class="flex pt-10 justify-center">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 xl:grid-cols-3 gap-5 md:gap-10">
          <RentalItemCard v-for="rentalItem in state.results" :item="rentalItem"/>
        </div>
      </div>
    </div>

  </div>

</template>
<style scoped>

</style>