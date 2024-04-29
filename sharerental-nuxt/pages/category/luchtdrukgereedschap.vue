<script lang="ts" setup>

import {type Filter, FilterType, useFilterStore} from "~/services/stores/filterStore";
import {reactive} from "vue";
import type {FilterOption, SearchRequestFiltersInner, SearchResultItem} from "~/schemas/openapi/search";
import type SearchClient from "~/services/api/SearchClient";

definePageMeta({
  layout: 'no-header'
})

const category = ref('Luchtdrukgereedschap')
const {filters} = useFilterStore();

const getFilter = (filter: FilterOption): Filter | undefined => {
  return filters.find(f => f.key === filter.field)
}

const categoryFilter = ref<SearchRequestFiltersInner[]>([
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
  fetchItems()
})

const fetchItems = () => {
  let allFilters = categoryFilter.value.concat(mapToFilter());
  $searchClient.search(state.pageable.page, state.pageable.pageSize, state.pageable.sort, {
    filters: allFilters
  }, "").then(
      success => {
        state.results = success.embedded
        let allAvailableFilters = success.filterOptions || [];
        availableFilters.value = allAvailableFilters
            .filter(value => value.field !== 'category')

        availableFilters.value
            .filter(value => value.field !== 'category')
            .filter(value => value.options?.length || 0 > 0)
            .filter(filter => activatedFilters.value[filter.field || ""] === undefined)
            .forEach(filter => {
              activatedFilters.value[filter.field || ""] = []
            })
      }
  )
}

const activatedFilters = ref<any>({})
const mapToFilter = (): SearchRequestFiltersInner[] => {
  return Object.entries(activatedFilters.value)
      .filter(([key, value]) => Array.isArray(value) && value.length > 0)
      .map(([key, value]) => {
        return {
          field: key,
          values: Array.isArray(value) ? value as string[] : [value as string]
        }
      })
}

</script>
<template>
  <sr-category-page
    :category="category"
    category-description="Welkom bij ons assortiment luchtdrukgereedschap. Of je nu een professional bent in de automotive sector, de bouw of de productie, wij hebben de juiste gereedschappen om je te helpen. Van pneumatische hamers en spuitpistolen tot persluchtslangen en compressoren, ons assortiment biedt hoogwaardige apparatuur voor diverse toepassingen. Ontdek ons aanbod en verbeter je werkprestaties met onze betrouwbare luchtdrukgereedschappen."
    ></sr-category-page>
</template>