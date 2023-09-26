<template>
  <form-page>
    <template #header>
      <div class="flex flex-col">
        <span class="font-bold text-xl mx-1">{{ item.name }}</span>
        <span class="mx-3">{{ item.shortDescription }}</span>
      </div>
    </template>
    <template #content>
      <div class="grid grid-cols-1 lg:grid-cols-2">
        <div class="p-3 flex justify-center">
          <Galleria :value="images" :numVisible="5" containerStyle="max-width: 340px"
                    :showThumbnails="false" :showIndicators="true">
            <template #item="slotProps: {item: Image}">
              <img :src="slotProps.item.url" alt="image" style="width: 100%; display: block"/>
            </template>
          </Galleria>
        </div>
        <div class="p-5 flex flex-col gap-2">
          <Calendar v-model="dates" selectionMode="range" inline @dateSelect="calculatePrice()"
                    @change="calculatePrice()" :minDate="new Date()"/>
          <div class="flex flex-row justify-between">
            <div class="align-middle text-xl">
              Prijs: € {{ price }}
            </div>
            <div class="flex justify-end">
              <Button label="Huren" @click="startTransaction()"></Button>
            </div>
          </div>
        </div>
      </div>
      <div class="flex flex-col gap-5">
        <span class="font-bold text-xl m-1">Details</span>
        <SearchDetailsItem :field="item.brand" label="Merk"/>
        <SearchDetailsItem :field="item.longDescription" label="Omschrijving"/>
        <SearchDetailsItem :field="item.reachMeters" label="Bereik" suffix="m"/>
        <SearchDetailsItem :field="item.carryingWeightKilograms" label="Maximale draaggewicht" suffix="kg"/>
        <SearchDetailsItem :field="item.maximumWorkHeightMeters" label="Maximale werkhoogte" suffix="m"/>
        <SearchDetailsItem :field="item.intrinsicWeightKilograms" label="Gewicht" suffix="kg"/>
        <SearchDetailsItem :field="item.materialType" label="Type materiaal"/>
        <SearchDetailsItem :field="item.maximumPressureBars" label="Maximale drukvermogen" suffix="bar"/>
        <SearchDetailsItem :field="item.maximumHorsePower" label="Maximale vermogen" suffix="pk"/>
        <SearchDetailsItem :field="item.requiredPowerVoltageVolt" label="Benodigde stroomtoevoer" suffix="V"/>
        <SearchDetailsItem :field="item.workWidthMeters" label="Werkbreedte" suffix="m"/>
        <SearchDetailsItem :field="item.vacuumAttachmentPossible" label="Stofzuiger aansluiting"/>
        <SearchDetailsItem :field="item.capacityLiters" label="Bakinhoud" suffix="l"/>
        <SearchDetailsItem :field="item.itemHeight" label="Artikelhoogte" suffix="m"/>
        <SearchDetailsItem :field="item.itemWidth" label="Artikelbreedte" suffix="m"/>
        <SearchDetailsItem :field="item.itemLength" label="Artikellengte" suffix="m"/>
        <SearchDetailsItem :field="item.powerWatt" label="Vermogen" suffix="W"/>
        <SearchDetailsItem :field="item.maximumSurfaceSquareMeters" label="Maximale oppervlakte" suffix="m2"/>
      </div>
    </template>
  </form-page>
</template>
<script setup lang="ts">

import {useRoute} from "#app";
import {Image, RentalItem} from "~/schemas/openapi/merged";
import SearchClient from "~/services/api/SearchClient";
import TransactionClient from "~/services/api/TransactionClient";

const router = useRouter()
const error = ref<String | undefined>(undefined)
const $searchClient: SearchClient = useNuxtApp().$searchClient;
const $transactionClient: TransactionClient = useNuxtApp().$transactionClient;
const route = useRoute();
const price = ref(0);
const slug = Array.isArray(route.params.rentalItemSlug) ? route.params.rentalItemSlug[0] : route.params.rentalItemSlug;
const item = ref<RentalItem>({
  name: "",
  id: 0
});
const dates = ref();
const images = ref<Image[]>([]);

onMounted(() => {
  fetchItem();
})

function startTransaction() {
  if (dates.value[0] != null && dates.value[1] != null) {
    $transactionClient.startTransaction(
        item.value.id,
        dates.value[0],
        dates.value[1]
    ).then(
        success => {
          console.log("redirecting to " + success.redirectUrl)
          navigateTo(success.redirectUrl, { external: true })
        },
        failure => {

        }
    )
  }
}

function calculatePrice() {
  if (dates.value[0] != null && dates.value[1] != null) {
    $transactionClient.calculatePrice(
        item.value.id,
        dates.value[0],
        dates.value[1]
    ).then(
        success => {
          price.value = success.price
        },
        failure => {

        }
    )
  }
}

function fetchItem() {
  $searchClient.details(slug)
      .then(
          success => {
            item.value = success
            if (success.images != undefined) {
              images.value = success.images
            }
          }
      )
}
</script>