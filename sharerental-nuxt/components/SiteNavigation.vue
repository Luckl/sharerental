<template>
  <div class="site-navigation-header-container">
    <div>
      <NuxtLink to="/"><img alt="Logo" class="logo" src="../assets/sharerental_logo.png"/></NuxtLink>
    </div>
    <div><h1>ShareRental</h1></div>
    <div>
      <div>
        <div v-if="user">
          <NuxtLink to="/login" class="remove-link-style">
            <div class="button-icon">
              <i class="pi pi-user"></i>
            </div>
          </NuxtLink>
        </div>
        <div v-else>
          <div class="desktop-menu right-menu">
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
        <div class="mobile-menu right-menu button-icon">
          <i class="pi pi-align-justify" @click="menuOpened = !menuOpened"></i>
          <Sidebar v-model:visible="menuOpened" position="right">
            <NuxtLink to="/login">
              <Button @click="menuOpened = false" class="menu-button">
                Login
              </Button>
            </NuxtLink>
            <NuxtLink to="/register">
              <Button @click="menuOpened = false" class="menu-button">
                Register
              </Button>
            </NuxtLink>
          </Sidebar>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import {useCurrentUser} from "vuefire";
import {ref} from "vue";

const menuOpened = ref(false);
const user = useCurrentUser()
</script>

<style>
.remove-link-style {
  text-decoration: none;
  color: inherit;
}
.button-icon {
  background-color: #FFC107;
  padding: 1rem;
  border-radius: 2rem;
  margin: 2rem;
  box-shadow: 0.2rem 0.2rem 0.3rem lightblue;
}
.logo {
  width: 4rem;
  margin: 1rem;
  border-radius: 5px;
  box-shadow: 0.2rem 0.2rem 0.3rem lightblue;
}

.menu-button {
  width: 100%;
  margin: 0.1rem;
}

.desktop-button {
  margin: 0.2rem;
}

.right-menu {
  padding-right: 1rem;
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