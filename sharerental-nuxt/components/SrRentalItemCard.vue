<template>
  <div class="p-2 bg-white rounded-lg hover:bg-gray-300">
    <div class="flex align-center p-2 w-60 h-60">
      <NuxtImg class="rounded-lg" fit="contain" loading="lazy" sizes="224px" :src="determineImageUrl()"/>
    </div>
    <div class="my-2">
      <span class="font-bold text-lg">{{ item.title }}</span>
    </div>
    <div class="flex justify-between my-2">
      <span>Prijs per dag: </span>
      <span>{{ formatCurrency(item.pricePerDay) }}</span>
    </div>
    <div class="my-2">
      <NuxtLink :to="'/artikelen/' + item.rentalItemSlug">
        <Button unstyled class="rounded-lg green-area p-2">Direct huren</Button>
      </NuxtLink>
    </div>
  </div>
</template>

<script setup lang="ts">
import type { SearchResultItem } from "~/schemas/openapi/search";
import {RenterTypeEnum, useRenterTypeStore} from "~/services/stores/renterTypeStore";

definePageMeta({
  layout: 'new'
})

interface Props {
  item: SearchResultItem;
}

const { renterType } = storeToRefs(useRenterTypeStore())

const props = defineProps<Props>()
const formatter = new Intl.NumberFormat('nl-NL', {
  style: 'currency',
  currency: 'EUR',
})

function determineImageUrl() {
  if (props.item.imageUrl === undefined) {
    return '/SR_s_green_white.png'
  } else {
    return props.item.imageUrl
  }
}

function formatCurrency(value: number) {
  if (value !== undefined && value !== null) {
    if (renterType.value === RenterTypeEnum.Business) {
      return formatter.format(value)
    } else {
      return formatter.format(value * 1.21)
    }
  } else return "Niet bekend"
}
</script>

<style scoped>
</style>