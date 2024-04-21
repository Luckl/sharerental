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
          <Calendar v-model="dates" selectionMode="range" inline @dateSelect="onUpdateTransactionInformation()"
                    @change="onUpdateTransactionInformation()" :minDate="new Date()"/>
          <div class="flex flex-row justify-between">

            <div class="align-middle text-xl">
              Aantal:
            </div>
            <div>
              <InputNumber @change="onUpdateTransactionInformation()" v-model="amount" showButtons :min="0"
                           :max="amountAvailable"></InputNumber>
            </div>
          </div>
          <div class="flex flex-row justify-between">
            <div class="align-middle text-xl">
              Prijs: € {{ price }}
            </div>
            <div class="flex justify-end">
              <Button label="Huren" :disabled="amount < 1" @click="showRenterInfo()"></Button>
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
      <Dialog v-model:visible="showNotPossibleModal" modal header="Sorry!" :style="{ width: '50vw' }"
              :breakpoints="{ '1199px': '75vw', '575px': '90vw' }">
        <div>
          <span class="p-text-secondary block mb-5">Het is helaas nog niet mogelijk om dit item te huren.</span>
        </div>
      </Dialog>
      <Dialog v-model:visible="showRenterInfoModal" modal header="Jouw gegevens" :style="{ width: '50vw' }"
              :breakpoints="{ '1199px': '75vw', '575px': '90vw' }">
        <SrRenterInformationForm v-model="renter"
                                 :save-action="startTransaction">
        </SrRenterInformationForm>
      </Dialog>
      <Toast/>
    </template>
  </form-page>
</template>
<script setup lang="ts">

import {useRoute} from "#app";
import type {Image, RentalItem} from "~/schemas/openapi/rentalItem";
import SearchClient from "~/services/api/SearchClient";
import TransactionClient from "~/services/api/TransactionClient";
import RenterClient from "~/services/api/RenterClient";
import type {Renter} from "~/schemas/openapi/renter";
import type {RenterInput} from "~/schemas/openapi/transaction";
import {useToast} from "primevue/usetoast";
import SrRenterInformationForm from "~/components/SrRenterInformationForm.vue";

const router = useRouter()
const error = ref<String | undefined>(undefined)
const $searchClient: SearchClient = useNuxtApp().$searchClient;
const $transactionClient: TransactionClient = useNuxtApp().$transactionClient;

const route = useRoute();
const toast = useToast();
const renter = ref<Renter | undefined>();
const amount = ref(0);
const price = ref(0);
const amountAvailable = ref(0);
const slug = Array.isArray(route.params.rentalItemSlug) ? route.params.rentalItemSlug[0] : route.params.rentalItemSlug;
const item = ref<RentalItem>({
  name: "",
  id: 0
});
const dates = ref([]);
const images = ref<Image[]>([]);
const showRenterInfoModal = ref(false);
const showNotPossibleModal = ref(false);

onMounted(() => {
  fetchItem()
      .then(() => {
        calculatePrice()
        getAvailableItemsAmount()
      })
})

watch(amount, () => {
  calculatePrice()
})

const startTransaction = () => {
  if (false) {
    showNotPossibleModal.value = true
  } else {
    console.log(renter.value)
    if (dates.value[0] != null && dates.value[1] != null) {
      $transactionClient.startTransaction(
          item.value.id,
          dates.value[0],
          dates.value[1],
          amount.value,
          renter.value
      ).then(
          success => {
            navigateTo(success.redirectUrl, {external: true})
          },
          failure => {
            showError(failure.message);
          }
      )
    } else {
      showError("Selecteer een begin en einddatum");
    }
  }
}

function onUpdateTransactionInformation() {
  getAvailableItemsAmount()
  calculatePrice()
}

const showError = (message: String) => {
  toast.add({severity: 'error', summary: 'Er is iets fout gegaan', detail: message, life: 5000});
};

function calculatePrice() {
  if (dates.value[0] != null && dates.value[1] != null) {
    $transactionClient.calculatePrice(
        item.value.id,
        dates.value[0],
        dates.value[1],
        amount.value
    ).then(
        success => {
          price.value = success.price
        },
        failure => {
          showError(failure.message);
        }
    )
  }
}

function showRenterInfo() {
  if (dates.value[0] != null && dates.value[1] != null) {
    showRenterInfoModal.value = true
  } else {
    showError("Selecteer een begin en einddatum");
  }
}

function getAvailableItemsAmount() {
  if (dates.value[0] == null || dates.value[1] == null) {
    return
  }
  $transactionClient.getAvailableItems(
      dates.value[0],
      dates.value[1],
      item.value.id
  ).then(
      success => {
        amountAvailable.value = success.amountAvailable
        amount.value = amountAvailable.value
      },
      failure => {
        showError(failure.message);
      }
  )
}

async function fetchItem() {
  let success = await $searchClient.details(slug);
  item.value = success
  if (success.images != undefined) {
    images.value = success.images
  }
}
</script>