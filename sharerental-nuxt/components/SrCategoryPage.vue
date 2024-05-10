<script lang="ts" setup>

import {type Filter, FilterType, useFilterStore} from "~/services/stores/filterStore";
import {reactive} from "vue";
import type {FilterOption, SearchRequestFiltersInner, SearchResultItem} from "~/schemas/openapi/search";
import type SearchClient from "~/services/api/SearchClient";

interface Props {
  category: string;
  categoryDescription: string;
}

const props = defineProps<Props>()

const {filters} = useFilterStore();

const getFilter = (filter: FilterOption): Filter | undefined => {
  return filters.find(f => f.key === filter.field)
}

const categoryFilter = ref<SearchRequestFiltersInner[]>([
  {
    field: 'category',
    values: [props.category]
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

const formatCurrency = (value: number) => {
  return new Intl.NumberFormat('nl-NL', {
    style: 'currency',
    currency: 'EUR'
  }).format(value)
}

</script>
<template>
  <Head>
    <Title>{{ category }}</Title>
  </Head>
  <SrTopBar>
    <SrSearch></SrSearch>
  </SrTopBar>

  <div class="md:max-w-[1240px] md:mx-auto mt-10 flex px-4 md:px-0">

    <div class="w-1/6 m-5">
      <div class="w-full text-xl font-bold">Filteren</div>
      <Divider></Divider>
      <Accordion unstyled :multiple="true" active-index="0,1,2,3,4,5,6,7,8">
        <AccordionTab  v-for="filter in availableFilters">
          <template #header>
            <span class="m-2 font-bold">{{ getFilter(filter)?.name || '' }}</span>
          </template>
          <div class="m-1" v-if="getFilter(filter)?.type === FilterType.Choice">
            <div class="flex w-full" v-for="value in filter.options">
              <Checkbox @change="fetchItems()" v-model="activatedFilters[filter.field]"
                        :value="value.value"/>
              <label :for="value.value" class="ml-2 w-full flex flex-wrap">
                <span >{{ getFilter(filter)?.prefix }}{{ value.value }}{{ getFilter(filter)?.suffix }}</span>
                <span class="grow text-sm text-gray-600 text-right">({{ value.count }} beschikbaar)</span>
              </label>
            </div>
          </div>
          <div class="m-1" v-else-if="getFilter(filter)?.type === FilterType.Boolean">
            <div class="flex w-full" v-for="value in filter.options">
              <Checkbox @change="fetchItems()" v-model="activatedFilters[filter.field]" :value="value.value"/>
              <label :for="value.value" class="ml-2 w-full flex flex-wrap">
                <span >{{ value.value == 'true' ? 'Ja' : 'Nee' }}</span>
                <span class="grow text-sm text-gray-600 text-right">({{ value.count }} beschikbaar)</span>
              </label>
            </div>
          </div>
          <div class="m-1" v-else-if="getFilter(filter)?.type === FilterType.Currency">
            <div class="flex w-full" v-for="value in filter.options">
              <Checkbox @change="fetchItems()" v-model="activatedFilters[filter.field]"
                        :value="value.value"/>
              <label :for="value.value" class="ml-2 w-full flex flex-wrap">
                <span >{{ getFilter(filter)?.prefix }}{{ formatCurrency(value.value) }}{{ getFilter(filter)?.suffix }}</span>
                <span class="grow text-sm text-gray-600 text-right">({{ value.count }} beschikbaar)</span>
              </label>
            </div>
          </div>
          <div class="p-2 m-2" v-else>
            <span v-for="value in filter.options">{{ value.value }} ({{ value.count }} beschikbaar)</span>
          </div>
        </AccordionTab>
      </Accordion>
    </div>
    <div class="w-5/6">
      <div>
        <span class=" text-4xl font-bold text-center">{{ props.category }}</span>
        <div class="mt-5">
          {{ props.categoryDescription }}
        </div>
      </div>
      <div class="flex pt-10">
        <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 xl:grid-cols-3 gap-5 md:gap-10">
          <SrRentalItemCard v-for="rentalItem in state.results" :item="rentalItem"/>
        </div>
      </div>
    </div>

  </div>
  <sr-cta-lessor></sr-cta-lessor>
</template>