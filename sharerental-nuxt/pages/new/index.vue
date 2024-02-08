<script lang="ts" setup>

definePageMeta({
  title: 'ShareRental - Home',
  description: 'New layout',
  layout: 'new'
})


</script>

<template>
  <div class="top-bar side-padding">
    <div>
      Iemand spreken over verhuren? <span class="phone-number">+31 6 43209314</span>
    </div>
    <div><span>Huren</span> | <span>Verhuren</span></div>
  </div>
  <div class="side-padding orange-area">
    <h1>ShareRental</h1>
    <nav class="nav">
      <NuxtLink class="nav-element" to="/">Assortiment</NuxtLink>
      <NuxtLink class="nav-element" to="/about">Hoe het werkt</NuxtLink>
      <NuxtLink class="nav-element" to="/contact">Contact</NuxtLink>
      <NuxtLink class="nav-element" to="/register">
        <Button>
          Inloggen
        </Button>
      </NuxtLink>
    </nav>
  </div>
</template>

<style scoped>
.orange-area {
  background-color: #F9AD4D;
  color: #242635;
  display: flex;
  align-items: center;
}

.top-bar {
  background-color: #242635;
  color: white;
  padding: 20px 0;
  display: flex;
  justify-content: space-between;
}

.nav {
  display: flex;
  justify-content: space-between;
  padding: 20px 0;
}

.phone-number {
  font-weight: 100;
}

.nav-element {
  margin: 0 20px;
  font-size: 2em;
  font-weight: 600;
}
@media screen and (min-width: 820px) {
  h1 {
    padding-top: 20px;
    padding-bottom: 20px;
    margin-right: 50px;
    font-size: 4em;
    font-weight: 600;
  }

  .side-padding {
    padding: 0 200px;
  }
}

@media screen and (max-width: 820px) {
  h1 {
    padding-top: 20px;
    padding-bottom: 20px;
    margin-right: 50px;
    font-size: 2em;
    font-weight: 600;
  }

  .side-padding {
    padding: 0 50px;
  }
}
</style>