<template>
  <div class="flex">
    <input-text unstyled
                type="text"
                class="rounded-l-lg"
                placeholder="Wat heb je nodig?"
                v-model="searchText"
                :pt="{root: {class: 'p-3 w-full font-bold text-black', style: 'outline: none;'}}"
    ></input-text>
    <Button class="rounded-r-lg black-area p-1" label="Zoeken" @click="search()" unstyled/>
  </div>
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
