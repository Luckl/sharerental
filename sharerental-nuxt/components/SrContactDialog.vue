<script setup lang="ts">

import { ref, reactive } from "vue";
import {useUserStore} from "~/services/stores/userStore";
import {ContactFormApi} from "~/schemas/openapi/contactForm";

const contactFormApi: ContactFormApi = useNuxtApp().$contactFormApi;
const userStore = useUserStore()
const user = ref(userStore.user)

const dialogRef = inject("dialogRef");

const contactForm = reactive({
  name: '',
  email: '',
  phone: '',
  message: ''
});

const shareContactDetails = () => {
  contactFormApi.sendContactForm({
    contactForm: {
      name: contactForm.name,
      email: contactForm.email,
      phone: contactForm.phone,
      analyticsToken: user.value?.uid ?? '',
      message: contactForm.message
    }
  })

  dialogRef.value.close();
}

</script>

<template>
    <form @submit.prevent>
      <div class="flex flex-col">
        <span class="p-text-secondary block mb-5">Laat je gegevens achter en we nemen zo snel mogelijk contact met je op</span>
        <label for="name">Naam</label>
        <InputText id="name" v-model="contactForm.name" class="rounded-lg p-2"></InputText>
        <label for="email">Email</label>
        <InputText id="email" v-model="contactForm.email" type="email" class="rounded-lg p-2"></InputText>
        <label for="phone">Telefoon</label>
        <InputText id="phone" v-model="contactForm.phone" class="rounded-lg p-2"></InputText>
        <label for="message">Bericht</label>
        <Textarea id="message" v-model="contactForm.message" class="rounded-lg p-2 h-32"></Textarea>
        <button unstyled type="submit" class="rounded-lg green-area font-bold w-36 h-12 mt-4" @click="shareContactDetails()">Versturen</button>
      </div>
    </form>
</template>

<style scoped>

</style>