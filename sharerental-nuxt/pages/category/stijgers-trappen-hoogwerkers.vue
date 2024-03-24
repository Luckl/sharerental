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
    <Title>Stijgers, trappen en hoogwerkers - ShareRental</Title>
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
            <div v-for="category of materialTypes" :key="category" class="flex align-items-center">
              <Checkbox v-model="selectedMaterialType" :inputId="category" name="category" :value="category" />
              <label :for="category">{{ category }}</label>
            </div>
          </div>

        </AccordionTab>
        <AccordionTab header="Bereik">
        </AccordionTab>


      </Accordion>
    </div>
    <div class="w-5/6">
      <div>
        <span class=" text-4xl font-bold text-center">Stijgers, trappen en hoogwerkers</span>
        <div class="mt-5">
          Welkom bij ons uitgebreide assortiment aan stijgers, trappen en hoogwerkers - de essentiële uitrusting voor elke taak die hoogtes vereist. Of je nu een professionele aannemer, een enthousiaste doe-het-zelver of een evenementenplanner bent, wij bieden een scala aan opties, van lichte draagbare steigers tot robuuste industriële stijgers, evenals snelle en betrouwbare trappen en hoogwerkers voor mobiliteit. Onze hoogwaardige gereedschappen zorgen voor optimale stabiliteit en veiligheid. Ontdek ons assortiment en til uw projecten naar nieuwe hoogten.
        </div>
      </div>
      <div>
      </div>
    </div>

  </div>

</template>
<style scoped>

</style>