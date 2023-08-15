<template>
  <Card style="width: 25em">
    <template #header>
      <img class="card-image" alt="Product image" :src="item.image" />
    </template>
    <template #title> {{ item.title }}</template>
    <template #subtitle> {{ item.shortDescription }} </template>
    <template #content>
      <p>
        {{ item.longDescription }}
      </p>
    </template>
  </Card>
</template>

<script lang="ts">
export class RentalItem {
  id: number;
  title: String;
  shortDescription: String | undefined;
  subTitle: String | undefined;
  image: String | undefined;
  pricePerDay: number;

  constructor(id: number,
              name: String,
              subTitle: String | undefined,
              shortDescription: String | undefined,
              imagePath: String | undefined,
              pricePerDay: number) {
    this.id = id;
    this.title = name;
    this.shortDescription = shortDescription;
    this.subTitle = subTitle;
    this.image = imagePath;
    this.pricePerDay = pricePerDay;
  }
}
</script>

<script setup lang="ts">

import {RentalItem} from "~/components/RentalItemCard.vue";

defineProps({
  item: RentalItem
})
</script>

<style scoped>
.card-image {
  width: 100%;
}
</style>