<script lang="ts" setup>

import type {Renter} from "~/schemas/openapi/renter";

const renter = ref<Renter>()

const startTransaction = () => {
  console.log(renter.value)
}
</script>
<template>
  <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4 md:gap-8 place-items-center md:p-12">
      <sr-renter-information-form v-model="renter" :save-action="startTransaction">

      </sr-renter-information-form>
    </div>
  </div>

</template>
