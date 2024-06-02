<script setup lang="ts">
import {useRoute} from "#app";
import type {Image, RentalItem} from "~/schemas/openapi/rentalItem";
import SearchClient from "~/services/api/SearchClient";
import TransactionClient from "~/services/api/TransactionClient";
import {useToast} from "primevue/usetoast";
import SrRentalItemProperty from "~/components/SrRentalItemProperty.vue";
import {useCartStore} from "~/services/stores/cartStore";
import {RenterTypeEnum, useRenterTypeStore} from "~/services/stores/renterTypeStore";

const $searchClient: SearchClient = useNuxtApp().$searchClient;
const $transactionClient: TransactionClient = useNuxtApp().$transactionClient;

const route = useRoute();
const router = useRouter();
const toast = useToast();
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
const showNotPossibleModal = ref(false);
const cartStore = useCartStore();
const {renterType} = storeToRefs(useRenterTypeStore())

await useAsyncData(slug, () => $searchClient.details(slug))
    .then((response) => {
      item.value = response.data.value!
      if (item.value.images != undefined) {
        images.value = item.value.images
      } else {
        images.value = [
          {
            id: 0,
            url: '/SR_s_green_white.png'
          }
        ]
      }

      calculatePrice()
      getAvailableItemsAmount()

      let offers = [
        {price: "" + item.value.price24h, priceCurrency: "EUR", availability: "InStock", leaseLength: "P1D"}
      ];

      if (item.value.price168h) {
        offers.push({price: "" + item.value.price168h, priceCurrency: "EUR", availability: "InStock", leaseLength: "P7D"})
      }
      useSchemaOrg([
        defineProduct({
          name: item.value.name,
          offers: offers,
          image: images.value[0]?.url,
          description: item.value.shortDescription
        })
      ])
    })

watch(amount, () => {
  calculatePrice()
})

const startTransaction = () => {
  cartStore.setCart(
      item.value,
      amount.value,
      dates.value[1],
      dates.value[0],
      price.value
  ).then(() => {
    router.push("/transaction/checkout")
  })
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
    startTransaction()
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

const formatter = new Intl.NumberFormat('nl-NL', {
  style: 'currency',
  currency: 'EUR',
})

function formatCurrency(value: number | undefined) {
  if (value !== undefined && value !== null) {
    if (renterType.value === RenterTypeEnum.Business) {
      return formatter.format(value)
    } else {
      return formatter.format(value * 1.21)
    }
  } else return "Niet bekend"
}
</script>
<template>
  <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 md:gap-8 place-items-center md:p-12">
      <div class="m-8">
        <h1 class="font-bold text-4xl text-center">{{ item.name }}</h1>
        <div class="flex align-middle">
          <Galleria :value="images" :numVisible="5"
                    :showThumbnails="false" :showIndicators="true">
            <template #item="slotProps: {item: Image}">
              <img :src="slotProps.item.url" alt="image" style="width: 100%; display: block"/>
            </template>
          </Galleria>
        </div>
      </div>
      <div class="flex flex-col items-center md:p-8">
        <div class="flex gap-16 align-middle">
          <div class="flex flex-col items-center">
            <span class="font-bold">Per dag</span>
            <span class="font-extrabold text-3xl">{{ formatCurrency(item.price24h) }}</span>
          </div>
          <div class="flex flex-col items-center" v-if="item.price168h">
            <span class="font-bold">Per week</span>
            <span class="font-extrabold text-3xl">{{ formatCurrency(item.price168h) }}</span>
          </div>
        </div>
        <divider></divider>
        <div class="flex flex-col gap-4 py-5">
          <span class="font-bold text-xl">Wanneer heb je dit nodig?</span>
          <div>
            <Calendar v-model="dates" selectionMode="range" @dateSelect="onUpdateTransactionInformation()"
                      @change="onUpdateTransactionInformation()" :minDate="new Date()"
                      showIcon iconDisplay="input" touchUI hideOnRangeSelection
            >
            </Calendar>
          </div>
        </div>
        <div class="flex flex-col gap-4 py-5">
          <span class="font-bold text-xl">Hoeveel heb je er nodig?</span>
          <div>
            <InputNumber @change="onUpdateTransactionInformation()"
                         v-model="amount" showButtons :min="0"
                         :max="amountAvailable"
                         inputId="horizontal-buttons"
                         buttonLayout="horizontal"
                         :pt="{ input: 'w-40'}"
            >
              <template #incrementbuttonicon>
                <span class="pi pi-plus"/>
              </template>
              <template #decrementbuttonicon>
                <span class="pi pi-minus"/>
              </template>
            </InputNumber>
          </div>
        </div>
        <divider></divider>
        <div class="flex gap-4 items-center">
          <div class="flex flex-col">
            <span class="font-bold text-green-900">Jouw prijs</span>
            <span class="font-bold text-green-900 text-3xl">{{ formatCurrency(price) }}</span>
          </div>
          <div>
            <Button label="Direct reserveren" :disabled="amount < 1" @click="showRenterInfo()"></Button>
          </div>
        </div>
      </div>
      <div>
        <h2></h2>
      </div>
      <div>
        <div class="flex flex-col">
          <span class="font-bold text-xl">Specificaties</span>
          <divider></divider>
          <SrRentalItemProperty :field="item.brand" label="Merk"/>
          <SrRentalItemProperty :field="item.longDescription" label="Omschrijving"/>
          <SrRentalItemProperty :field="item.reachMeters" label="Bereik" suffix="m"/>
          <SrRentalItemProperty :field="item.carryingWeightKilograms" label="Maximale draaggewicht" suffix="kg"/>
          <SrRentalItemProperty :field="item.maximumWorkHeightMeters" label="Maximale werkhoogte" suffix="m"/>
          <SrRentalItemProperty :field="item.intrinsicWeightKilograms" label="Gewicht" suffix="kg"/>
          <SrRentalItemProperty :field="item.materialType" label="Type materiaal"/>
          <SrRentalItemProperty :field="item.maximumPressureBars" label="Maximale drukvermogen" suffix="bar"/>
          <SrRentalItemProperty :field="item.maximumHorsePower" label="Maximale vermogen" suffix="pk"/>
          <SrRentalItemProperty :field="item.requiredPowerVoltageVolt" label="Benodigde stroomtoevoer" suffix="V"/>
          <SrRentalItemProperty :field="item.workWidthMeters" label="Werkbreedte" suffix="m"/>
          <SrRentalItemProperty :field="item.vacuumAttachmentPossible" label="Stofzuiger aansluiting"/>
          <SrRentalItemProperty :field="item.capacityLiters" label="Bakinhoud" suffix="l"/>
          <SrRentalItemProperty :field="item.itemHeight" label="Artikelhoogte" suffix="m"/>
          <SrRentalItemProperty :field="item.itemWidth" label="Artikelbreedte" suffix="m"/>
          <SrRentalItemProperty :field="item.itemLength" label="Artikellengte" suffix="m"/>
          <SrRentalItemProperty :field="item.powerWatt" label="Vermogen" suffix="W"/>
          <SrRentalItemProperty :field="item.maximumSurfaceSquareMeters" label="Maximale oppervlakte" suffix="m2"/>
        </div>
      </div>
    </div>
  </div>
  <sr-cta-lessor></sr-cta-lessor>
  <Dialog v-model:visible="showNotPossibleModal" modal header="Sorry!" :style="{ width: '50vw' }"
          :breakpoints="{ '1199px': '75vw', '575px': '90vw' }">
    <div>
      <span class="p-text-secondary block mb-5">Het is helaas nog niet mogelijk om dit item te huren.</span>
    </div>
  </Dialog>
</template>