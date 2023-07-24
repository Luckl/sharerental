<template>
  <div class="flex justify-content-between bg-yellow-100 p-2">
    <div class="flex-1 align-items-center ml-2">
      <img alt="Logo" class="h-3rem" src="../assets/boels-rental-logo.jpg"/>
    </div>
    <div class="flex-1 align-items-center text-center font-bold text-3xl">ShareRental</div>
    <div class="flex-1">
      <div class="flex">
        <div v-if="auth.status.value === 'authenticated'" class="absolute mr-3 right-0">
          <div class="bg-yellow-600 border-circle p-3">
            <i class="pi pi-user"></i>
          </div>
          <span class="absolute right-1"> {{ auth.data?.value?.user?.name }} </span>
        </div>
        <div v-else class="absolute mr-3 right-0 ">
          <Button
              class="flex items-center justify-center space-x-2 bg-green-500 text-white rounded-lg py-2 px-3 text-lg"
              @click="auth.signIn()">
            <i class="fa fa-right-to-bracket pt-0.5"/>
            <span>Login</span>
          </Button>
        </div>
      </div>
    </div>
  </div>
  <div class="bg-yellow-200 h-2rem"></div>
</template>

<script setup lang="ts">
import {useAuth} from "#imports";

const auth = useAuth()
</script>
