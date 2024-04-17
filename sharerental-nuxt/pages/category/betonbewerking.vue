<script lang="ts" setup>

definePageMeta({
  layout: 'no-header'
})

const category = ref('Betonbewerking')
</script>
<template>
  <sr-category-page
    category-description="Welkom bij onze uitgebreide collectie voor betonbewerking. Of je nu een professional bent in de bouwsector of
          een enthousiaste klusser die betonklussen aanpakt, wij hebben de juiste gereedschappen voor jou. Van
          betonmixers tot betonmolens en betonschuurmachines, ons assortiment biedt hoogwaardige apparatuur om jouw
          projecten soepel te laten verlopen. Ontdek onze selectie en bereid je voor om betonwerk van topkwaliteit te
          leveren."
    :category="category"></sr-category-page>

</template>