<template>
  <Card class="m-1 p-1">
    <template #header class="m-1">
      <h2>Profiel</h2>
    </template>
    <template #content class="m-1">
      Welkom, {{ username }}
    </template>
  </Card>
</template>
<script setup lang="ts">

import {useAsyncData, useNuxtApp} from "#app";
import RenterClient from "~/services/api/Renter";

let user = useCurrentUser();
const username = user.value?.displayName

const { $lessorClient } = useNuxtApp();
const pageable = {
  page: 0,
  pageSize: 20,
  sort: []
}

const result = await useAsyncData('findRenters', async () => {
  return await $lessorClient.findAll(pageable);
})

debugger;

</script>
<style>
.m-1 {
  margin: 1rem
}
.p-1 {
  padding: 1rem
}
</style>