<template>
  <Head>
    <Title>Artikelen - ShareRental</Title>
  </Head>
  <ClientOnly>
    <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>

    <div class="form-container">
      <DataTable :first="0" :value="transactions" lazy paginator :rows="pageSize"
                 :rowsPerPageOptions="[5, 10, 20, 50]" tableStyle="min-width: 50rem" ref="dt"
                 :totalRecords="totalElements" @page="onPage($event)"
                 paginatorTemplate="RowsPerPageDropdown FirstPageLink PrevPageLink CurrentPageReport NextPageLink LastPageLink"
                 currentPageReportTemplate="{first} tot {last} van {totalRecords}">
        <template #header>
          <div class="flex flex-wrap align-items-center justify-between gap-2">
            <InputText v-model="filter" @change="fetchTransactions()" placeholder="Zoeken"></InputText>
          </div>
        </template>
        <Column field="name" header="Naam" style="width: 25%"></Column>
        <Column field="category" header="Categorie" style="width: 25%"></Column>
        <Column field="number" header="Referentie" style="width: 25%"></Column>

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
import {
  DisplayStatus,
  GetTransactionsResult,
  Transaction, TransactionStatus
} from "~/schemas/openapi/merged";
import TransactionClient from "~/services/api/TransactionClient";

const error = ref<String | undefined>(undefined)
const router = useRouter()
const filter = ref("")
const page = ref(0)
const pageSize = ref(5)
const totalElements = ref(0)
const transactions = ref<Transaction[]>([])
const transactionsResult = ref<GetTransactionsResult>()
const $transactionClient: TransactionClient = useNuxtApp().$transactionClient;

const defaultStatuses = ref([
  TransactionStatus.Initialized,
  TransactionStatus.Paid,
  TransactionStatus.Accepted,
  TransactionStatus.Completed
])

onMounted(() => {
  fetchTransactions();
})

const onPage = (event) => {
  page.value = event.page
  fetchTransactions()
};

function goToEdit(id: number) {
  router.push('/lessor/item/' + id)
}

function goToAddImages(id: number) {
  router.push('/lessor/item/' + id + '/images')
}

function fetchTransactions() {
  $transactionClient.getTransactions(page.value, pageSize.value,["startDate;desc"], filter.value, defaultStatuses.value)
      .then(
          success => {
            transactionsResult.value = success
            totalElements.value = transactionsResult.value?.page.totalElements
            transactions.value = transactionsResult.value?.embedded
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
