<script setup lang="ts">

import {SrContactDialog} from "#components";

import {useDialog} from "primevue/usedialog";

const dialog = useDialog()

const showContactDialog = () => {
  dialog.open(SrContactDialog, {
    header: 'Contact',
    style: {width: '50vw'},
    breakpoints: {'1199px': '75vw', '575px': '90vw'}
  })
}

</script>
<template>
  <section class="green-area mt-5 pt-10">
    <div class="md:max-w-[1240px] md:mx-auto  px-4 md:px-0">
      <div class="grid grid-cols-1 md:grid-cols-2 mt-5">
        <div>
          <div class="grid grid-cols-2 ">
            <span class="font-bold">Over ShareRental</span>
            <span class="font-bold">Verhuren</span>
            <NuxtLink to="/#hoe_het_werkt">
              <span class="my-1 text-sm">Hoe het werkt</span>
            </NuxtLink>
            <NuxtLink to="/verhuren/#hoe_het_werkt">
              <span class="my-1 text-sm">Zo werkt het</span>
            </NuxtLink>
            <span class="my-1 text-sm">Over ons</span>
            <a href="mailto:support@sharerental.app">
              <span class="my-1 text-sm">Service</span>
            </a>
            <span class="my-1 text-sm">Nieuwsbrief</span>
            <span class="my-1 text-sm"></span>
            <span class="my-1 text-sm"><button @click="showContactDialog()">Contact</button></span>
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
                  @click="showContactDialog()">Neem contact op
          </button>
        </div>
      </div>
    </div>
  </section>
</template>