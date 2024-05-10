<script lang="ts" setup>

definePageMeta({
  layout: 'no-header'
})

const category = ref('Electrisch gereedschap')

</script>
<template>
  <sr-category-page
    category-description="Welkom bij ons uitgebreide assortiment elektrisch gereedschap. Of je nu een professionele vakman bent of een
          enthousiaste doe-het-zelver, wij hebben het juiste gereedschap voor elke klus. Van boormachines en cirkelzagen
          tot schuurmachines en decoupeerzagen, ons assortiment biedt hoogwaardige elektrische gereedschappen voor
          diverse toepassingen. Ontdek ons aanbod en voltooi je projecten met gemak en precisie."
    :category="category"></sr-category-page>
</template>