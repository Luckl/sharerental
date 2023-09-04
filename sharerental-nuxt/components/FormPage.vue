<template>
  <div class="form-container">
  <Card style="width: 100%">
    <template class="header" #header>
      <slot name="header"/>
    </template>
    <template class="content" #content>
      <slot name="content"/>
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

.header {
  padding: 1rem
}

.content {
  padding: 1rem
}
</style>