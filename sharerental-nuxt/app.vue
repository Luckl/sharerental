<template>
  <nuxt-layout>
    <NuxtPage />
  </nuxt-layout>
</template>

<script setup lang="ts">
useSeoMeta({
  description: 'Huur en verhuur jouw machines en gereedschap',
  ogTitle: 'ShareRental',
  ogDescription: 'Huur en verhuur jouw machines en gereedschap',
  ogImage: '/SR_full_green_white.png',
  ogUrl: 'https://sharerental.nl?utm_campaign=social-redirect',
  twitterTitle: 'ShareRental',
  twitterDescription: 'Huur en verhuur jouw machines en gereedschap',
  twitterImage: '/SR_s_green_white.png',
  twitterCard: 'summary'
})
</script>

<style>
html {
  font-family: Roboto, sans-serif;
  height: 100%;
}
</style>
