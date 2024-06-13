<template>
  <div v-if="field" class="flex justify-between">
    <span class="font-bold mr-4">{{ label }}</span>
    <span class="text-end ">{{ field }} {{ suffix }}</span>
  </div>
  <divider  v-if="field"></divider>
</template>
<script setup lang="ts">

interface Props {
  field: string | undefined;
  label: string;
  suffix?: string;
}

// Define props and emitters here if needed
defineProps<Props>()
</script>