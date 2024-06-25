<script lang="ts" setup>
import { ref} from "vue";

definePageMeta({
  description: 'Gereedschap en machines huren en verhuren',
})

const img = useImage()
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
    const imgUrl = img(image, {width: 400, height: 400})
    return {backgroundImage: `linear-gradient(to bottom, rgba(255, 255, 255, 0), rgba(102, 102, 102, 1)), url('${imgUrl}')`}
  })
}

//TODO: Use category store and make dynamic
const category1Background = categoryBackground('categories/stijgers-trappen-hoogwerkers.jpg')
const category2Background = categoryBackground('categories/Betonbewerking.jpg')
const category3Background = categoryBackground('categories/hef-en-hijswerktuigen.jpg')
const category4Background = categoryBackground('categories/electrisch-gereedschap-3.jpg')
const category5Background = categoryBackground('categories/Evenementen.jpg')
const category6Background = categoryBackground('categories/grondverzetters-bouwmachines-tuinmateriaal.jpg')
const category7Background = categoryBackground('categories/Luchtdrukgereedschap.jpg')
const category8Background = categoryBackground('categories/verwarmen-drogen-reinigen.jpg')

</script>

<template>
  <div>
    <Head>
      <Title>Huren</Title>
    </Head>
    <section class="green-area px-4">
      <div class="md:max-w-[1240px] md:mx-auto">
        <div class="flex py-10 md:py-40 align-middle justify-center">
          <div class="w-full md:w-1/2 justify-center">
            <h1 class="my-10 text-xl md:text-4xl">Vind het beste materiaal voor je project via ShareRental!</h1>
            <SrSearch></SrSearch>
          </div>
          <div class="w-1/2 hidden md:block">
            <NuxtImg src="forklift-transparent-background.png" sizes="620px" alt="rental"/>
          </div>
        </div>
      </div>
    </section>
    <section class="bg-gray-200">
      <div class="md:max-w-[1240px] md:mx-auto flex justify-between gap-2 md:gap-10 md:flex-row flex-col">
        <div class="m-5 font-bold flex items-center">
          <i class="pi pi-check"></i>
          <span class="text-center ml-3">Vind je lokale aanbieder</span>
        </div>
        <div class="m-5 font-bold flex items-center">
          <i class="pi pi-check"></i>
          <span class="text-center ml-3">Altijd de juiste prijs</span>
        </div>
        <div class="m-5 font-bold flex items-center">
          <i class="pi pi-check"></i>
          <span class="text-center ml-3">One-stop-shop voor ieder project</span>
        </div>
      </div>
    </section>
    <section class="px-4">
      <div class="md:max-w-[1240px] md:mx-auto flex flex-col justify-center">
        <h1 class="text-4xl my-5">Categorieën</h1>
        <div class="flex justify-center">
          <div class="w-full grid grid-cols-1 md:grid-cols-4 gap-4">
            <nuxtLink to="/categorieen/stijgers-trappen-hoogwerkers" class="flex justify-center">
              <div class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category1Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Stijgers, trappen en hoogwerkers</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/categorieen/betonbewerking" class="flex justify-center">
              <div class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category2Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Betonbewerking</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/categorieen/hef-hijswerktuigen" class="flex justify-center">
              <div v-if="!categoriesCollapsed || !isSmallScreen"
                   class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category3Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Hef- en hijswerktuigen</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/categorieen/elektrisch-gereedschap" class="flex justify-center">
              <div v-if="!categoriesCollapsed || !isSmallScreen"
                   class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category4Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Electrisch gereedschap</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/categorieen/evenementen" class="flex justify-center">
              <div v-if="!categoriesCollapsed" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48"
                   :style="category5Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Evenementen</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/categorieen/grondverzetters-bouwmachines-tuinmateriaal" class="flex justify-center">
              <div v-if="!categoriesCollapsed" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48"
                   :style="category6Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Grondverzetters, bouwmachines en tuinmateriaal</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/categorieen/luchtdrukgereedschap" class="flex justify-center">
              <div v-if="!categoriesCollapsed" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48"
                   :style="category7Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Luchtdrukgereedschap</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/categorieen/verwarmen-drogen-reinigen" class="flex justify-center">
              <div v-if="!categoriesCollapsed" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48"
                   :style="category8Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Verwarmen, drogen en reinigen</span>
              </div>
            </nuxtLink>
          </div>
        </div>
        <div class="mt-5 flex flex-col justify-center w-full">
          <div class="flex justify-center">
            Toon alle categorieën
          </div>
          <div class="flex justify-center">
            <div v-if="categoriesCollapsed">
              <Button unstyled aria-label="expand menu" @click="categoriesCollapsed = !categoriesCollapsed">
                <i class="pi pi-chevron-down"></i>
              </Button>
            </div>
            <div v-else>
              <Button unstyled aria-label="collapse menu" @click="categoriesCollapsed = !categoriesCollapsed">
                <i class="pi pi-chevron-up"></i>
              </Button>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="green-area px-4 mt-5">
      <div class="md:max-w-[1240px] md:mx-auto">

        <div class="w-full flex justify-center">
          <h1 class="my-10 text-4xl"><a id="hoe_het_werkt">Hoe werkt het?</a></h1>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-2 md:gap-8">
          <div class="flex flex-col m-5 md:m-20 w-80">
            <span class="text-xl font-bold">Zoeken</span>
            <span class="mt-2">Bekijk ons uitgebreide assortiment gereedschap en apparatuur van vertrouwde verhuurbedrijven bij jou in de buurt. Gebruik onze zoekfilters om het perfecte item voor jouw project te vinden, of je het nu voor een dag of een paar weken nodig hebt.</span>
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
              <span class="text-xl font-bold">Vergelijken & Boeken</span>
              <span class="mt-2"> Vergelijk prijzen, beschikbaarheid en verhuurvoorwaarden van meerdere aanbieders om de beste deal te vinden. Zodra je het juiste gereedschap of machine hebt gevonden, boek het dan direct via het platform.</span>
            </div>
          </div>
          <div>
            <div class="flex flex-col m-5 md:m-20 w-80">
              <span class="text-xl font-bold">Huren & Retourneren</span>
              <span class="mt-2">Na het boeken, regel het ophalen van je gehuurde item of laat het bezorgen op jouw locatie. Als je klaar bent, retourneer eenvoudig de apparatuur naar het verhuurbedrijf. Zonder verborgen kosten of verplichtingen.</span>
              <nuxtLink to="/zoeken"><button unstyled class="rounded-lg black-area w-36 h-12 mt-4">Bekijk het aanbod</button></nuxtLink>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="px-4">
      <div class="md:max-w-[1240px] md:mx-auto">
        <div class="grid grid-cols-1 md:grid-cols-2 mt-5">
          <div class="hidden md:block">
            <NuxtImg src="forklift-transparent-background.png" sizes="620px" alt="rental"/>
          </div>
          <div>
            <h3 class="font-bold">Ontdek hoe eenvoudig en voordelig het kan zijn om je volgende project te voltooien met ShareRental. Huur topkwaliteit gereedschap en machines zonder de hoge kosten van aanschaf en onderhoud. Of je nu een doe-het-zelf project hebt, je tuin wilt opknappen of een professionele klus moet klaren, wij hebben alles wat je nodig hebt.</h3>
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
    <SrCtaLessor></SrCtaLessor>
  </div>
</template>

<style scoped>

</style>