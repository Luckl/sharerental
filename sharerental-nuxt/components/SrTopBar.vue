<template>
  <div class="black-area">
    <div class="md:max-w-[1240px] md:mx-auto flex justify-between px-4 md:px-0">
      <div>
        <span class="text-sm font-bold">Iemand spreken over verhuren? </span><span
          class="font-thin">+31 6 43209314</span>
      </div>
      <div class="hidden md:block"><span class="font-bold">Huren</span> | <span class="font-thin">Verhuren</span></div>
    </div>
  </div>
  <section class=" green-area">
    <div class="w-full md:max-w-[1240px] md:mx-auto font-bold flex p-4 md:px-0">
      <h1 class="mr-5 text-4xl">
        <nuxtLink to="/">ShareRental</nuxtLink>
      </h1>
      <nav class="justify-between items-center w-full hidden md:flex">
        <div class="flex justify-start">
          <NuxtLink class="text-center mr-4 font-semibold" to="/">Assortiment</NuxtLink>
          <NuxtLink class="text-center mr-4 font-semibold" to="/#hoe_het_werkt">Hoe het werkt</NuxtLink>
          <NuxtLink class="text-center mr-4 font-semibold" to="/">Contact</NuxtLink>
        </div>
        <div class="w-1/2">
          <slot></slot>
        </div>
        <div class="flex justify-end">
          <NuxtLink @click="clickAccountBtn()">
            <Button :pt="{ label:  'ml-2' }" icon="pi pi-user"
                    :label="accountBtnText"  text unstyled>
            </Button>
          </NuxtLink>
        </div>
      </nav>
      <nav class="flex md:hidden w-full">
        <div class="flex w-full justify-end items-center gap-2">
          <NuxtLink @click="clickAccountBtn()">
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
        <NuxtLink class="text-3xl my-3 items-center flex justify-between font-semibold" to="/">
          <span>Assortiment</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
        <NuxtLink class="text-3xl my-3 items-center flex justify-between font-semibold" to="/#hoe_het_werkt"
                  @click="menuOpened = false">
          <span>Hoe het werkt</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
        <NuxtLink class="text-3xl my-3 items-center flex justify-between font-semibold" to="/">
          <span>Contact</span>
          <i class="pi pi-angle-right" style="font-size: 2rem"></i>
        </NuxtLink>
      </div>
    </Sidebar>
  </section>
</template>
<script setup lang="ts">
import {useUserStore} from "~/services/stores/userStore";
import {ref} from "vue";

const router = useRouter();
let userStore = useUserStore();

const user = ref(userStore.user)
const menuOpened = ref(false)

const accountBtnText = computed(() => {
  if (user.value) {
    return user.value.displayName
  }
  return "Inloggen"
})

userStore.$subscribe((mutation, state) => {
  user.value = state.user
})

const clickAccountBtn = () => {
  if (user.value) {
    router.push('/lessor/items')
  } else {
    router.push('/login')
  }
}

</script>