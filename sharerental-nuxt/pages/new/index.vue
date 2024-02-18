<script lang="ts" setup>

definePageMeta({
  title: 'ShareRental - Home',
  description: 'New layout',
  layout: 'new'
})
const img = useImage()

const category1Background = computed(() => {
  const imgUrl = img('categories/stijgers-trappen-hoogwerkers.jpg')
  return { backgroundImage: `linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(0, 0, 0, 1)), url('${imgUrl}')` }
})
const category2Background = computed(() => {
  const imgUrl = img('categories/Betonbewerking.jpg')
  return { backgroundImage: `linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(0, 0, 0, 1)), url('${imgUrl}')`, }
})
const category3Background = computed(() => {
  const imgUrl = img('categories/hef-en-hijswerktuigen.jpg')
  return { backgroundImage: `linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(0, 0, 0, 1)), url('${imgUrl}')` }
})
const category4Background = computed(() => {
  const imgUrl = img('categories/electrisch-gereedschap-3.jpg')
  return { backgroundImage: `linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(0, 0, 0, 1)), url('${imgUrl}')` }
})
</script>

<template>
  <div class="top-bar side-padding black-area">
    <div>
      <span class="font-bold">Iemand spreken over verhuren? </span><span class="font-thin">+31 6 43209314</span>
    </div>
    <div><span class="font-bold">Huren</span> | <span class="font-thin">Verhuren</span></div>
  </div>
  <section class="side-padding font-bold flex orange-area">
    <h1>ShareRental</h1>
    <nav class="flex justify-between items-center w-full py-4">
      <div class="flex justify-start">
        <NuxtLink class="text-base m-4 font-semibold" to="/">Assortiment</NuxtLink>
        <NuxtLink class="text-base m-4 font-semibold" to="/about">Hoe het werkt</NuxtLink>
        <NuxtLink class="text-base m-4 font-semibold" to="/contact">Contact</NuxtLink>
      </div>
      <div class="flex justify-end">
        <NuxtLink to="/register">
          <Button :pt="{ label:  'ml-2' }" icon="pi pi-user"
                  label="Inloggen" text unstyled>
          </Button>
        </NuxtLink>
      </div>
    </nav>
  </section>
  <section class="side-padding orange-area">
    <div class="flex py-40 align-middle justify-center">
      <div class=" w-1/2 justify-center">
        <h1>Vind het beste materiaal voor je project via ShareRental!</h1>
        <div class="flex">
          <input-text unstyled
                      type="text"
                      class="w-3/4 rounded-l-lg"
                      placeholder="Wat heb je nodig?"
                      :pt="{root: {class: 'p-3 w-full font-bold', style: 'outline: none;'}}"
          ></input-text>
          <Button class="w-1/4 rounded-r-lg black-area" label="Zoeken" unstyled/>
        </div>
      </div>
      <div class="w-1/2">
        <NuxtImg src="forklift-transparent-background.png" alt="rental"/>
      </div>
    </div>
  </section>
  <section class="side-padding bg-gray-200 flex justify-between gap-10">
    <span class="m-5 font-bold">
      <i class="pi pi-check"></i>
      Makkelijk en snel huren
    </span>
    <span class="m-5 font-bold">
      <i class="pi pi-check"></i>
      Vergelijk en maak de beste deal
    </span>
    <span class="m-5 font-bold">
      <i class="pi pi-check"></i>
      1000+ producten bij 100+ aanbieders
    </span>
  </section>
  <section>
    <div class="side-padding">
      <h1>Categorieën</h1>
      <div class="grid grid-cols-4 gap-4">
        <div class="rounded-lg relative bg-cover bg-center h-48 w-48" :style="category1Background">
          <span class="absolute bottom-0 left-0 font-bold text-white m-2">Stijgers, trappen en hoogwerkers</span>
        </div>
        <div class="rounded-lg relative bg-cover bg-center h-48 w-48" :style="category2Background">
          <span class="absolute bottom-0 left-0 font-bold text-white m-2">Betonbewerking</span>
        </div>
        <div class="rounded-lg relative bg-cover bg-center h-48 w-48" :style="category3Background">
          <span class="absolute bottom-0 left-0 font-bold text-white m-2">Hef- en hijswerktuigen</span>
        </div>
        <div class="rounded-lg relative bg-cover bg-center h-48 w-48" :style="category4Background">
          <span class="absolute bottom-0 left-0 font-bold text-white m-2">Electrisch gereedschap</span>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.orange-area {
  background-color: #F9AD4D;
  color: #242635;
}

.black-area {
  background-color: #242635;
  color: white;
}

.top-bar {
  padding: 20px 0;
  display: flex;
  justify-content: space-between;
}

@media screen and (min-width: 820px) {
  h1 {
    padding-top: 20px;
    padding-bottom: 20px;
    margin-right: 50px;
    font-size: 2em;
    font-weight: 600;
  }

  .side-padding {
    padding: 0 200px;
  }
}

@media screen and (max-width: 820px) {
  h1 {
    padding-top: 20px;
    padding-bottom: 20px;
    margin-right: 50px;
    font-size: 1.5em;
    font-weight: 600;
  }

  .side-padding {
    padding: 0 50px;
  }
}
</style>