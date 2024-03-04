<!--TODO: Oude meuk-->
<template>
  <div v-if="field" class="grid grid-cols-2 lg:grid-cols-4">
    <span class="font-bold">{{ label }}</span>
    <span class="col-span-1 lg:col-span-3">{{ field }} {{ suffix }}</span>
  </div>
</template>
<script setup lang="ts">

interface Props {
  field: string | undefined;
  label: string;
  suffix?: string;
}

// Define props and emitters here if needed
const props = defineProps<Props>()
</script>