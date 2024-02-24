<script lang="ts" setup>
import SrBlackBar from "~/components/SrTopBar.vue";

definePageMeta({
  layout: 'new'
})

const menuOpened = ref(false)
</script>
<template>
  <Head>
    <Title>Stijgers, trappen en hoogwerkers - ShareRental</Title>
  </Head>
  <SrTopBar>
    <Search></Search>
  </SrTopBar>


</template>
<style scoped>

</style>