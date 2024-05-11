<template>
    <Card>
      <template class="header" #header>
        <h1 class="w-full text-xl font-bold">
          <slot name="header"/>
        </h1>
      </template>
      <template class="content" #content>
        <slot name="content"/>
      </template>
    </card>
</template>

<script setup lang="ts">

</script>

<style>


.header {
  padding: 1rem
}

.content {
  padding: 1rem
}
</style>