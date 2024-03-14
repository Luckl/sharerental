<template>
  <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>

  <FormPage>
    <template #header>
      <span class="font-bold text-xl m-1">Artikel toevoegen</span>
    </template>
    <template #content class="flexbox-column">
      <RentalItemForm :rentalItem="formInput" :submit="onSubmitNewItem" submitButtonText="Aanmaken"></RentalItemForm>
    </template>
  </FormPage>
</template>
<script setup lang="ts">
import type {RentalItemInput} from "~/schemas/openapi/rentalItem";
import RentalItemClient from "~/services/api/RentalItemClient";

const router = useRouter()
const error = ref<String | undefined>(undefined)
const $rentalItemClient: RentalItemClient = useNuxtApp().$rentalItemClient;

const formInput = reactive<RentalItemInput>({
  name: "",
  number: undefined,
  category: undefined,
  shortDescription: undefined,
  longDescription: undefined,
  deliveryPossible: false,
  deliveryPrice: undefined,
  price24h: undefined,
  price48h: undefined,
  price168h: undefined,
  reachMeters: undefined,
  carryingWeightKilograms: undefined,
  maximumWorkHeightMeters: undefined,
  intrinsicWeightKilograms: undefined,
  maximumPressureBars: undefined,
  maximumHorsePower: undefined,
  requiredPowerVoltageVolt: undefined,
  workWidthMeters: undefined,
  capacityLiters: undefined,
  itemHeight: undefined,
  itemWidth: undefined,
  itemLength: undefined,
  powerWatt: undefined,
  maximumSurfaceSquareMeters: undefined,
  materialType: undefined,
  brand: undefined,
  vacuumAttachmentPossible: false
})

function onSubmitNewItem() {

  $rentalItemClient.create(formInput)
      .then(success => {
            router.push('/lessor/items')

            formInput.name = "";
            formInput.number = "";
            formInput.category = "";
            formInput.shortDescription = "";
            formInput.longDescription = "";
            formInput.deliveryPossible = false;
            formInput.deliveryPrice = undefined;
            formInput.price24h = undefined;
            formInput.price48h = undefined;
            formInput.price168h = undefined;
            formInput.reachMeters = undefined;
            formInput.carryingWeightKilograms = undefined;
            formInput.maximumWorkHeightMeters = undefined;
            formInput.intrinsicWeightKilograms = undefined;
            formInput.maximumPressureBars = undefined;
            formInput.maximumHorsePower = undefined;
            formInput.requiredPowerVoltageVolt = undefined;
            formInput.workWidthMeters = undefined;
            formInput.capacityLiters = undefined;
            formInput.itemHeight = undefined;
            formInput.itemWidth = undefined;
            formInput.itemLength = undefined;
            formInput.powerWatt = undefined;
            formInput.maximumSurfaceSquareMeters = undefined;
            formInput.materialType = undefined;
            formInput.brand = undefined;
            formInput.vacuumAttachmentPossible = false;
          },
          failureReason => {
            error.value = "Er is iets fout gegaan"
          })
}

</script>
<style>

.flexbox-column {
  display: flex;
  flex-direction: column
}

</style>