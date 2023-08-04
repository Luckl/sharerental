<template>
  <div class="site-navigation-header-container">
    <div>
      <NuxtLink to="/"><img alt="Logo" class="logo" src="../assets/sharerental_logo.png"/></NuxtLink>
    </div>
    <div><h1>ShareRental</h1></div>
    <div>
      <div>
        <div v-if="user">
          <div class="">
            <div>
              <i class="pi pi-user"></i>
            </div>
            <span>{{ user.email }}</span>
          </div>
        </div>
        <div v-else>
          <div class="desktop-menu">
            <NuxtLink to="/login">
              <Button class="desktop-button">
                Login
              </Button>
            </NuxtLink>
            <NuxtLink to="/register">
              <Button class="desktop-button">
                Register
              </Button>
            </NuxtLink>
          </div>
        </div>
        <div class="mobile-menu">
          <i class="pi pi-align-justify"></i>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import {useCurrentUser} from "vuefire";

const user = useCurrentUser()

</script>

<style>
.logo {
  width: 4rem;
  margin: 1rem;
  border-radius: 5px;
}

.desktop-button {
  margin: 0.2rem
}

.site-navigation-header-container {
  background-color: #e8eef2;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

@media screen and (max-width: 678px) {
  .desktop-menu {
    display: none;
  }
}

@media screen and (min-width: 678px) {
  .mobile-menu {
    display: none;
  }
}
</style>