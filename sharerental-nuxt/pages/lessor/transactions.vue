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
        <Column field="rentalItem.name" header="Artikel" style="width: 25%"></Column>
        <Column field="startDate" header="Vanaf" style="width: 25%">
          <template #body="slotProps">
            {{ slotProps.data.startDate.toDateString() }}
          </template>
        </Column>
        <Column field="endDate" header="Tot" style="width: 25%">

          <template #body="slotProps">
            {{ slotProps.data.endDate.toDateString() }}
          </template>
        </Column>

        <Column field="status" header="Status">
          <template #body="slotProps">
            <div v-if="slotProps.data.status === TransactionStatus.Initialized">
              <Tag value="Gereserveerd" severity="warning" v-tooltip.top="'Nog niet afgerekend'"></Tag>
            </div>
            <div v-if="slotProps.data.status === TransactionStatus.Paid">
              <Tag value="Betaald" severity="info"></Tag>
            </div>
            <div v-if="slotProps.data.status === TransactionStatus.Accepted">
              <Tag value="Geaccepteerd" severity="success"></Tag>
            </div>
            <div v-if="slotProps.data.status === TransactionStatus.Completed">
              <Tag value="Voltooid" severity="success"></Tag>
            </div>
            <div v-if="slotProps.data.status === TransactionStatus.Cancelled">
              <Tag value="Geannuleerd" severity="danger"></Tag>
            </div>
            <div v-if="slotProps.data.status === TransactionStatus.PaidOut">
              <Tag value="Uitbetaald" severity="success"></Tag>
            </div>
          </template>
        </Column>
        <Column header="Acties" style="width: 25%">
          <template #body="slotProps">
            <div v-if="slotProps.data.status === TransactionStatus.Paid">
              <Button label="Accepteren" @click="acceptTransaction(slotProps.data.id)" size="small" ></Button>
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

//TODO updating this via the datatable doesn't work
const pageSize = ref(20)
const totalElements = ref(0)
const transactions = ref<Transaction[]>([])
const transactionsResult = ref<GetTransactionsResult>()
const $transactionClient: TransactionClient = useNuxtApp().$transactionClient;

const defaultStatuses = ref([
  TransactionStatus.Initialized,
  TransactionStatus.Paid,
  TransactionStatus.Accepted,
  TransactionStatus.Completed,
  TransactionStatus.Cancelled,
  TransactionStatus.PaidOut,
])

onMounted(() => {
  fetchTransactions();
})

const onPage = (event) => {
  page.value = event.page
  fetchTransactions()
};

function acceptTransaction(id: number) {
  console.log("accepting transaction " + id)
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
