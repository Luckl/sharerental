<template>
  <Head>
    <Title>ShareRental</Title>
  </Head>
  <div class="home-search-container" :style="`background-image: url(${MyBackgroundImage})`">
    <div class="search-input-container">
      <div class="search-input-button-container">
        <Search></Search>
        <div class="button" v-if="!user">
          <NuxtLink to="/register" >
          <Button class="link-button link-button-custom" label="Ik wil mijn gereedschap verhuren" link/>
          </NuxtLink>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import MyBackgroundImage from "@/assets/drill-background.jpg";
import Search from "~/components/Search.vue";
import {useCurrentUser} from "vuefire";

const user = useCurrentUser()
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

useHead({
  htmlAttrs: {
    lang: 'nl'
  },
  link: [
    {
      rel: 'icon',
      type: 'image/ico',
      href: '/favicon.ico'
    }
  ]
})
</script>

<style scoped>
.link-button-custom{
  background-color: rgba(255, 255, 255, 0.63);
  font-weight: bold;
}
.home-search-container {
  background-size: cover;
  height: 25rem;
}
.search-input-button-container{
  background-color: rgba(255, 255, 255, 0.63);
  border-radius: 1rem;
  display: flex;
  align-items: center;
  flex-direction: column;
}
.search-input-container {
  padding-top: 6rem;
  display: flex;
  justify-content: center;
  align-items: center;
}
.button {
  margin: 0.5rem;
}
</style>