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
import {RentalItemInput} from "~/schemas/openapi/rentalItem";
import RentalItemClient from "~/services/api/RentalItem";

const router = useRouter()
const error = ref<String | undefined>(undefined)
const $rentalItemClient: RentalItemClient = useNuxtApp().$rentalItemClient;

const formInput = reactive<RentalItemInput>({
  name: ""
})

function fetchItem() {

}

function onSubmitNewItem() {

  $rentalItemClient.create(formInput)
      .then(success => {
            router.push('/items')

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

.mb-1 {
  margin-bottom: 1rem
}

.data-label {
  font-weight: bold;
}

</style>