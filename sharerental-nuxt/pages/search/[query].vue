<template>
  <div>
    <h1>you searched for {{ $route.params.query }}</h1>
  </div>
  <div class="results">
    <RentalItemCard />
    <RentalItemCard />
    <RentalItemCard />
    <RentalItemCard />
    <RentalItemCard />
    <RentalItemCard />
    <RentalItemCard />
    <RentalItemCard />
    <RentalItemCard />
  </div>
</template>

<script setup lang="ts">

import RentalItemCard from "~/components/RentalItemCard.vue";

</script>

<style scoped>
.results {
  padding: 1rem;
  display: flex;
  flex-wrap: wrap;
  gap:5rem;
}

@media screen and (max-width: 678px) {

}


@media screen and (min-width: 678px) {

}
</style>