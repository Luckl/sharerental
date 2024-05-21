<template>
  <sr-category-page category-description="" :query="query">
  </sr-category-page>
</template>

<script setup lang="ts">
definePageMeta({
  layout: 'no-header'
})
const route = useRoute();
const query = Array.isArray(route.params.query) ? route.params.query[0] : route.params.query;
</script>

<style scoped>

</style>