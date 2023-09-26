<template>
  <form-page>
    <template #content>
      Succes! Je hebt zojuist succesvol een reservering geplaatst met ID <span class="font-bold">{{ transaction }}</span>
    </template>
  </form-page>
</template>
<script setup lang="ts">

const route = useRoute()
const router = useRouter()
const transaction = ref(route.query.transaction ? route.query.transaction : '')
</script>