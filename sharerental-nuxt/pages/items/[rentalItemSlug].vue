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
      <Dialog v-model:visible="showRenterInfoModal" modal header="Jouw gegevens" :style="{ width: '50vw' }"
              :breakpoints="{ '1199px': '75vw', '575px': '90vw' }">
        <div v-if="!editRenterInfo">
          <span class="p-text-secondary block mb-5">Controleer je gegevens.</span>
          <div class="flexbox-column">
            <label for="fName" class="data-label mb-1">Naam</label>
            <span>{{ renter.firstName }}</span>
          </div>
          <div class="flexbox-column">
            <label for="lName" class="data-label mb-1">Achternaam</label>
            <span>{{ renter.lastName }}</span>
          </div>
          <div class="flexbox-column">
            <label for="email" class="data-label mb-1">Email</label>
            <span>{{ renter.email }}</span>
          </div>
          <div class="flexbox-column">
            <label for="phoneNumber" class="data-label mb-1">Telefoonnummer</label>
            <span>{{ renter.phoneNumber }}</span>
          </div>
          <div class="flexbox-column">
            <label for="street" class="data-label mb-1">Straat</label>
            <span>{{ renter.location?.street }}</span>
          </div>
          <div class="flexbox-column">
            <label for="houseNumber" class="data-label mb-1">Huisnummer</label>
            <span>{{ renter.location?.houseNumber }}</span>
          </div>
          <div class="flexbox-column">
            <label for="postalCode" class="data-label mb-1">Postcode</label>
            <span>{{ renter.location?.postalCode }}</span>
          </div>
          <div class="flexbox-column">
            <label for="city" class="data-label mb-1">Stad</label>
            <span>{{ renter.location?.city }}</span>
          </div>
          <div class="flexbox-column">
            <label for="country" class="data-label mb-1">Land</label>
            <span>{{ renter.location?.country }}</span>
          </div>
        </div>
        <div v-else>
          <span class="p-text-secondary block mb-5">Vul je gegevens in.</span>
          <div class="flexbox-column">
            <label for="fName" class="data-label mb-1">Naam</label>
            <InputText inputId="fName" class="mb-1" v-model="renterInput.firstName"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="lName" class="data-label mb-1">Achternaam</label>
            <InputText inputId="lName" class="mb-1" v-model="renterInput.lastName"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="email" class="data-label mb-1">Email</label>
            <InputText inputId="email" class="mb-1" v-model="renterInput.email"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="phoneNumber" class="data-label mb-1">Telefoonnummer</label>
            <InputText inputId="phoneNumber" class="mb-1" v-model="renterInput.phoneNumber"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="street" class="data-label mb-1">Straat</label>
            <InputText inputId="street" class="mb-1" v-model="renterInput.street"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="houseNumber" class="data-label mb-1">Huisnummer</label>
            <InputText inputId="houseNumber" class="mb-1" v-model="renterInput.houseNumber"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="postalCode" class="data-label mb-1">Postcode</label>
            <InputText inputId="postalCode" class="mb-1" v-model="renterInput.postalCode"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="city" class="data-label mb-1">Stad</label>
            <InputText inputId="city" class="mb-1" v-model="renterInput.city"></InputText>
          </div>
          <div class="flexbox-column">
            <label for="country" class="data-label mb-1">Land</label>
            <InputText inputId="country" class="mb-1" v-model="renterInput.country"></InputText>
          </div>
        </div>
        <div v-if="!editRenterInfo">
          <Button type="button" label="Aanpassen" @click="enableRenterEditMode()"></Button>
        </div>
        <div class="flex justify-content-end gap-2">
          <Button type="button" label="Huren" @click="startTransaction()"></Button>
        </div>
      </Dialog>
      <Toast/>
    </template>
  </form-page>
</template>
<script setup lang="ts">

import {useRoute} from "#app";
import {Image, RentalItem} from "~/schemas/openapi/rentalItem";
import SearchClient from "~/services/api/SearchClient";
import TransactionClient from "~/services/api/TransactionClient";
import RenterClient from "~/services/api/RenterClient";
import {Renter} from "~/schemas/openapi/renter";
import {RenterInput} from "~/schemas/openapi/transaction";
import {useToast} from "primevue/usetoast";

const router = useRouter()
const error = ref<String | undefined>(undefined)
const $searchClient: SearchClient = useNuxtApp().$searchClient;
const $transactionClient: TransactionClient = useNuxtApp().$transactionClient;
const $renterClient: RenterClient = useNuxtApp().$renterClient;
const route = useRoute();
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
const showRenterInfoModal = ref(false);
const editRenterInfo = ref(false);
const renterInput = ref<RenterInput>({
  firstName: "",
  lastName: "",
  email: "",
  phoneNumber: "",
  street: "",
  houseNumber: "",
  postalCode: "",
  city: "",
  country: ""
});
const renter = ref<Renter>({
  id: 0,
  firstName: "",
  lastName: "",
  email: "",
  phoneNumber: "",
  location: {
    street: "",
    houseNumber: "",
    postalCode: "",
    city: "",
    country: ""
  }
});

onMounted(() => {
  fetchItem()
      .then(() => {
        calculatePrice()
        getAvailableItemsAmount()
      })

  getRenter()
})

watch(amount, () => {
  calculatePrice()
})

function startTransaction() {
  if (dates.value[0] != null && dates.value[1] != null) {
    $transactionClient.startTransaction(
        item.value.id,
        dates.value[0],
        dates.value[1],
        amount.value,
        editRenterInfo ? renterInput.value : undefined
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

function onUpdateTransactionInformation() {
  getAvailableItemsAmount()
  calculatePrice()
}

const showError = (message: String) => {
  console.log('an error occurred')
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

function enableRenterEditMode() {
  renterInput.value.firstName = renter.value.firstName
  renterInput.value.lastName = renter.value.lastName
  renterInput.value.email = renter.value.email
  renterInput.value.phoneNumber = renter.value.phoneNumber
  renterInput.value.street = renter.value.location?.street
  renterInput.value.houseNumber = renter.value.location?.houseNumber
  renterInput.value.postalCode = renter.value.location?.postalCode
  renterInput.value.city = renter.value.location?.city
  renterInput.value.country = renter.value.location?.country

  editRenterInfo.value = true
}

function getRenter() {
  $renterClient.getRenter().then(
      success => {
        renter.value = success
      },
      failure => {
        editRenterInfo.value = true
      }
  )
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
<style scoped>
.flexbox-column {
  display: flex;
  flex-direction: column;
}

.mb-1 {
  margin-bottom: 1rem;
}

.data-label {
  font-weight: bold;
}
</style>