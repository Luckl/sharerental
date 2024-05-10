<script lang="ts" setup>

definePageMeta({
  layout: 'no-header'
})

const category = ref('Hef- en hijswerktuigen')

</script>
<template>
  <sr-category-page
      :category="category"
      category-description="Welkom bij ons brede assortiment aan hef- en hijswerktuigen. Of je nu bezig bent met bouwprojecten, renovaties of het verplaatsen van zware lasten,
      wij hebben de juiste apparatuur om je te helpen. Van hijskranen en takels tot palletwagens en heftrucks, onze gereedschappen zijn ontworpen voor efficiëntie en veiligheid.
      Bekijk ons aanbod en maak jouw werk gemakkelijker en veiliger met onze hoogwaardige hef- en hijswerktuigen."
  ></sr-category-page>
</template>