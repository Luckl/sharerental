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
  ogImage: '/assets/logo-transparent-with-border.png',
  ogUrl: 'https://sharerental.nl?utm_campaign=social-redirect',
  twitterTitle: 'ShareRental',
  twitterDescription: 'Huur en verhuur jouw machines en gereedschap',
  twitterImage: '/assets/logo-transparent-2.png',
  twitterCard: 'summary'
})
</script>

<style>
html {
  font-family: Roboto, sans-serif;
  height: 100%;
}
</style>
