<script lang="ts" setup>

definePageMeta({
  layout: 'no-header'
})

const category = ref('Grondverzetters, bouwmachines en tuinmateriaal')

</script>
<template>
  <sr-category-page
    category-description="Welkom bij ons uitgebreide assortiment voor grondverzetters, bouwmachines en tuinmateriaal. Of je nu een
          professionele aannemer bent of een enthousiaste tuinier, wij hebben de juiste apparatuur om je te helpen bij
          elke klus. Van graafmachines en bulldozers tot hakselaars en grasmaaiers, ons assortiment biedt hoogwaardige
          machines voor grondverzet, bouwwerkzaamheden en tuinonderhoud. Ontdek ons aanbod en maak jouw projecten
          efficiënter en gemakkelijker met onze kwaliteitsapparatuur."
    :category="category"></sr-category-page>

</template>