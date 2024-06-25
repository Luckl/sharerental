<template>
  <sr-category-page category-description="" :query="route.query.query">
  </sr-category-page>
</template>

<script setup lang="ts">
definePageMeta({
  layout: 'no-header'
})
const route = useRoute();
</script>

<style scoped>

</style>