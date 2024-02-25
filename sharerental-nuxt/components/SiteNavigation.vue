<template>
  <div class="site-navigation-header-container">
    <div class="m-2">
      <NuxtLink to="/"><img alt="Logo" width="262" height="91" src="../assets/logo-transparent-resized.png"/></NuxtLink>
    </div>
    <div class="desktop-menu">
      <div v-if="user">
        <div class="right-menu">
          <h2 class="desktop-button">Welkom, {{ user.displayName }}</h2>
          <Button class="m-3 desktop-button" label="Menu" icon="pi pi-align-justify" iconPos="right"
                  @click="menuOpened = !menuOpened">
          </Button>
        </div>
      </div>
      <div v-else>
        <div class="right-menu">
          <NuxtLink to="/login">
            <Button class="desktop-button">
              Inloggen
            </Button>
          </NuxtLink>
          <NuxtLink to="/register">
            <Button class="desktop-button">
              Registreren
            </Button>
          </NuxtLink>
        </div>
      </div>
    </div>
    <div class="mobile-menu right-menu">
      <Button class="m-3" icon="pi pi-align-justify" aria-label="Menu" @click="menuOpened = !menuOpened"></Button>
    </div>
  </div>
  <Sidebar v-model:visible="menuOpened" position="right">
    <div v-if="user">
      <NuxtLink to="/lessor/profile">
        <Button @click="menuOpened = false" label="Gegevens" icon="pi pi-building" class="menu-button">
        </Button>
      </NuxtLink>

      <client-only>
        <div v-if="loaded && lessors?.length > 0">
          <NuxtLink to="/lessor/items">
            <Button @click="menuOpened = false" label="Artikelen" icon="pi pi-file-o" class="menu-button">
            </Button>
          </NuxtLink>
          <NuxtLink to="/lessor/transactions">
            <Button @click="menuOpened = false" label="Transacties" icon="pi pi-wallet" class="menu-button">
            </Button>
          </NuxtLink>
        </div>
      </client-only>
      <Button @click="menuOpened = false; signOut(); goToHome()" label="Uitloggen" icon="pi pi-sign-out"
              class="menu-button">
      </Button>
    </div>
    <div v-else>
      <NuxtLink to="/login">
        <Button @click="menuOpened = false" class="menu-button">
          Inloggen
        </Button>
      </NuxtLink>
      <NuxtLink to="/register">
        <Button @click="menuOpened = false" class="menu-button">
          Registreren
        </Button>
      </NuxtLink>
    </div>
  </Sidebar>
</template>

<script setup lang="ts">
import {useFirebaseAuth} from "vuefire";
import {ref} from "vue";
import {useNuxtApp} from "#app";
import {signOut as signOutFirebase} from "firebase/auth";
import LessorClient, {Lessor} from "~/services/api/LessorClient";
import {useUserStore} from "~/services/stores/userStore";

const menuOpened = ref(false);
let userStore = useUserStore();

const user = ref(userStore.user)

userStore.$subscribe((mutation, state) => {
  user.value = state.user
  fetchLessors()
})

async function signOut() {
  await signOutFirebase(auth)
      .then(() => {
        userStore.refreshUser()
        user.value = null
      })
}

const auth = useFirebaseAuth()!
const lessors = ref<Lessor[]>([])
const loaded = ref(false)
const $lessorClient: LessorClient = useNuxtApp().$lessorClient;
const router = useRouter()

const goToHome = function () {
  router.push("/")
}

function fetchLessors() {
  $lessorClient.findAll(0, 20, []).then(success => {
        loaded.value = true;
        lessors.value = success.embedded
      },
      failure => {
        loaded.value = true;
      })
}

onMounted(() => {
      userStore.refreshUser()
      fetchLessors()
})
</script>

<style>


.menu-button {
  width: 100%;
  margin: 0.1rem;
}

.desktop-button {
  margin: 0.4rem;
}

.right-menu {
  display: flex;
  align-items: center;
  padding-right: 1rem;
}

.site-navigation-header-container {
  width: 100%;
  background-color: #e8eef2;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

@media screen and (max-width: 678px) {
  .desktop-menu {
    display: none;
  }
}

@media screen and (min-width: 678px) {
  .mobile-menu {
    display: none;
  }
}
</style>