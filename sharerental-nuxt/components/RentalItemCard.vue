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
  id: String;
  title: String;
  shortDescription: String | null;
  longDescription: String;
  image: String;

  constructor(id: String, name: String, shortDescription: String | null, longDescription: String, imagePath: String) {
    this.id = id;
    this.title = name;
    this.shortDescription = shortDescription;
    this.longDescription = longDescription;
    this.image = imagePath;
  }
}
</script>

<script setup lang="ts">

defineProps({
  item: RentalItem
})
</script>

<style scoped>
.card-image {
  width: 100%;
}
</style>