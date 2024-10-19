<script lang="ts" setup>

import {SrContactDialog} from "#components";

import {useDialog} from "primevue/usedialog";

definePageMeta({
  description: 'Gereedschap en machines huren en verhuren',
})

const dialog = useDialog()

const showContactDialog = () => {
  dialog.open(SrContactDialog, {
    header: 'Contact',
    style: {width: '50vw'},
    breakpoints: {'1199px': '75vw', '575px': '90vw'}
  })
}
</script>

<template>
  <div>
    <Head>
      <Title>Verhuren</Title>
    </Head>
    <section class="bg-gray-200">
      <div class="md:max-w-[1240px] md:mx-auto flex justify-between gap-2 md:gap-10 md:flex-row flex-col">
        <div class="m-5 font-bold flex items-center">
          <i class="pi pi-check"></i>
          <span class="text-center text-xl ml-3">Vergroot je online bereik</span>
        </div>
        <div class="m-5 font-bold flex items-center">
          <i class="pi pi-check"></i>
          <span class="text-center text-xl ml-3">Verminder administratieve lasten</span>
        </div>
        <div class="m-5 font-bold flex items-center">
          <i class="pi pi-check"></i>
          <span class="text-center text-xl ml-3">Versnel je afhandelingsproces</span>
        </div>
      </div>
    </section>
    <section class="green-area">
      <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">
        <div class="flex py-40 align-middle justify-center">
          <div class="flex flex-col w-full md:w-1/2 justify-center">
            <h1 class="my-10 font-extrabold text-4xl md:text-4xl">ShareRental</h1>
            <span class="my-10 text-xl">Verdien eenvoudig extra inkomsten door je gereedschap te verhuren via ShareRental en vergroot je online bereik. Begin vandaag nog en bereik meer potentiële huurders!</span>
            <NuxtLink to="/register">
              <Button unstyled class="rounded-lg bg-white font-bold text-black w-36 h-12 mt-4">Gratis registreren</Button>
            </NuxtLink>
          </div>
          <div class="w-1/2 hidden md:block">
            <NuxtImg loading="lazy" src="forklift-transparent-background.png" sizes="620px" alt="rental"/>
          </div>
        </div>
      </div>
    </section>
    <section class="bg-white mt-5">
      <div class="md:max-w-[1240px] md:mx-auto px-4 md:px-0">
        <div class="w-full flex justify-center">
          <h1 class="my-10 text-4xl"><a id="hoe_het_werkt">Hoe werkt het?</a></h1>
        </div>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-2 md:gap-8">
          <div class="flex flex-col m-5 md:m-20 w-80">
            <span class="text-xl font-bold">Meld je aan en plaats je aanbod</span>
            <span class="mt-2">Registreer je eenvoudig op ons platform en voeg je gereedschap toe. Upload foto's, stel je huurprijs in, en maak je producten direct beschikbaar voor potentiële huurders.</span>
          </div>
          <div class="flex flex-col m-5 md:m-20 w-80 hidden md:block">
            <NuxtImg loading="lazy" src="1.png" sizes="200px" alt="rental"/>
          </div>
          <div>
            <div class="flex flex-col m-5 md:m-20 w-80 hidden md:block">
              <NuxtImg loading="lazy" src="2.png" sizes="200px" alt="rental"/>
            </div>
          </div>
          <div>
            <div class="flex flex-col m-5 md:m-20 w-80">
              <span class="text-xl font-bold">Bereik huurders zonder kosten vooraf</span>
              <span class="mt-2"> Jouw gereedschap wordt zichtbaar voor een breed publiek zonder enige kosten vooraf. Huurders vinden je aanbod via onze gebruiksvriendelijke zoekfunctie en kunnen direct een reservering plaatsen.</span>
            </div>
          </div>
          <div>
            <div class="flex flex-col m-5 md:m-20 w-80">
              <span class="text-xl font-bold">Ontvang betalingen na een succesvolle verhuur</span>
              <span class="mt-2">Pas wanneer je gereedschap succesvol is verhuurd, rekenen wij een kleine vergoeding. Je ontvangt je betaling snel en veilig, zonder verborgen kosten of risico’s.</span>
            </div>
          </div>
          <div>
            <div class="flex flex-col m-5 md:m-20 w-80 hidden md:block">
              <NuxtImg loading="lazy" src="3.png" sizes="200px" alt="rental"/>
            </div>
          </div>
        </div>
      </div>
    </section>
    <section class="px-4 bg-gray-200">
      <div class="md:max-w-[1240px] md:mx-auto">
        <div class="grid grid-cols-1 md:grid-cols-2 mt-10 pt-10">
          <div class="hidden md:block">
            <NuxtImg loading="lazy" src="forklift-transparent-background.png" sizes="620px" alt="rental"/>
          </div>
          <div>
            <h1 class="my-10 text-3xl">Klaar om te verdienen met je gereedschap?</h1>
            <div class="font-bold my-10">Registreer je vandaag nog en bereik nieuwe huurders zonder vooraf kosten te maken. Heb je vragen? Neem gerust contact met ons op, we staan klaar om je te helpen!</div>
            <NuxtLink to="/register">
              <button unstyled class="rounded-lg black-area p-3 h-12 mr-8">Registreer nu</button>
            </NuxtLink>
            <NuxtLink to="/login">
              <button unstyled @click="showContactDialog()" class="rounded-lg black-area p-3 h-12">Contacteer ons</button>
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>
    <sr-cta-lessor></sr-cta-lessor>

  </div>
</template>

<style scoped>

</style>