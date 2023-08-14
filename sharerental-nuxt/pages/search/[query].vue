<template>
  <div class="results">
    <RentalItemCard :item="rentalItem"/>
    <RentalItemCard :item="rentalItem"/>
    <RentalItemCard :item="rentalItem"/>
    <RentalItemCard :item="rentalItem"/>
    <RentalItemCard :item="rentalItem"/>
    <RentalItemCard :item="rentalItem"/>
    <RentalItemCard :item="rentalItem"/>
    <RentalItemCard :item="rentalItem"/>
    <RentalItemCard :item="rentalItem"/>
  </div>
  token: {{ token }}
</template>

<script setup lang="ts">
import RentalItemCard, {RentalItem} from "~/components/RentalItemCard.vue";
import {ref} from "vue";
import {useRoute} from "#app";
import {useCurrentUser} from "vuefire";

let route = useRoute();
const {query} = route.params;
const user = useCurrentUser();
const rentalItem = new RentalItem("1", Array.isArray(query) ? query[0] : query, "ondertitel", "dit is echt vet man", "/assets/primevue-logo.png");

user.value?.getIdToken()
    .then((result) => {
      token.value = result
    });
// Search here

const token = ref();
const value = ref();
</script>

<style scoped>
.results {
  justify-content: center;
  padding: 1rem;
  display: flex;
  flex-wrap: wrap;
  gap: 5rem;
}

@media screen and (max-width: 678px) {

}


@media screen and (min-width: 678px) {

}
</style>