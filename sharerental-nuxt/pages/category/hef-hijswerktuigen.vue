<script lang="ts" setup>

definePageMeta({
  layout: 'no-header'
})


const materialTypes = ref(["Aluminium", "Staal", "Hout"])
const selectedMaterialType = ref([])
const menuOpened = ref(false)
const priceRange = ref([0, 1000])

</script>
<template>
  <Head>
    <Title>Hef- en hijswerktuigen - ShareRental</Title>
  </Head>
  <SrTopBar>
    <Search></Search>
  </SrTopBar>

  <div class="md:max-w-[1240px] md:mx-auto mt-10 flex px-4 md:px-0">

    <div class="w-1/6 m-5">
      <div class="w-full text-xl font-bold">Filteren</div>
      <Divider></Divider>
      <Accordion unstyled>
        <AccordionTab header="Prijs">
          <div class="p-2 m-2">
          <Slider v-model="priceRange" range class="w-full" />
          </div>
        </AccordionTab>
        <AccordionTab header="Regio">
          <div class="p-2 m-2">
          </div>
        </AccordionTab>
        <AccordionTab header="Maximale werkhoogte">
          <div class="p-2 m-2">
          </div>
        </AccordionTab>
        <AccordionTab header="Type materiaal">
          <div class="p-2 m-2">
            <div v-for="materialType of materialTypes" :key="materialType" class="flex gap-2 align-items-center">
              <Checkbox v-model="selectedMaterialType" :inputId="materialType" name="category" :value="materialType" />
              <label :for="materialType">{{ materialType }}</label>
            </div>
          </div>
        </AccordionTab>
        <AccordionTab header="Bereik">
        </AccordionTab>
      </Accordion>
    </div>
    <div class="w-5/6">
      <div>
        <span class=" text-4xl font-bold text-center">Hef- en hijswerktuigen</span>
        <div class="mt-5">
          Welkom bij ons brede assortiment aan hef- en hijswerktuigen. Of je nu bezig bent met bouwprojecten, renovaties of het verplaatsen van zware lasten, wij hebben de juiste apparatuur om je te helpen. Van hijskranen en takels tot palletwagens en heftrucks, onze gereedschappen zijn ontworpen voor efficiëntie en veiligheid. Bekijk ons aanbod en maak jouw werk gemakkelijker en veiliger met onze hoogwaardige hef- en hijswerktuigen.
        </div>
      </div>
      <div class="mt-10">
        <h1>Er zijn op dit moment nog geen artikelen beschikbaar in deze categorie</h1>
      </div>
    </div>

  </div>

</template>
<style scoped>

</style>