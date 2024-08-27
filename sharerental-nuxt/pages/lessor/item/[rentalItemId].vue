<template>
  <Head>
    <Title>Artikelen</Title>
  </Head>
  <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>
  <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 md:gap-8 md:p-12">
      <div class="px-8">
        <RentalItemForm v-model="rentalItem" ref="rentalItemForm"></RentalItemForm>

        <div class="flex justify-end mt-8">
          <Button label="Opslaan" @click="onSubmitNewItem"/>
        </div>
      </div>
    </div>
  </div>
</template>
<script setup lang="ts">
import type {RentalItem} from "~/schemas/openapi/rentalItem";
import type RentalItemForm from "~/components/RentalItemForm.vue";

const router = useRouter()
const error = ref<String | undefined>(undefined)
const $rentalItemApi = useNuxtApp().$rentalItemApi;
const route = useRoute();
const itemId = Number.parseInt(Array.isArray(route.params.rentalItemId) ? route.params.rentalItemId[0] : route.params.rentalItemId);

const rentalItemForm = ref<typeof RentalItemForm | null>(null)
const rentalItem = ref<RentalItem | undefined>()

onMounted(() => {
  fetchItem();
})

function fetchItem() {
  $rentalItemApi.getRentalItem({id: itemId})
      .then(
          success => {
            rentalItem.value = success
          }
      )
}

const onSubmitNewItem = async () => {
  const success = await rentalItemForm.value?.submitRentalItemForm()
  if (!success) return

  if (rentalItem.value) {

    $rentalItemApi.updateRentalItem({
      id: itemId,
      rentalItemInput: rentalItem.value
    })
        .then(success => {
              router.push('/lessor/items')
            },
            failureReason => {
              error.value = "Er is iets fout gegaan"
            })
  }
}

</script>
<style>

.flexbox-column {
  display: flex;
  flex-direction: column
}

</style>