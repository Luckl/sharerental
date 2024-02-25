<template>
  <Card>
    <template #header>
      <div class="p-2 w-60">
        <Image :src="determineImageUrl()"/>
      </div>
    </template>
    <template #title>{{ item.title }}</template>
    <template #subtitle>{{ item.shortDescription }}</template>
    <template #content>
      <div class="flex justify-between">
        <span class="font-bold">Prijs per dag</span> <span>{{ formatCurrency(item.pricePerDay) }}</span>
      </div>
    </template>
    <template #footer>
      <NuxtLink :to="'/items/' + item.rentalItemSlug"><button unstyled class="rounded-lg black-area p-3 h-12">Huren</button></NuxtLink>
    </template>
  </Card>
</template>

<script setup lang="ts">
import {SearchResultItem} from "~/schemas/openapi/search";

interface Props {
  item: SearchResultItem;
}

const props = defineProps<Props>()
const formatter = new Intl.NumberFormat('nl-NL', {
  style: 'currency',
  currency: 'EUR',
})

function determineImageUrl() {
  if (props.item.imageUrl === undefined) {
    return '/assets/logo-transparent-2.png'
  } else {
    return props.item.imageUrl
  }
}

function formatCurrency(value: number) {
  if (value !== undefined && value !== null) {
    return formatter.format(value)
  } else return "Niet bekend"
}
</script>

<style scoped>
</style>