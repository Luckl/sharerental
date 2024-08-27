<template>
  <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>

  <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">
      <div class="flex justify-end mt-8">
        <Button label="Aanmaken" @click="onSubmitNewItem" />
      </div>
  </div>
  <RentalItemForm v-model="rentalItem" ref="rentalItemForm"></RentalItemForm>

</template>
<script setup lang="ts">
import type {RentalItem} from "~/schemas/openapi/rentalItem";
import {useLessorStore} from "~/services/stores/lessorStore";
import type RentalItemForm from "~/components/RentalItemForm.vue";

const rentalItemForm = ref<typeof RentalItemForm | null>(null)

const router = useRouter()
const error = ref<String | undefined>(undefined)
const $rentalItemApi = useNuxtApp().$rentalItemApi;
const {activeLessor} = storeToRefs(useLessorStore())

const rentalItem = ref<RentalItem | undefined>()

const onSubmitNewItem = async () => {
  const success = await rentalItemForm.value?.submitRentalItemForm()

  if (!success) return

  if (rentalItem.value) {
    $rentalItemApi.createRentalItem({
      rentalItemInput: {
        ...rentalItem.value,
      },
      lessorId: activeLessor.value?.id ?? 0
    }).then(
      success => {
        router.push(`/lessor/items`)
      },
      failure => {
        error.value = failure.message
      }
    )
  }
}

</script>