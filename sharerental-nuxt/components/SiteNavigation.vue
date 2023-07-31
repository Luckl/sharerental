<template>
  <div class="site-navigation-header-container">
    <div class="logo">
      <img alt="Logo" class="logo" src="../assets/boels-rental-logo.jpg"/>
    </div>
    <div> <h1>ShareRental</h1></div>
    <div>
      <div>
        <div v-if="user">
          <div>
            <i class="pi pi-user"></i>
          </div>
          <span>{{ user.email }}</span>
        </div>
        <div v-else class="desktop-menu">
          <Button>
            <NuxtLink to="/login">Login</NuxtLink>
          </Button>
          <Button>
            <NuxtLink to="/register">Register</NuxtLink>
          </Button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import {useCurrentUser} from "vuefire";

const user = useCurrentUser()

function redirectToLogin() {

}
</script>

<style>
.logo {
  width: 8.3rem
}

.site-navigation-header-container {
  display: flex;
  justify-content: space-between;
}

@media screen and (max-width: 678px){
  .desktop-menu{
    display: none;
  }
}
@media screen and (min-width: 678px){
  .mobile-menu{
    display: none;
  }
}
</style>