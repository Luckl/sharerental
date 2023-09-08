<template>
  <ClientOnly>
    <div class="form-container">
      <DataTable :first="0" :value="rentalItems" lazy paginator :rows="pageSize"
                 :rowsPerPageOptions="[5, 10, 20, 50]" tableStyle="min-width: 50rem" ref="dt"
                 :totalRecords="totalElements" @page="onPage($event)"
                 paginatorTemplate="RowsPerPageDropdown FirstPageLink PrevPageLink CurrentPageReport NextPageLink LastPageLink"
                 currentPageReportTemplate="{first} tot {last} van {totalRecords}">
        <template #header>
          <div class="flex flex-wrap align-items-center justify-between gap-2">
            <InputText v-model="filter" placeholder="Zoeken"></InputText>
              <Button label="Nieuw" icon="pi pi-plus" @click="clickNew()"></Button>
          </div>
        </template>
        <Column field="name" header="Naam" style="width: 25%"></Column>
        <Column field="category" header="Categorie" style="width: 25%"></Column>
        <Column field="number" header="Referentie" style="width: 25%"></Column>
        <Column field="brand" header="Merk" style="width: 25%"></Column>
        <Column header="Acties" style="width: 25%">
          <template #body="slotProps">
            <Button icon="pi pi-pencil"></Button>
          </template>
        </Column>
      </DataTable>
    </div>
  </ClientOnly>
</template>
<script lang="ts" setup>
import {FuelType, GetRentalItemsResult, RentalItem} from "~/schemas/openapi/merged";

const router = useRouter()
const filter = ref("")
const page = ref(1)
const pageSize = ref(5)
const totalElements = ref(0)
const rentalItems = ref<RentalItem[]>([])
const rentalItemResult = ref<GetRentalItemsResult>()

onMounted(() => {
  rentalItemResult.value = {
    "embedded": [
      {
        "id": 1,
        "name": "Excavator Rental",
        "images": [
          {
            "id": 101,
            "url": "https://example.com/image1.jpg"
          },
          {
            "id": 102,
            "url": "https://example.com/image2.jpg"
          }
        ],
        "number": "ER-123",
        "shortDescription": "Heavy-duty excavator for construction projects.",
        "longDescription": "This excavator is perfect for digging and earthmoving tasks.",
        "price24h": 199.99,
        "price48h": 349.99,
        "price168h": 999.99,
        "deliveryPossible": true,
        "deliveryPrice": 29.99,
        "category": "Construction Equipment",
        "reachMeters": 12.3,
        "carryingWeightKilograms": 800,
        "maximumWorkHeightMeters": 20.5,
        "intrinsicWeightKilograms": 1500,
        "materialType": "Steel",
        "brand": "HeavyDutyCo",
        "maximumPressureBars": 220,
        "maximumHorsePower": 75.5,
        "requiredPowerVoltageVolt": 240,
        "workWidthMeters": 2.8,
        "vacuumAttachmentPossible": false,
        "capacityLiters": 150,
        "itemHeight": 2.0,
        "itemWidth": 1.4,
        "itemLength": 4.5,
        "powerWatt": 4500,
        "maximumSurfaceSquareMeters": 800,
        "fuelType": "DIESEL"
      },
      {
        "id": 2,
        "name": "Concrete Mixer Rental",
        "images": [
          {
            "id": 201,
            "url": "https://example.com/image3.jpg"
          },
          {
            "id": 202,
            "url": "https://example.com/image4.jpg"
          }
        ],
        "number": "CM-456",
        "shortDescription": "High-capacity concrete mixer for construction sites.",
        "longDescription": "This concrete mixer can handle large concrete mixing tasks efficiently.",
        "price24h": 149.99,
        "price48h": 269.99,
        "price168h": 799.99,
        "deliveryPossible": true,
        "deliveryPrice": 19.99,
        "category": "Construction Equipment",
        "reachMeters": 0.0,
        "carryingWeightKilograms": 400,
        "maximumWorkHeightMeters": 0.0,
        "intrinsicWeightKilograms": 800,
        "materialType": "Steel",
        "brand": "MixMaster",
        "maximumPressureBars": 0.0,
        "maximumHorsePower": 15.0,
        "requiredPowerVoltageVolt": 220,
        "workWidthMeters": 0.0,
        "vacuumAttachmentPossible": false,
        "capacityLiters": 200,
        "itemHeight": 1.5,
        "itemWidth": 1.2,
        "itemLength": 2.0,
        "powerWatt": 2200,
        "maximumSurfaceSquareMeters": 0.0,
        "fuelType": "ELECTRIC"
      },
      {
        "id": 123,
        "name": "Kniklader",
        "images": [
          {
            "url": "https://example.com/image1.jpg",
            "id": 1234
          },
          {
            "url": "https://example.com/image2.jpg",
            "id": 4321
          }
        ],
        "number": "RI-456",
        "shortDescription": "Short description of the rental item.",
        "longDescription": "Long description of the rental item. This text field will need to contain more text than the short desciption since there will be more space to display it.",
        "price24h": 49.99,
        "price48h": 79.99,
        "price168h": 199.99,
        "deliveryPossible": true,
        "deliveryPrice": 9.99,
        "category": "Construction Equipment",
        "reachMeters": 10.5,
        "carryingWeightKilograms": 500,
        "maximumWorkHeightMeters": 15.7,
        "intrinsicWeightKilograms": 1000,
        "materialType": "Steel",
        "brand": "Sample Brand",
        "maximumPressureBars": 200,
        "maximumHorsePower": 50.5,
        "requiredPowerVoltageVolt": 220,
        "workWidthMeters": 2.5,
        "vacuumAttachmentPossible": true,
        "capacityLiters": 100,
        "itemHeight": 1.8,
        "itemWidth": 1.2,
        "itemLength": 3.0,
        "powerWatt": 3500,
        "maximumSurfaceSquareMeters": 500,
        "fuelType": FuelType.Gasoline
      },
      {
        "id": 456,
        "name": "Graafmachine",
        "images": [
          {
            "url": "https://example.com/image3.jpg",
            "id": 1111
          },
          {
            "url": "https://example.com/image4.jpg",
            "id": 2222
          }
        ],
        "number": "ER-789",
        "shortDescription": "Heavy-duty excavator for construction projects.",
        "longDescription": "This excavator is perfect for digging and earthmoving tasks.",
        "price24h": 199.99,
        "price48h": 349.99,
        "price168h": 999.99,
        "deliveryPossible": true,
        "deliveryPrice": 29.99,
        "category": "Construction Equipment",
        "reachMeters": 12.3,
        "carryingWeightKilograms": 800,
        "maximumWorkHeightMeters": 20.5,
        "intrinsicWeightKilograms": 1500,
        "materialType": "Steel",
        "brand": "HeavyDutyCo",
        "maximumPressureBars": 220,
        "maximumHorsePower": 75.5,
        "requiredPowerVoltageVolt": 240,
        "workWidthMeters": 2.8,
        "vacuumAttachmentPossible": false,
        "capacityLiters": 150,
        "itemHeight": 2.0,
        "itemWidth": 1.4,
        "itemLength": 4.5,
        "powerWatt": 4500,
        "maximumSurfaceSquareMeters": 800,
        "fuelType": FuelType.Diesel
      }
    ],
    "page": {
      "number": 1,
      "pageSize": 4,
      "totalPages": 1,
      "totalElements": 4
    }
  }
  totalElements.value = rentalItemResult.value?.page.totalElements
  rentalItems.value = rentalItemResult.value?.embedded
})

function clickNew() {
  router.push('/item/add')
}

const onPage = (event) => {
  page.value = event.page
};

</script>
<style>
.form-container {
  padding-left: 10%;
  padding-right: 10%;
  padding-top: 5em;
  height: 100%;
}
</style>
