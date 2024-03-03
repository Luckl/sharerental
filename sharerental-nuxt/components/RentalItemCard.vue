<template>
  <div class="p-2 bg-white rounded-lg hover:bg-gray-300">
    <div class="flex align-center p-2 w-60 h-60">
      <NuxtImg class="rounded-lg" fit="contain" loading="lazy" :src="determineImageUrl()"/>
    </div>
    <div class="my-1">
      <span class="font-bold text-lg">{{ item.title }}</span>
    </div>
    <div class="flex justify-between my-1">
      <span>Prijs per dag: </span>
      <span>{{ formatCurrency(item.pricePerDay) }}</span>
    </div>
    <div class="my-1">
      <NuxtLink :to="'/items/' + item.rentalItemSlug">
        <Button unstyled class="rounded-lg green-area p-2">Direct huren</Button>
      </NuxtLink>
    </div>
    <div>
      <span class="text-sm text-gray-500">Beschikbaar bij 0 aanbieders</span>
    </div>
  </div>
</template>

<script setup lang="ts">
import {SearchResultItem} from "~/schemas/openapi/search";

definePageMeta({
  layout: 'new'
})

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
    return '/logo-transparent-2.png'
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