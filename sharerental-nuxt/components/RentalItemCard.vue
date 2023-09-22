<template>
  <Card>
    <template #header>
      <div class="p-2">
        <Image :src="determineImageUrl()" width="250"/>
      </div>
    </template>
    <template #title>{{ item.title }}</template>
    <template #subtitle>{{ item.shortDescription }}</template>
    <template #content>
      <p>
        <span class="font-bold">Prijs per dag</span> {{ formatCurrency(item.pricePerDay) }}
      </p>
    </template>
    <template #footer>
      <NuxtLink :to="'/items/' + item.rentalItemSlug"><Button label="Huren"></Button></NuxtLink>
    </template>
  </Card>
</template>

<script setup lang="ts">
import {SearchResultItem} from "~/schemas/openapi/merged";

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