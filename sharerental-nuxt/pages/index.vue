<template>
  <div class="home-search-container" :style="`background-image: url(${MyBackgroundImage})`">
    <div class="search-input-container">
      <div class="search-input-button-container">
        <Search></Search>
        <div class="button">
          <Button class="link-button" label="Ik wil mijn gereedschap verhuren" link/>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import MyBackgroundImage from "@/assets/drill-background.jpg";
import Search from "~/components/Search.vue";

</script>

<style scoped>
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