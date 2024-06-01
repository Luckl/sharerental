<template>
  <div class="black-area px-2">
    <div class="md:max-w-[1240px] md:mx-auto flex justify-between px-4 md:px-0">
      <div>
        <span class="text-sm font-bold">Iemand spreken over verhuren? </span><span
          class="font-thin"><a href="mailto:info@sharerental.app">info@sharerental.app</a></span>
      </div>
      <div class="hidden md:block"><span class="font-bold">Huren</span> |
        <NuxtLink to="/verhuren"><span class="font-thin">Verhuren</span></NuxtLink>
      </div>
    </div>
  </div>
  <section class=" green-area px-2 md:h-20">
    <div class="w-full md:max-w-[1240px] md:mx-auto font-bold flex p-4 md:px-0">
      <h1 class="mr-5 text-4xl">
        <nuxtLink to="/">ShareRental</nuxtLink>
      </h1>
      <nav class="justify-between items-center w-full hidden md:flex">
        <div class="flex justify-start">
          <NuxtLink class="text-center mr-4 font-semibold" to="/">Assortiment</NuxtLink>
          <NuxtLink v-if="loaded && availableLessors?.length < 1" class="text-center mr-4 font-semibold"
                    to="/#hoe_het_werkt">Hoe
            het werkt
          </NuxtLink>
          <button>
            <a v-if="loaded && availableLessors?.length < 1" class="text-center mr-4 font-semibold"
               @click="showContactDialog()">Contact
            </a>
          </button>
          <NuxtLink v-if="user && loaded && availableLessors?.length > 0" class="text-center mr-4 font-semibold"
                    to="/lessor/items">Artikelen
          </NuxtLink>
          <NuxtLink v-if="user && loaded && availableLessors?.length > 0" class="text-center mr-4 font-semibold"
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
          <Button unstyled name="menu" @click="menuOpened = !menuOpened">
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
        <NuxtLink v-if="user && loaded && availableLessors?.length > 0"
                  class="text-3xl my-3 items-center flex justify-between font-semibold" to="/lessor/items"
                  @click="menuOpened = false">
          <span>Artikelen</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
        <NuxtLink v-if="user && loaded && availableLessors?.length > 0"
                  class="text-3xl my-3 items-center flex justify-between font-semibold" to="/lessor/transactions"
                  @click="menuOpened = false">
          <span>Transacties</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
        <divider v-if="user"></divider>
        <NuxtLink v-if="user"
                  class="text-3xl my-3 items-center flex justify-between font-semibold" to="/"
                  @click="signOut(); menuOpened = false">
          <span>Uitloggen</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
      </div>
    </Sidebar>
  </section>

  <Dialog v-model:visible="showRenterTypeDialog" :close-on-escape="false" :closable="false" :style="{ width: '25rem' }"
          :breakpoints="{ '1199px': '25rem', '575px': '25rem' }" modal>
    <div class="w-full flex flex-col justify-center">
      <span class="text-3xl font-bold text-black text-center">Wat voor klant ben je?</span>
      <span class="text-gray-500 text-center">Je kunt dit later nog aanpassen</span>
      <Button unstyled class="rounded-lg green-area w-full h-12 mt-4" @click="storeRenterType(RenterTypeEnum.Private)">
        Particulier (Incl. BTW)
      </Button>
      <Button unstyled class="rounded-lg border-4 border-green-800 text-green-800 font-bold w-full h-12 mt-4"
              @click="storeRenterType(RenterTypeEnum.Business)">Zakelijk (Excl. BTW)
      </Button>
    </div>
  </Dialog>
</template>
<script setup lang="ts">
import {useUserStore} from "~/services/stores/userStore";
import {reactive, ref} from "vue";
import {useNuxtApp} from "#app";
import {signOut as signOutFirebase} from "@firebase/auth";
import {useFirebaseAuth} from "vuefire";
import type ContactFormClient from "~/services/api/ContactFormClient";
import {useLessorStore} from "~/services/stores/lessorStore";
import {RenterTypeEnum, useRenterTypeStore} from "~/services/stores/renterTypeStore";
import {useDialog} from "primevue/usedialog";
import {SrContactDialog} from "#components";

const router = useRouter();
const userStore = useUserStore();
const {user} = storeToRefs(userStore);
const lessorStore = useLessorStore();
const {availableLessors} = storeToRefs(lessorStore);
const dialog = useDialog();

const renterTypeStore = useRenterTypeStore();

const loaded = ref(false)
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
        loaded.value = true
      })
  if (!renterTypeStore.renterType) {
    showRenterTypeDialog.value = true
  }
})


const showRenterTypeDialog = ref(false);
const contactForm = reactive({
  name: '',
  email: '',
  phone: ''
});

const storeRenterType = (renterType: RenterTypeEnum) => {
  renterTypeStore.setRenterType(renterType)
  showRenterTypeDialog.value = false
}

const showContactDialog = () => {
  dialog.open(SrContactDialog, {})
}

</script>