<template>
  <div class="home-search-container" :style="`background-image: url(${MyBackgroundImage})`">
    <div class="search-input-container">
      <div class="search-input-button-container">
        <span class="p-input-icon-left button">
          <i class="pi pi-search"/>
          <InputText v-model="searchText" placeholder="Zoek gereedschap" class="border-right-none"/>
          <Button label="Zoeken" v-on:click="search" class="border-left-none"/>
        </span>
        <div class="button">
          <Button class="link-button" label="Ik wil mijn gereedschap verhuren" link/>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import MyBackgroundImage from "@/assets/drill-background.jpg";
import {useRouter} from "#app";
import {ref} from "vue";

const router = useRouter();
let searchText = ref("")

function search() {
  router.push("/search/" + searchText.value)
}
</script>

<style scoped>
.home-search-container {
  background-size: cover;
  height: 20rem;
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