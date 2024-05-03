<script lang="ts" setup>
import type ContactFormClient from "~/services/api/ContactFormClient";
import {useUserStore} from "~/services/stores/userStore";
import {reactive, ref} from "vue";
import {useCategoryStore} from "~/services/stores/categoryStore";

definePageMeta({
  description: 'Gereedschap en machines huren en verhuren',
})

const img = useImage()
const router = useRouter();
const categoriesCollapsed = ref(true)

const screenWidth = ref(process.client ? window.innerWidth : 0);
const isSmallScreen = computed(() => screenWidth.value < 768);

/** todo use primevue dialogService  https://primevue.org/dynamicdialog/#example */
const contactFormClient: ContactFormClient = useNuxtApp().$contactFormClient;
const userStore = useUserStore()
const user = ref(userStore.user)

const showInfoDialog = ref(false);
const showRenterTypeDialog = ref(true);
const showThanksDialog = ref(false);
const contactForm = reactive({
  name: '',
  email: '',
  phone: ''
});

const shareContactDetails = () => {
  contactFormClient.sendContactForm({
    name: contactForm.name,
    email: contactForm.email,
    phone: contactForm.phone,
    analyticsToken: user.value?.uid ?? ''
  })

  contactForm.name = ''
  contactForm.email = ''
  contactForm.phone = ''
  showInfoDialog.value = false
  showThanksDialog.value = true
}

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
    <Dialog v-model:visible="showRenterTypeDialog" :close-on-escape="false" :closable="false" :style="{ width: '25rem' }"
            :breakpoints="{ '1199px': '25rem', '575px': '25rem' }" modal>
      <div class="w-full flex flex-col justify-center">
        <span class="text-3xl font-bold text-black text-center">Wat voor klant ben je?</span>
        <span class="text-gray-500 text-center">Je kunt dit later nog aanpassen</span>
        <Button unstyled class="rounded-lg green-area w-full h-12 mt-4" @click="showRenterTypeDialog = false">Particulier (Incl. BTW)</Button>
        <Button unstyled class="rounded-lg border-4 border-green-800 text-green-800 font-bold w-full h-12 mt-4" @click="showRenterTypeDialog = false">Zakelijk (Excl. BTW)</Button>
      </div>
    </Dialog>
    <section class="green-area">
      <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">
        <div class="flex py-40 align-middle justify-center">
          <div class="w-full md:w-1/2 justify-center">
            <h1 class="my-10 text-xl md:text-4xl">Vind het beste materiaal voor je project via ShareRental!</h1>
            <SrSearch></SrSearch>
          </div>
          <div class="w-1/2 hidden md:block">
            <NuxtImg src="forklift-transparent-background.png" alt="rental"/>
          </div>
        </div>
      </div>
    </section>
    <section class="bg-gray-200">
      <div class="md:max-w-[1240px] md:mx-auto flex justify-between gap-2 md:gap-10 px-4 md:px-0 md:flex-row flex-col">
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
    <section>
      <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0 flex flex-col justify-center">
        <h1 class="text-4xl my-5">Categorieën</h1>
        <div class="flex justify-center">
          <div class="w-full grid grid-cols-1 md:grid-cols-4 gap-4">
            <nuxtLink to="/category/stijgers-trappen-hoogwerkers" class="flex justify-center">
              <div class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category1Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Stijgers, trappen en hoogwerkers</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/category/betonbewerking" class="flex justify-center">
              <div class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category2Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Betonbewerking</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/category/hef-hijswerktuigen" class="flex justify-center">
              <div v-if="!categoriesCollapsed || !isSmallScreen"
                   class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category3Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Hef- en hijswerktuigen</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/category/elektrisch-gereedschap" class="flex justify-center">
              <div v-if="!categoriesCollapsed || !isSmallScreen"
                   class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48" :style="category4Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Electrisch gereedschap</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/category/evenementen" class="flex justify-center">
              <div v-if="!categoriesCollapsed" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48"
                   :style="category5Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Evenementen</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/category/grondverzetters-bouwmachines-tuinmateriaal" class="flex justify-center">
              <div v-if="!categoriesCollapsed" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48"
                   :style="category6Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Grondverzetters, bouwmachines en tuinmateriaal</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/category/luchtdrukgereedschap" class="flex justify-center">
              <div v-if="!categoriesCollapsed" class="rounded-lg relative bg-cover bg-center h-48 w-full md:w-48"
                   :style="category7Background">
                <span class="absolute bottom-0 left-0 font-bold text-white m-2">Luchtdrukgereedschap</span>
              </div>
            </nuxtLink>
            <nuxtLink to="/category/verwarmen-drogen-reinigen" class="flex justify-center">
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
      <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">

        <div class="w-full flex justify-center">
          <h1 class="my-10 text-4xl"><a id="hoe_het_werkt">Hoe werkt het?</a></h1>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-2 md:gap-8">
          <div class="flex flex-col m-5 md:m-20 w-80">
            <span class="text-xl font-bold">Zoeken</span>
            <span class="mt-2">Bekijk ons uitgebreide assortiment gereedschap en apparatuur van vertrouwde verhuurbedrijven bij jou in de buurt. Gebruik onze zoekfilters om het perfecte item voor jouw project te vinden, of je het nu voor een paar uur of een paar weken nodig hebt.</span>
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
              <span class="mt-2">Na het boeken, regel het ophalen van je gehuurde item of laat het bezorgen op jouw locatie. Als je klaar bent, retourneer eenvoudig de apparatuur naar het verhuurbedrijf. Je wordt alleen in rekening gebracht voor de daadwerkelijke verhuurperiode, zonder verborgen kosten of verplichtingen.</span>
              <button unstyled class="rounded-lg black-area w-36 h-12 mt-4">Bekijk het aanbod</button>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section>
      <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">
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
      <div class="md:max-w-[1240px] md:mx-auto  px-4 md:px-0">
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
            <div class="mt-10 flex gap-5 mb-5">
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
            <button unstyled class="rounded-lg bg-white text-black font-bold w-36 h-12 mt-4"
                    @click="showInfoDialog = true">Neem contact op
            </button>
          </div>
        </div>
      </div>
    </section>
    <Dialog v-model:visible="showInfoDialog" modal header="Contact" :style="{ width: '50vw' }"
            :breakpoints="{ '1199px': '75vw', '575px': '90vw' }">
      <form @submit.prevent>
        <div class="flex flex-col">
          <span class="p-text-secondary block mb-5">Laat je gegevens achter en we nemen zo snel mogelijk contact met je op</span>
          <label for="name">Naam</label>
          <InputText id="name" v-model="contactForm.name" class="rounded-lg p-2"></InputText>
          <label for="email">Email</label>
          <InputText id="email" v-model="contactForm.email" type="email" class="rounded-lg p-2"></InputText>
          <label for="phone">Telefoon</label>
          <InputText id="phone" v-model="contactForm.phone" class="rounded-lg p-2"></InputText>
          <button unstyled type="submit" class="rounded-lg green-area font-bold w-36 h-12 mt-4" @click="shareContactDetails()">Versturen</button>
        </div>
      </form>
    </Dialog>
    <Dialog v-model:visible="showThanksDialog" modal header="Bedankt!" :style="{ width: '50vw' }"
            :breakpoints="{ '1199px': '75vw', '575px': '90vw' }">
      <div class="flex flex-col">
        <span class="p-text-secondary block mb-5">Bedankt! We nemen zo snel mogelijk contact met je op.</span>
        <button type="submit" unstyled class="rounded-lg green-area font-bold w-36 h-12 mt-4" @click="showThanksDialog = false">Sluiten</button>
      </div>
    </Dialog>
  </div>
</template>

<style scoped>

</style>