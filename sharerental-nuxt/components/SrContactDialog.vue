<script setup lang="ts">
import type ContactFormClient from "~/services/api/ContactFormClient";

import { ref, reactive } from "vue";
import {useUserStore} from "~/services/stores/userStore";

const contactFormClient: ContactFormClient = useNuxtApp().$contactFormClient;
const userStore = useUserStore()
const user = ref(userStore.user)

const showInfoDialog = ref(false);
const showThanksDialog = ref(false);
const contactForm = reactive({
  name: '',
  email: '',
  phone: ''
});

const shareContactDetails = () => {
  contactFormClient.sendContactForm({
    name: contactForm.name,
    email: contactForm.email,
    phone: contactForm.phone,
    analyticsToken: user.value?.uid ?? ''
  })

  contactForm.name = ''
  contactForm.email = ''
  contactForm.phone = ''
  showInfoDialog.value = false
  showThanksDialog.value = true
}

</script>

<template>
  <Dialog v-model:visible="showInfoDialog" modal header="Contact" :style="{ width: '50vw' }"
          :breakpoints="{ '1199px': '75vw', '575px': '90vw' }">
    <form @submit.prevent>
      <div class="flex flex-col">
        <span class="p-text-secondary block mb-5">Laat je gegevens achter en we nemen zo snel mogelijk contact met je op</span>
        <label for="name">Naam</label>
        <InputText id="name" v-model="contactForm.name" class="rounded-lg p-2"></InputText>
        <label for="email">Email</label>
        <InputText id="email" v-model="contactForm.email" type="email" class="rounded-lg p-2"></InputText>
        <label for="phone">Telefoon</label>
        <InputText id="phone" v-model="contactForm.phone" class="rounded-lg p-2"></InputText>
        <button unstyled type="submit" class="rounded-lg green-area font-bold w-36 h-12 mt-4" @click="shareContactDetails()">Versturen</button>
      </div>
    </form>
  </Dialog>
  <Dialog v-model:visible="showThanksDialog" modal header="Bedankt!" :style="{ width: '50vw' }"
          :breakpoints="{ '1199px': '75vw', '575px': '90vw' }">
    <div class="flex flex-col">
      <span class="p-text-secondary block mb-5">Bedankt! We nemen zo snel mogelijk contact met je op.</span>
      <button type="submit" unstyled class="rounded-lg green-area font-bold w-36 h-12 mt-4" @click="showThanksDialog = false">Sluiten</button>
    </div>
  </Dialog>
</template>

<style scoped>

</style>