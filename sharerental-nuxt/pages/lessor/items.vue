<template>
  <Head>
    <Title>Artikelen</Title>
  </Head>
  <ClientOnly>
    <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>

    <div class="form-container">
      <DataTable :first="0" :value="rentalItems" lazy paginator :rows="pageSize"
                 :rowsPerPageOptions="[5, 10, 20, 50]" tableStyle="min-width: 50rem" ref="dt"
                 :totalRecords="totalElements" @page="onPage($event)"
                 paginatorTemplate="RowsPerPageDropdown FirstPageLink PrevPageLink CurrentPageReport NextPageLink LastPageLink"
                 currentPageReportTemplate="{first} tot {last} van {totalRecords}">
        <template #header>
          <div class="flex flex-wrap align-items-center justify-between gap-2">
            <InputText v-model="filter" @change="fetchRentalItems()" placeholder="Zoeken"></InputText>
            <Button label="Nieuw" icon="pi pi-plus" @click="clickNew()"></Button>
          </div>
        </template>
        <Column field="name" header="Naam" style="width: 25%"></Column>
        <Column field="category" header="Categorie" style="width: 25%"></Column>
        <Column field="number" header="Referentie" style="width: 25%"></Column>
        <Column header="Zichtbaar" style="width: 20%">
          <template #body="slotProps">
            <div >
              <InputSwitch :model-value="determineVisible(slotProps.data)" @change="toggleVisibility(slotProps.data)"></InputSwitch>
            </div>
          </template>
        </Column>
        <Column header="Acties" style="width: 25%">
          <template #body="slotProps">
            <div class="flex gap-3">
              <Button icon="pi pi-pencil" @Click="goToEdit(slotProps.data.id)"></Button>
              <Button icon="pi pi-images" @Click="goToAddImages(slotProps.data.id)"></Button>
            </div>
          </template>
        </Column>

      </DataTable>
    </div>
  </ClientOnly>
</template>
<script lang="ts" setup>
import {DisplayStatus, RentalItemApi} from "~/schemas/openapi/rentalItem";
import type {GetRentalItemsResult, RentalItem} from "~/schemas/openapi/rentalItem";
import {useLessorStore} from "~/services/stores/lessorStore";

const error = ref<String | undefined>(undefined)
const router = useRouter()
const filter = ref("")
const page = ref(0)
const pageSize = ref(5)
const totalElements = ref(0)
const rentalItems = ref<RentalItem[]>([])
const {activeLessor} = storeToRefs(useLessorStore())
const rentalItemResult = ref<GetRentalItemsResult>()
const $rentalItemApi: RentalItemApi = useNuxtApp().$rentalItemApi;

onMounted(() => {
  fetchRentalItems();
})

function clickNew() {
  router.push('/lessor/item/add')
}
function determineVisible(item: RentalItem) {
  return item.displayStatus == DisplayStatus.Active;
}
const onPage = (event) => {
  page.value = event.page
  fetchRentalItems()
};

function goToEdit(id: number) {
  router.push('/lessor/item/' + id)
}

function goToAddImages(id: number) {
  router.push('/lessor/item/' + id + '/images')
}

function toggleVisibility(data: RentalItem) {
  if (data.displayStatus === "ACTIVE") {
    data.displayStatus = "INACTIVE"
  } else if (data.displayStatus === "INACTIVE") {
    data.displayStatus = "ACTIVE"
  }

  $rentalItemApi.updateRentalItem({
    id: data.id,
    rentalItemInput: {
      displayStatus: data.displayStatus,
      ...data
    }

  })
      .then(success => {
        fetchRentalItems()
      }, failure => {
        error.value = "Er is iets fout gegaan"
        fetchRentalItems()
      })
}

watch(activeLessor, () => {
  fetchRentalItems()
})

function fetchRentalItems() {
  $rentalItemApi.getRentalItems({
    page: page.value,
    size: pageSize.value,
    sort: [],
    filter: filter.value,
    lessorId: activeLessor.value?.id
  })
      .then(
          success => {
            rentalItemResult.value = success
            totalElements.value = rentalItemResult.value?.page.totalElements
            rentalItems.value = rentalItemResult.value?.embedded
          },
          failure => {
            error.value = "Er is iets fout gegaan"
          }
      )
}
</script>
<style>
.form-container {
  padding-left: 10%;
  padding-right: 10%;
  padding-top: 5em;
  height: 100%;
}
</style>
