<script lang="ts" setup>
import type ContactFormClient from "~/services/api/ContactFormClient";
import {useUserStore} from "~/services/stores/userStore";
import {reactive, ref} from "vue";

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
</script>

<template>
  <div>
    <Head>
      <Title>Verhuren</Title>
    </Head>
    <section class="bg-gray-200">
      <div class="md:max-w-[1240px] md:mx-auto flex justify-between gap-2 md:gap-10 px-4 md:px-0 md:flex-row flex-col">
        <div class="m-5 font-bold flex items-center">
          <i class="pi pi-check"></i>
          <span class="text-center text-2xl ml-3">Vergroot je online bereik</span>
        </div>
        <div class="m-5 font-bold flex items-center">
          <i class="pi pi-check"></i>
          <span class="text-center text-2xl ml-3">Verminder administratieve lasten</span>
        </div>
        <div class="m-5 font-bold flex items-center">
          <i class="pi pi-check"></i>
          <span class="text-center text-2xl ml-3">Versnel je afhandelingsproces</span>
        </div>
      </div>
    </section>
    <section class="green-area">
      <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">
        <div class="flex py-40 align-middle justify-center">
          <div class="flex flex-col w-full md:w-1/2 justify-center">
            <h1 class="my-10 font-extrabold text-4xl md:text-4xl">ShareRental</h1>
            <span class="my-10 text-xl">Hét nieuwe online machineverhuurplatform. Registreer je nu en begin vandaag nog met verhuren.</span>
            <NuxtLink to="/register">
              <Button unstyled class="rounded-lg bg-white font-bold text-black w-36 h-12 mt-4">Gratis registreren</Button>
            </NuxtLink>
          </div>
          <div class="w-1/2 hidden md:block">
            <NuxtImg src="forklift-transparent-background.png" alt="rental"/>
          </div>
        </div>
      </div>
    </section>
    <section class="bg-white mt-5">
      <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">

        <div class="w-full flex justify-center">
          <h1 class="my-10 text-4xl"><a id="hoe_het_werkt">Hoe werkt het?</a></h1>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-2 md:gap-8">
          <div class="flex flex-col m-5 md:m-20 w-80">
            <span class="text-xl font-bold">Registreren</span>
            <span class="mt-2">Maak een account aan via de registratie pagina</span>
          </div>
          <div class="flex flex-col m-5 md:m-20 w-80 hidden md:block">
            <NuxtImg src="1.png" height="200" alt="rental"/>
          </div>
          <div>
            <div class="flex flex-col m-5 md:m-20 w-80 hidden md:block">
              <NuxtImg src="2.png" height="200" alt="rental"/>
            </div>
          </div>
          <div>
            <div class="flex flex-col m-5 md:m-20 w-80">
              <span class="text-xl font-bold">Artikelen toevoegen</span>
              <span class="mt-2"> Maak artikelen aan die je wilt verhuren via het platform</span>
            </div>
          </div>
          <div>
            <div class="flex flex-col m-5 md:m-20 w-80">
              <span class="text-xl font-bold">Verhuren</span>
              <span class="mt-2">Begin meteen met verhuren!</span>
            </div>
          </div>

          <div>
            <div class="flex flex-col m-5 md:m-20 w-80 hidden md:block">
              <NuxtImg src="3.png" height="200" alt="rental"/>
            </div>
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
          <button unstyled type="submit" class="rounded-lg green-area font-bold w-36 h-12 mt-4"
                  @click="shareContactDetails()">Versturen
          </button>
        </div>
      </form>
    </Dialog>
    <Dialog v-model:visible="showThanksDialog" modal header="Bedankt!" :style="{ width: '50vw' }"
            :breakpoints="{ '1199px': '75vw', '575px': '90vw' }">
      <div class="flex flex-col">
        <span class="p-text-secondary block mb-5">Bedankt! We nemen zo snel mogelijk contact met je op.</span>
        <button type="submit" unstyled class="rounded-lg green-area font-bold w-36 h-12 mt-4"
                @click="showThanksDialog = false">Sluiten
        </button>
      </div>
    </Dialog>
  </div>
</template>

<style scoped>

</style>