<template>
  <form-page>
    <template #content>
      Succes! Je hebt zojuist succesvol een reservering geplaatst met referentie <span class="font-bold">{{ transaction }}</span>
      <p>Check je email voor meer informatie</p>
    </template>
  </form-page>
</template>
<script setup lang="ts">

const route = useRoute()
const transaction = ref(route.query.transaction ? route.query.transaction : '')
</script>