<script lang="ts" setup>

import {type Filter, FilterType, useFilterStore} from "~/services/stores/filterStore";
import {reactive} from "vue";
import type {FilterOption, SearchRequestFiltersInner, SearchResultItem} from "~/schemas/openapi/search";
import type SearchClient from "~/services/api/SearchClient";

definePageMeta({
  layout: 'no-header'
})

const category = ref('Luchtdrukgereedschap')

</script>
<template>
  <sr-category-page
    :category="category"
    category-description="Welkom bij ons assortiment luchtdrukgereedschap. Of je nu een professional bent in de automotive sector, de bouw of de productie, wij hebben de juiste gereedschappen om je te helpen. Van pneumatische hamers en spuitpistolen tot persluchtslangen en compressoren, ons assortiment biedt hoogwaardige apparatuur voor diverse toepassingen. Ontdek ons aanbod en verbeter je werkprestaties met onze betrouwbare luchtdrukgereedschappen."
    ></sr-category-page>
</template>