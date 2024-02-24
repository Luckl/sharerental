<script lang="ts" setup>

import menu from "primevue/menu/Menu.vue";

definePageMeta({
  title: 'ShareRental - Home',
  description: 'New layout',
  layout: 'new'
})
const img = useImage()
const router = useRouter();
const searchText = ref("")
const menuOpened = ref(false)
const categoriesCollapsed = ref(true)

const screenWidth = ref(process.client ? window.innerWidth : 0);

const isSmallScreen = computed(() => screenWidth.value < 768);

const handleResize = () => {
  screenWidth.value = window.innerWidth;
};

onMounted(() => {
  window.addEventListener('resize', handleResize);
});

onBeforeUnmount(() => {
  window.removeEventListener('resize', handleResize);
});

const categoryBackground = (image: string) => {
  return computed(() => {
    const imgUrl = img(image)
    return {backgroundImage: `linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(102, 102, 102, 1)), url('${imgUrl}')`}
  })
}

function search() {
  router.push("/search/" + searchText.value)
}

const category1Background = categoryBackground('categories/stijgers-trappen-hoogwerkers.jpg')
const category2Background = categoryBackground('categories/Betonbewerking.jpg')
const category3Background = categoryBackground('categories/hef-en-hijswerktuigen.jpg')
const category4Background = categoryBackground('categories/electrisch-gereedschap-3.jpg')
const category5Background = categoryBackground('categories/Evenementen.jpg')
const category6Background = categoryBackground('categories/grondverzetters-bouwmachines-tuinmateriaal.jpg')
const category7Background = categoryBackground('categories/Luchtdrukgereedschap.jpg')
const category8Background = categoryBackground('categories/verwarmen-drogen-reinigen.jpg')

function test() {
  console.log(categoriesCollapsed.value)
}
</script>

<template>
  <div class="black-area">
    <div class="md:max-w-[840px] md:mx-auto flex justify-between px-4 md:px-0">
      <div>
        <span class="text-sm font-bold">Iemand spreken over verhuren? </span><span
          class="font-thin">+31 6 43209314</span>
      </div>
      <div class="hidden md:block"><span class="font-bold">Huren</span> | <span class="font-thin">Verhuren</span></div>
    </div>
  </div>
  <section class=" green-area">
    <div class="w-full md:max-w-[840px] md:mx-auto font-bold flex pt-5 px-4 md:px-0">
      <h1 class="mr-5 text-4xl">ShareRental</h1>
      <nav class="justify-between items-center w-full hidden md:flex">
        <div class="flex justify-start">
          <NuxtLink class="text-base mr-5 font-semibold" to="/">Assortiment</NuxtLink>
          <NuxtLink class="text-base mr-5 font-semibold" to="#hoe_het_werkt">Hoe het werkt</NuxtLink>
          <NuxtLink class="text-base mr-5 font-semibold" to="/contact">Contact</NuxtLink>
        </div>
        <div class="flex justify-end">
          <NuxtLink to="/register">
            <Button :pt="{ label:  'ml-2' }" icon="pi pi-user"
                    label="Inloggen" text unstyled>
            </Button>
          </NuxtLink>
        </div>
      </nav>
      <nav class="flex md:hidden w-full">
        <div class="flex w-full justify-end items-center gap-2">
          <NuxtLink to="/register">
            <i class="pi pi-user" style="font-size: 1.5rem">
            </i>
          </NuxtLink>
          <Button unstyled @click="menuOpened = !menuOpened">
            <i class="pi pi-bars" style="font-size: 2rem">
            </i>
          </Button>
        </div>
      </nav>
    </div>
    <Sidebar v-model:visible="menuOpened" position="right">
      <template #header>
        <h1 class="text-4xl">ShareRental</h1>
      </template>
      <div class="grid grid-cols-1">
        <NuxtLink class="text-3xl my-3 items-center flex justify-between font-semibold" to="/">
          <span>Assortiment</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
        <NuxtLink class="text-3xl my-3 items-center flex justify-between font-semibold" to="#hoe_het_werkt"
                  @click="menuOpened = false">
          <span>Hoe het werkt</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
        <NuxtLink class="text-3xl my-3 items-center flex justify-between font-semibold" to="/contact">
          <span>Contact</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
      </div>
    </Sidebar>
  </section>
  <section class="green-area">
    <div class="md:max-w-[840px] md:mx-auto px-4 md:px-0">
      <div class="flex py-40 align-middle justify-center">
        <div class="w-full md:w-1/2 justify-center">
          <h1 class="my-10 text-xl md:text-4xl">Vind het beste materiaal voor je project via ShareRental!</h1>
          <div class="flex">
            <input-text unstyled
                        type="text"
                        class="w-3/4 rounded-l-lg"
                        placeholder="Wat heb je nodig?"
                        v-model="searchText"
                        :pt="{root: {class: 'p-3 w-full font-bold text-black', style: 'outline: none;'}}"
            ></input-text>
            <Button class="w-1/4 rounded-r-lg black-area" label="Zoeken" @click="search()" unstyled/>
          </div>
        </div>
        <div class="w-1/2 hidden md:block">
          <NuxtImg src="forklift-transparent-background.png" alt="rental"/>
        </div>
      </div>
    </div>
  </section>
  <section class="side-padding bg-gray-200">
    <div class="md:max-w-[840px] md:mx-auto flex justify-between gap-2 md:gap-10 px-4 md:px-0 md:flex-row flex-col">
      <div class="m-5 font-bold flex items-center">
        <i class="pi pi-check"></i>
        <span class="text-center">Makkelijk en snel huren</span>
      </div>
      <div class="m-5 font-bold flex items-center">
        <i class="pi pi-check"></i>
        <span class="text-center">Vergelijk en maak de beste deal</span>
      </div>
      <div class="m-5 font-bold flex items-center">
        <i class="pi pi-check"></i>
        <span class="text-center">1000+ producten bij 100+ aanbieders</span>
      </div>
    </div>
  </section>
  <section>
    <div class="md:max-w-[840px] md:mx-auto  px-4 md:px-0">
      <h1 class="text-4xl my-5">Categorieën</h1>
      <div class="grid grid-cols-1 md:grid-cols-4 gap-4">
        <div class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category1Background">
          <span class="absolute bottom-0 left-0 font-bold text-white m-2">Stijgers, trappen en hoogwerkers</span>
        </div>
        <div class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category2Background">
          <span class="absolute bottom-0 left-0 font-bold text-white m-2">Betonbewerking</span>
        </div>
        <div v-if="!categoriesCollapsed || !isSmallScreen" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category3Background">
          <span class="absolute bottom-0 left-0 font-bold text-white m-2">Hef- en hijswerktuigen</span>
        </div>
        <div  v-if="!categoriesCollapsed || !isSmallScreen" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category4Background">
          <span class="absolute bottom-0 left-0 font-bold text-white m-2">Electrisch gereedschap</span>
        </div>
        <div  v-if="!categoriesCollapsed" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category5Background">
          <span class="absolute bottom-0 left-0 font-bold text-white m-2">Evenementen</span>
        </div>
        <div  v-if="!categoriesCollapsed" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category6Background">
          <span class="absolute bottom-0 left-0 font-bold text-white m-2">Grondverzetters, bouwmachines en tuinmateriaal</span>
        </div>
        <div  v-if="!categoriesCollapsed" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category7Background">
          <span class="absolute bottom-0 left-0 font-bold text-white m-2">Luchtdrukgereedschap</span>
        </div>
        <div  v-if="!categoriesCollapsed" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category8Background">
          <span class="absolute bottom-0 left-0 font-bold text-white m-2">Verwarmen, drogen en reinigen</span>
        </div>
      </div>
      <div class="mt-5 flex flex-col justify-center w-full">
        <div class="flex justify-center">
          Toon alle categorieën
        </div>
        <div class="flex justify-center">
          <div v-if="categoriesCollapsed">
            <Button unstyled @click="categoriesCollapsed = !categoriesCollapsed">
              <i class="pi pi-chevron-down"></i>
            </Button>
          </div>
          <div v-else>
            <Button unstyled @click="categoriesCollapsed = !categoriesCollapsed">
              <i class="pi pi-chevron-up"></i>
            </Button>
          </div>
        </div>
      </div>
    </div>
  </section>
  <section class="green-area mt-5">
    <div class="md:max-w-[840px] md:mx-auto px-4 md:px-0">

      <div class="w-full flex justify-center">
        <h1 class="my-10 text-4xl"><a id="hoe_het_werkt">Hoe werkt het?</a></h1>
      </div>
      <div class="grid grid-cols-1 md:grid-cols-2 gap-2 md:gap-8">
        <div class="flex flex-col m-5 md:m-20 w-80">
          <span class="text-xl font-bold">Ga op zoek naar wat jij nodig hebt</span>
          <span class="mt-2">Afhankelijk van je regio, het type toestel en de huurperiode selecteren
        wij voor jou automatisch de beste verhuurpartners. Je krijgt onmiddelijk een
        prijs te zien en kunt het toestel reserveren. Verlengen en annuleren is altijd
        mogelijk. </span>
        </div>
        <div class="flex flex-col m-5 md:m-20 w-80 hidden md:block">
          <span class="text-xl font-bold">Image</span>
          <span class="mt-2"></span>
        </div>
        <div>
          <div class="flex flex-col m-5 md:m-20 w-80 hidden md:block">
            <span class="text-xl font-bold">Image</span>
            <span class="mt-2"></span>
          </div>
        </div>
        <div>
          <div class="flex flex-col m-5 md:m-20 w-80">
            <span class="text-xl font-bold">Vergelijk verschillende aanbieders</span>
            <span class="mt-2">Lorem ipsum dolor sit amet, consectetur adipiscing elit,
            sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
            ut aliquip ex ea commodo consequat.</span>
          </div>
        </div>
        <div>
          <div class="flex flex-col m-5 md:m-20 w-80">
            <span class="text-xl font-bold">En dan kan je nu gaan huren</span>
            <span class="mt-2">Lorem ipsum dolor sit amet, consectetur adipiscing elit,
            sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.
            Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi
            ut aliquip ex ea commodo consequat.</span>
            <button unstyled class="rounded-lg black-area w-36 h-12 mt-4">Bekijk het aanbod</button>
          </div>
        </div>
      </div>
    </div>
  </section>
  <section>
    <div class="md:max-w-[840px] md:mx-auto px-4 md:px-0">
      <div class="grid grid-cols-1 md:grid-cols-2 mt-5">
        <div class="hidden md:block">
          <NuxtImg src="forklift-transparent-background.png" alt="rental"/>
        </div>
        <div>
          <h3 class="font-bold">Registreer nu!</h3>
          <h1 class="my-10 text-3xl">Huur vandaag nog alles voor je volgende project!</h1>
          <NuxtLink to="/register">
            <button unstyled class="rounded-lg black-area p-3 h-12 mr-8">Gratis registreren</button>
          </NuxtLink>
          <NuxtLink to="/login">
            <button unstyled class="rounded-lg black-area p-3 h-12">Inloggen</button>
          </NuxtLink>
        </div>
      </div>
    </div>
  </section>
  <section class="green-area mt-5 pt-10">
    <div class="md:max-w-[840px] md:mx-auto  px-4 md:px-0">
      <div class="grid grid-cols-1 md:grid-cols-2 mt-5">
        <div>
          <div class="grid grid-cols-2 ">
            <span class="font-bold">Over ShareRental</span>
            <span class="font-bold">Verhuren</span>
            <span class="my-1 text-sm">Hoe het werkt</span>
            <span class="my-1 text-sm">Zo werkt het</span>
            <span class="my-1 text-sm">FAQ</span>
            <span class="my-1 text-sm">Veelgestelde vragen</span>
            <span class="my-1 text-sm">Over ons</span>
            <span class="my-1 text-sm">Service</span>
            <span class="my-1 text-sm">Nieuwsbrief</span>
            <span class="my-1 text-sm"></span>
            <span class="my-1 text-sm">Contact</span>
          </div>
          <div class="mt-10 flex gap-5">
            <i class="pi pi-facebook" style="font-size: 2rem"></i>
            <i class="pi pi-instagram" style="font-size: 2rem"></i>
            <i class="pi pi-linkedin" style="font-size: 2rem"></i>
          </div>
        </div>
        <div class="flex flex-col mb-20 order-first md:order-last">
          <h1 class="text-xl md:text-4xl">Direct beginnen met verhuren?</h1>
          <span class="mt-1">Ben je op zoek naar een extra verkoopkanaal?</span>
          <span>Ben je benieuwd naar alle opties een mogelijkheden voor samenwerking binnen het ShareRental platform?</span>
          <span>Neem dan direct gratis contact op!</span>
          <button unstyled class="rounded-lg bg-white text-black font-bold w-36 h-12 mt-4">Neem contact op</button>
        </div>
      </div>
    </div>
  </section>
</template>

<style scoped>
.green-area {
  background-color: #004E1B;
  color: white;
}

.black-area {
  background-color: #242635;
  color: white;
}
</style>