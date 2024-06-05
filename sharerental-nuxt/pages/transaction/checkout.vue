<script lang="ts" setup>

import type {Renter} from "~/schemas/openapi/renter";
import {useCartStore} from "~/services/stores/cartStore";
import SrRenterInformationForm from "~/components/SrRenterInformationForm.vue";
import {RenterTypeEnum, useRenterTypeStore} from "~/services/stores/renterTypeStore";
import {TransactionApi} from "~/schemas/openapi/transaction";

const srRenterInformationForm = ref<typeof SrRenterInformationForm | null>(null)
const $transactionApi: TransactionApi = useNuxtApp().$transactionApi;

const cartStore = useCartStore()

const {rentalItem, endDate, startDate, price, amount} = storeToRefs(cartStore)

const renter = ref<Renter | undefined>()


function determineImageUrl() {
  if (rentalItem.value?.images?.[0]?.url === undefined) {
    return '/SR_s_green_white.png'
  } else {
    return rentalItem.value?.images?.[0]?.url
  }
}

const formatter = new Intl.NumberFormat('nl-NL', {
  style: 'currency',
  currency: 'EUR',
})

const {renterType} = storeToRefs(useRenterTypeStore())

function formatCurrency(value: number | undefined) {
  if (value !== undefined && value !== null) {
    if (renterType.value === RenterTypeEnum.Business) {
      return formatter.format(value)
    } else {
      return formatter.format(value * 1.21)
    }
  } else return "Niet bekend"
}

const startTransaction = () => {
  if (rentalItem.value?.id) {
    srRenterInformationForm.value?.createUserIfSelected()
    $transactionApi.startTransaction({
          createTransactionRequest: {
            rentalItemId: rentalItem.value?.id ?? 0,
            startDate: startDate.value as Date,
            endDate: endDate.value as Date,
            amount: amount.value ?? 1,
            renter: createRenterInputObject()
          }
        }
    ).then(
        success => {
          navigateTo(success.redirectUrl, {external: true})
        },
        failure => {
          showError(failure.message);
        }
    )
  }
}

const createRenterInputObject = () => {
  if (renter.value?.id == 0) {
    if (renter.value?.renterType === RenterTypeEnum.Business) {
      return {
        firstName: renter.value?.firstName ?? "",
        lastName: renter.value?.lastName ?? "",
        email: renter.value?.email ?? "",
        phoneNumber: renter.value?.phoneNumber ?? "",
        street: renter.value?.location.street,
        houseNumber: renter.value?.location.houseNumber,
        postalCode: renter.value?.location.postalCode,
        city: renter.value?.location.city,
        country: renter.value?.location.country,
        renterType: renter.value?.renterType,
        chamberOfCommerce: renter.value?.chamberOfCommerce,
        vatNumber: renter.value?.vatNumber,
        companyName: renter.value?.companyName
      };
    } else return {
      firstName: renter.value?.firstName ?? "",
      lastName: renter.value?.lastName ?? "",
      email: renter.value?.email ?? "",
      phoneNumber: renter.value?.phoneNumber ?? "",
      street: renter.value?.location.street,
      houseNumber: renter.value?.location.houseNumber,
      postalCode: renter.value?.location.postalCode,
      city: renter.value?.location.city,
      country: renter.value?.location.country,
      renterType: renter.value?.renterType
    };
  } else return undefined
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
            <NuxtImg class="rounded-lg" fit="contain" loading="lazy" :src="determineImageUrl()"></NuxtImg>
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
        <Button label="Nu betalen" @click="startTransaction()"></Button>
      </div>

    </div>

  </div>

</template>
