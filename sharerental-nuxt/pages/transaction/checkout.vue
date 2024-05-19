<script lang="ts" setup>

import type {Renter} from "~/schemas/openapi/renter";
import {useCartStore} from "~/services/stores/cartStore";
import SrRenterInformationForm from "~/components/SrRenterInformationForm.vue";

const srRenterInformationForm = ref<typeof SrRenterInformationForm | null>(null)

const cartStore = useCartStore()

const {rentalItem, endDate, startDate, price, amount} = storeToRefs(cartStore)

const renter = ref<Renter | undefined>()

const imageUrl = ref<string>(
    rentalItem.value?.images?.[0].url ?? '/SR_s_green_white.png'
)

const formatter = new Intl.NumberFormat('nl-NL', {
  style: 'currency',
  currency: 'EUR',
})

function formatCurrency(value: number) {
  if (value !== undefined && value !== null) {
    return formatter.format(value)
  } else return "Niet bekend"
}

const startTransaction = () => {
  srRenterInformationForm.value?.createUserIfSelected()
  console.log(renter.value)
}
</script>
<template>
  <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 md:gap-8 md:p-12">
      <div class="px-8">
        <sr-renter-information-form v-model="renter" ref="srRenterInformationForm">

        </sr-renter-information-form>
      </div>
      <div class="flex flex-col">
        <div class="flex gap-2">
          <div class="w-2/5">
            <NuxtImg class="rounded-lg" fit="contain" loading="lazy" :src="imageUrl"></NuxtImg>
          </div>
          <div class="w-3/5 px-8 flex flex-col justify-between my-2">
            <div class="flex flex-col">
              <span class="font-bold text-2xl ">{{ rentalItem?.name }}</span>
              <span class="font-bold text-lg mb-5"> {{
                  $dayjs(startDate).format("DD/MM/YYYY")
                }} - {{ $dayjs(endDate).format("DD/MM/YYYY") }}</span>
            </div>
            <div class="flex flex-col">

              <div class="flex justify-between">
                <span class="font-bold text-sm ">Prijs per dag </span>
                <span class="font-bold text-sm ">{{ formatCurrency(rentalItem?.price24h) }}</span>
              </div>
              <div class="flex justify-between">
                <span class="font-bold text-sm">Aantal </span>
                <span class="font-bold text-sm ">{{ amount }}</span>
              </div>
              <div class="flex justify-between">
                <span class="font-bold text-green-900 ">Totaal </span>
                <span class="font-bold text-green-900">{{ formatCurrency(price) }}</span>
              </div>
            </div>

          </div>
        </div>
        renter email: {{ renter?.email}}
        <Button label="Nu betalen" @click="startTransaction()"></Button>
      </div>

    </div>

  </div>

</template>
