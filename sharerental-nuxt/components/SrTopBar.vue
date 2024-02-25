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
    <div class="w-full md:max-w-[840px] md:mx-auto font-bold flex p-4 md:px-0">
      <h1 class="mr-5 text-4xl"><nuxtLink to="/">ShareRental</nuxtLink></h1>
      <nav class="justify-between items-center w-full hidden md:flex">
        <div class="flex justify-start">
          <NuxtLink class="text-sm mr-2 font-semibold" to="/">Assortiment</NuxtLink>
          <NuxtLink class="text-sm mr-2 font-semibold" to="/#hoe_het_werkt">Hoe het werkt</NuxtLink>
          <NuxtLink class="text-sm font-semibold" to="/contact">Contact</NuxtLink>
        </div>
        <div>
          <slot></slot>
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
        <slot></slot>
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
        <NuxtLink class="text-3xl my-3 items-center flex justify-between font-semibold" to="/#hoe_het_werkt"
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
</template>
<script setup lang="ts">
const menuOpened = ref(false)

</script>