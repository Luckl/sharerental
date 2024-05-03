<template>
  <div class="black-area">
    <div class="md:max-w-[1240px] md:mx-auto flex justify-between px-4 md:px-0">
      <div>
        <span class="text-sm font-bold">Iemand spreken over verhuren? </span><span
          class="font-thin"><a href="mailto:info@sharerental.app">info@sharerental.app</a></span>
      </div>
      <div class="hidden md:block"><span class="font-bold">Huren</span> | <NuxtLink to="/verhuren"><span class="font-thin">Verhuren</span></NuxtLink></div>
    </div>
  </div>
  <section class=" green-area md:h-20">
    <div class="w-full md:max-w-[1240px] md:mx-auto font-bold flex p-4 md:px-0">
      <h1 class="mr-5 text-4xl">
        <nuxtLink to="/">ShareRental</nuxtLink>
      </h1>
      <nav class="justify-between items-center w-full hidden md:flex">
        <div class="flex justify-start">
          <NuxtLink class="text-center mr-4 font-semibold" to="/">Assortiment</NuxtLink>
          <NuxtLink v-if="loaded && lessors?.length < 1" class="text-center mr-4 font-semibold" to="/#hoe_het_werkt">Hoe
            het werkt
          </NuxtLink>
          <a v-if="loaded && lessors?.length < 1" class="text-center mr-4 font-semibold" @click="showInfoDialog = true">Contact
          </a>
          <NuxtLink v-if="user && loaded && lessors?.length > 0" class="text-center mr-4 font-semibold"
                    to="/lessor/items">Artikelen
          </NuxtLink>
          <NuxtLink v-if="user && loaded && lessors?.length > 0" class="text-center mr-4 font-semibold"
                    to="/lessor/transactions">Transacties
          </NuxtLink>
        </div>
        <div class="w-1/2">
          <slot></slot>
        </div>
        <div class="flex justify-end">
          <NuxtLink :to="accountButtonLink">
            <Button :pt="{ label:  'ml-2' }" icon="pi pi-user"
                    :label="accountBtnText" text unstyled>
            </Button>
          </NuxtLink>
        </div>
      </nav>
      <nav class="flex md:hidden w-full">
        <div class="flex w-full justify-end items-center gap-2">
          <NuxtLink :to="accountButtonLink">
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
    <div class="p-5 w-full block md:hidden">
      <slot></slot>
    </div>
    <Sidebar v-model:visible="menuOpened" position="right">
      <template #header>
        <h1 class="text-4xl">ShareRental</h1>
      </template>
      <div class="grid grid-cols-1">
        <NuxtLink class="text-3xl my-3 items-center flex justify-between font-semibold" to="/"
                  @click="menuOpened = false">
          <span>Assortiment</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
        <NuxtLink class="text-3xl my-3 items-center flex justify-between font-semibold" to="/#hoe_het_werkt"
                  @click="menuOpened = false">
          <span>Hoe het werkt</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
        <NuxtLink class="text-3xl my-3 items-center flex justify-between font-semibold" to="/"
                  @click="menuOpened = false">
          <span>Contact</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
        <divider v-if="user"></divider>
        <NuxtLink v-if="user" class="text-3xl my-3 items-center flex justify-between font-semibold"
                  to="/lessor/profile" @click="menuOpened = false">
          <span>Gegevens</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
        <NuxtLink v-if="user && loaded && lessors?.length > 0"
                  class="text-3xl my-3 items-center flex justify-between font-semibold" to="/lessor/items"
                  @click="menuOpened = false">
          <span>Artikelen</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
        <NuxtLink v-if="user && loaded && lessors?.length > 0"
                  class="text-3xl my-3 items-center flex justify-between font-semibold" to="/lessor/transactions"
                  @click="menuOpened = false">
          <span>Transacties</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
        <divider v-if="user"></divider>
        <NuxtLink v-if="user"
                  class="text-3xl my-3 items-center flex justify-between font-semibold" to="/" @click="signOut(); menuOpened = false">
          <span>Uitloggen</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
      </div>
    </Sidebar>
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
</template>
<script setup lang="ts">
import {useUserStore} from "~/services/stores/userStore";
import {reactive, ref} from "vue";
import LessorClient from "~/services/api/LessorClient";
import {useNuxtApp} from "#app";
import type {Lessor} from "~/schemas/openapi/sharerental";
import {signOut as signOutFirebase} from "@firebase/auth";
import {useFirebaseAuth} from "vuefire";
import type ContactFormClient from "~/services/api/ContactFormClient";
import {useLessorStore} from "~/services/stores/lessorStore";


const router = useRouter();
const userStore = useUserStore();
const lessorStore = useLessorStore();

const lessors = ref<Lessor[]>([])
const loaded = ref(false)
const user = ref(userStore.user)
const menuOpened = ref(false)
const auth = useFirebaseAuth()!

const accountBtnText = computed(() => {
  if (user.value) {
    return "Account"
  }
  return "Inloggen"
})

async function signOut() {
  await signOutFirebase(auth)
      .then(() => {
        userStore.refreshUser()
        user.value = null
      })
}

userStore.$subscribe((mutation, state) => {
  user.value = state.user
})

lessorStore.$subscribe((mutation, state) => {
  lessors.value = state.availableLessors
})

const accountButtonLink = computed(() => {
  if (user.value) {
    return '/lessor/profile'
  } else {
    return '/login'
  }
})

onMounted(() => {
  userStore.refreshUser()
  lessorStore.loadLessors()
      .then(() => {
        lessors.value = lessorStore.availableLessors
        loaded.value = true
      })
})

const contactFormClient: ContactFormClient = useNuxtApp().$contactFormClient;

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

</script>