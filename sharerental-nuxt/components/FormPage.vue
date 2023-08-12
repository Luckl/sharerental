<template>
  <div class="form-container">
  <Card style="width: 100%">
    <template #content>
      <slot/>
    </template>
  </card>
  </div>
</template>

<script setup lang="ts">

</script>

<style>
.form-container {
  padding-left: 10%;
  padding-right: 10%;
  padding-top: 5em;
  height: 100%;
}
</style>