<template>
  <div class="form-container">
  <Card style="width: 100%">
    <template class="header" #header>
      <h1>
        <slot name="header"/>
      </h1>
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


@media screen and (max-width: 678px) {
  .form-container {
    padding-top: 2em;
    height: 100%;
  }
}
@media screen and (min-width: 678px) {
  .form-container {
    padding-left: 10%;
    padding-right: 10%;
    padding-top: 5em;
    height: 100%;
  }
}

.header {
  padding: 1rem
}

.content {
  padding: 1rem
}
</style>