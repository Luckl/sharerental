<script lang="ts" setup>

definePageMeta({
  layout: 'no-header'
})

const category = ref('Evenementen')

</script>
<template>
  <sr-category-page
    category-description="Welkom bij onze selectie voor evenementen. Of je nu een groot feest organiseert, een zakelijk evenement plant of een bruiloft verzorgt, wij hebben alles wat je nodig hebt om jouw evenement
    onvergetelijk te maken. Van tenten en podiums tot geluidsinstallaties en verlichting, ons assortiment biedt hoogwaardige apparatuur voor elke gelegenheid.
    Ontdek ons aanbod en maak van jouw evenement een succesvolle en gedenkwaardige ervaring."
    :category="category"></sr-category-page>
</template>