<template>
  <div class="w-full h-20rem p-3 bg-center bg-no-repeat flex flex-column justify-content-center align-items-center"
       :style="`background-image: url(${MyBackgroundImage})`">
    <div>
        <span class="p-input-icon-left ">
          <i class="pi pi-search"/>
          <InputText v-model="searchText" placeholder="Zoek gereedschap" class="border-right-none"/>
          <Button label="Zoeken" v-on:click="search" class="border-left-none"/>
        </span>
    </div>
    <div>
      <Button label="Ik wil mijn gereedschap verhuren" link />
    </div>
  </div>
</template>

<script setup lang="ts">
import MyBackgroundImage from "@/assets/drill-background.jpg";

let searchText = ref("");

function search() {
  console.log(searchText.value);
}
</script>

<style scoped>
</style>