<template>
  <nuxt-layout>
    <NuxtPage />
  </nuxt-layout>
</template>

<script setup lang="ts">
import {useCurrentUser} from "vuefire";

const user = useCurrentUser()
</script>

<style>

</style>
