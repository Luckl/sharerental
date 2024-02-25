<template>
  <Card>
    <template #header>
      <div class="flex p-2 w-60 h-60">
        <Image :src="determineImageUrl()"/>
      </div>
    </template>
    <template #title>
      <div class="flex">
        {{ item.title }}
      </div>
    </template>
    <template #subtitle>
      <div class="flex h-2">
        {{ item.shortDescription }}
      </div>
    </template>
    <template #content>
      <div class="flex align-bottom justify-between">
        <span class="font-bold">Prijs per dag</span> <span>{{ formatCurrency(item.pricePerDay) }}</span>
      </div>
    </template>
    <template #footer>
      <div class="flex">
        <NuxtLink :to="'/items/' + item.rentalItemSlug">
          <button unstyled class="rounded-lg black-area p-3 h-12">Huren</button>
        </NuxtLink>
      </div>
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