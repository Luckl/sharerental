<template>
  <span class="p-input-icon-left button">
          <i class="pi pi-search"/>
          <InputText v-model="searchText" placeholder="Zoek gereedschap" class="border-right-none"/>
          <Button label="Zoeken" v-on:click="search" class="border-left-none"/>
        </span>
</template>

<script lang="ts" setup>
import {useRouter} from "#app";
import {ref} from "vue";

const router = useRouter();
let searchText = ref("")

function search() {
  router.push("/search/" + searchText.value)
}
</script>
