<script lang="ts" setup>

import {type Filter, FilterType, useFilterStore} from "~/services/stores/filterStore";
import {reactive, ref} from "vue";
import {
  type FilterOption, RenterType, SearchApi,
  type SearchRequestFiltersInner, SearchRequestFiltersInnerFilterTypeEnum, type SearchResult,
  type SearchResultItem
} from "~/schemas/openapi/search";
import {RenterTypeEnum, useRenterTypeStore} from "~/services/stores/renterTypeStore";
import { useGeolocation } from '@vueuse/core'
interface Props {
  category?: string;
  query?: string;
  categoryDescription?: string;
}

const props = defineProps<Props>()
const showFilters = ref(false)
const {filters} = useFilterStore();
const { renterType } = storeToRefs(useRenterTypeStore())

const getFilter = (filter: FilterOption): Filter | undefined => {
  return filters.find(f => f.key === filter.field)
}

const categoryFilter = ref<SearchRequestFiltersInner[]>([
  {
    field: 'category',
    filterType: SearchRequestFiltersInnerFilterTypeEnum.In,
    values: props.category ? [props.category] : []
  }
])

const availableFilters = ref<FilterOption[]>([])

const radiusKm = ref(25)
const { coords } = useGeolocation()

const $searchApi: SearchApi = useNuxtApp().$searchApi;

const state = reactive({
  results: undefined as SearchResultItem[] | undefined,
  pageable: {
    page: 0,
    pageSize: 100,
    sort: [],
  },
});

watch(coords, () => {
  fetchItems()
})

const fetchItems = async () => {
  let allFilters = categoryFilter.value.concat(mapToFilter()).concat(mapToSliderFilter());
  return await $searchApi.search({
    query: props.query ?? "",
    page: state.pageable.page,
    size: state.pageable.pageSize,
    sort: state.pageable.sort,
    searchRequest: {
      distance: {
        latitude: coords.value?.latitude,
        longitude: coords.value?.longitude,
        radius: radiusKm.value
      },
      filters: allFilters,
      renterType: renterType.value == RenterTypeEnum.Private ? RenterType.Private : RenterType.Business,
    }
  }).then(
      success => {
        processSuccess(success)
        return success
      }
  )
}

const processSuccess = (success: SearchResult) => {
  state.results = success.embedded

  availableFilters.value
      .filter(value => value.field !== 'category')
      .filter(value => value.options?.length || 0 > 0)
      .filter(filter => activatedBooleanFilters.value[filter.field || ""] === undefined)
      .forEach(filter => {
        activatedBooleanFilters.value[filter.field || ""] = []
      })
}

const screenWidth = ref(process.client ? window.innerWidth : 0);
const isSmallScreen = computed(() => screenWidth.value < 1024);

const handleResize = () => {
  screenWidth.value = window.innerWidth;
};

onMounted(() => {
  window.addEventListener('resize', handleResize);
});

onBeforeUnmount(() => {
  window.removeEventListener('resize', handleResize);
});

const activatedBooleanFilters = ref<any>({})
const mapToFilter = (): SearchRequestFiltersInner[] => {
  return Object.entries(activatedBooleanFilters.value)
      .filter(([key, value]) => Array.isArray(value) && value.length > 0)
      .map(([key, value]) => {
        return {
          field: key,
          filterType: SearchRequestFiltersInnerFilterTypeEnum.In,
          values: Array.isArray(value) ? value as string[] : [value as string]
        }
      })
}

const activatedSliderFilters = ref<any>({})

const mapToSliderFilter = (): SearchRequestFiltersInner[] => {
  return Object.entries(activatedSliderFilters.value)
      .filter(([key, value]) => value !== undefined)
      .map(([key, value]) => {
        return {
          field: key,
          filterType: SearchRequestFiltersInnerFilterTypeEnum.WithinRange,
          values: [value[0], value[1]]
        }
      })
}

const formatCurrency = (value: number) => {
  return new Intl.NumberFormat('nl-NL', {
    style: 'currency',
    currency: 'EUR'
  }).format(value)
}

const updatePossibleFilters = (success: SearchResult) => {
  let allAvailableFilters = success.filterOptions || [];
  availableFilters.value = allAvailableFilters
      .filter(value => value.field !== 'category')
}

const setSliderValues = (success: SearchResult) => {
  let allAvailableFilters = success.filterOptions || [];
  allAvailableFilters
      .filter(value => getFilter(value)?.type === FilterType.Currency)
      .forEach(filter => {
        activatedSliderFilters.value[filter.field || ""] = [filter.options?.map(option => parseFloat(option.value!) ).reduce((a, b) => Math.min(a, b)),
          filter.options?.map(option => parseFloat(option.value!) ).reduce((a, b) => Math.max(a, b))]
      })
}

const {data} = await useAsyncData(props.query + "-" + props.category, () => {
  return fetchItems()
})

processSuccess(data.value!!)
setSliderValues(data.value!!)
updatePossibleFilters(data.value!!)

</script>
<template>
  <Head>
    <Title>{{ category }}</Title>
  </Head>
  <SrTopBar>
    <SrSearch></SrSearch>
  </SrTopBar>
  <div>
    <div class="lg:hidden m-5 h-10 flex items-center">
      <Button unstyled @click="showFilters = !showFilters">
        <div class="flex items-center">
          <i class="pi pi-sliders-h" style="font-size: 2rem"></i>
          <span class="text-3xl pl-8">Filters</span>
        </div>
      </Button>
      <div class="w-full text-end">
        <span class="text-gray-600">{{ state.results ? state.results.length : 0 }} {{ state.results?.length === 1 ? "resultaat" : "resultaten" }}</span>
      </div>
    </div>
  </div>
  <div class="lg:max-w-[1240px] lg:mx-auto lg:mt-10 flex flex-col lg:flex-row md:m-5">
    <div v-show="showFilters || !isSmallScreen" class="px-0 lg:w-1/6 m-5">
      <div class="w-full text-xl font-bold">Filteren</div>
      <Divider></Divider>
      <Accordion unstyled :multiple="true" active-index="0,1,2,3,4,5,6,7,8">
        <AccordionTab v-if="coords.latitude != undefined && coords.longitude != undefined">
          <template #header>
            <span class="m-2 font-bold">Afstand</span>
          </template>
          <div class="m-1">
            <div class="flex flex-col w-full">
              <span class="p-4">Maximale afstand: {{ radiusKm >= 300 ? 'Onbeperkt' : radiusKm + " km" }}</span>
              <slider @slideend="fetchItems()" class="w-full" v-model="radiusKm" :min="0"
                      :max="300"/>
            </div>
          </div>
        </AccordionTab>
        <AccordionTab v-for="filter in availableFilters">
          <template #header>
            <span class="m-2 font-bold">{{ getFilter(filter)?.name || '' }}</span>
          </template>
          <div class="m-1" v-if="getFilter(filter)?.type === FilterType.Choice">
            <div class="flex w-full" v-for="value in filter.options">
              <Checkbox @change="fetchItems()" v-model="activatedBooleanFilters[filter.field]"
                        :value="value.value"/>
              <label :for="value.value" class="ml-2 w-full flex flex-wrap">
                <span>{{ getFilter(filter)?.prefix }}{{ value.value }}{{ getFilter(filter)?.suffix }}</span>
                <span class="grow text-sm text-gray-600 text-right">({{ value.count }} beschikbaar)</span>
              </label>
            </div>
          </div>
          <div class="m-1" v-else-if="getFilter(filter)?.type === FilterType.Boolean">
            <div class="flex w-full" v-for="value in filter.options">
              <Checkbox @change="fetchItems()" v-model="activatedBooleanFilters[filter.field]" :value="value.value"/>
              <label :for="value.value" class="ml-2 w-full flex flex-wrap">
                <span>{{ value.value == 'true' ? 'Ja' : 'Nee' }}</span>
                <span class="grow text-sm text-gray-600 text-right">({{ value.count }} beschikbaar)</span>
              </label>
            </div>
          </div>
          <div class="m-1" v-else-if="getFilter(filter)?.type === FilterType.Currency">
            <div class="flex flex-col w-full">
              <span class="p-4">{{ formatCurrency(activatedSliderFilters[filter.field][0]) }} tot {{ formatCurrency(activatedSliderFilters[filter.field][1]) }}</span>
              <slider @slideend="fetchItems()" class="w-full" range v-model="activatedSliderFilters[filter.field]" :min="filter.options?.map(option => parseFloat(option.value!) ).reduce((a, b) => Math.min(a, b))"
                      :max="filter.options?.map(option => parseFloat(option.value!) ).reduce((a, b) => Math.max(a, b))"/>
            </div>
          </div>
        </AccordionTab>
      </Accordion>
    </div>
    <div class="w-5/6 m-5">
      <div>
        <h1>
          <span class="text-4xl font-bold">{{ props.category }}</span>
        </h1>
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