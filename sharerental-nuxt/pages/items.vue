<template>
  <div class="form-container">
    <div class="sm:flex">
      <div class="grow">
        <label class="m-3 mr-5 font-bold" for="search">Zoeken</label>
        <InputText class="m-3" id="search"></InputText>
      </div>
      <div>
        <Button class="m-3" icon="pi pi-plus" label="Aanmaken"></Button>
      </div>
    </div>

  </div>
</template>
<script lang="ts" setup>

</script>
<style>
.form-container {
  padding-left: 10%;
  padding-right: 10%;
  padding-top: 5em;
  height: 100%;
}
</style>