<template>
  <div class="flex justify-content-between flex-wrap bg-yellow-100">
    <div class="flex align-items-center ml-2">
      <img alt="Vue logo" class="header-logo" src="./assets/primevue-logo.png"/>
    </div>
    <div class="flex align-items-center text-center font-bold">ShareRental</div>
    <div class="flex align-items-center">
      <i class="pi pi-user"></i>
    </div>
  </div>

</template>

<script setup lang="ts">
import {ref} from "vue";
import {useToast} from "primevue/usetoast";

const text = ref();
const toast = useToast();
const greet = () => {
  toast.add({severity: "info", summary: "Hello " + text.value});
};
</script>

<style>
.header-logo {
  height: 50px;
}

</style>
