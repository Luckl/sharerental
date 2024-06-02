<template>
  <nuxt-layout>
    <DynamicDialog />
    <NuxtPage />
  </nuxt-layout>
</template>

<script setup lang="ts">
import {setLocale} from "yup";
import {nl} from "yup-locales";
import type {SrRenterInformationForm} from "#components";

const renterInformationForm = ref<InstanceType<typeof SrRenterInformationForm> | null>(null)

const createUserIfSelected = () => {
  renterInformationForm.value?.createUserIfSelected()
}

useSeoMeta({
  description: 'Huur en verhuur jouw machines en gereedschap',
  ogTitle: 'ShareRental',
  ogDescription: 'Huur en verhuur jouw machines en gereedschap',
  ogImage: '/SR_full_green_white_opengraph_sizing.png',
  ogImageWidth: '2580',
  ogImageHeight: '540',
  ogUrl: 'https://sharerental.nl?utm_campaign=social-redirect',
  twitterTitle: 'ShareRental',
  twitterDescription: 'Huur en verhuur jouw machines en gereedschap',
  twitterImage: '/SR_full_green_white_opengraph_sizing.png',
  twitterCard: 'summary'
})

setLocale(nl)
</script>

<style>
html, body {
  font-family: Roboto, sans-serif;
  height: 100%;
}
</style>
