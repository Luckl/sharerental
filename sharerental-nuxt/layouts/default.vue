<template>
  <div>
    <SiteNavigation></SiteNavigation>
    <slot/>
  </div>
</template>

<script setup lang="ts">
import SiteNavigation from "~/components/SiteNavigation.vue";
</script>

<style scoped>

</style>