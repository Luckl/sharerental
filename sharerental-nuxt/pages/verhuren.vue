<script lang="ts" setup>

definePageMeta({
  description: 'Gereedschap en machines huren en verhuren',
})

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
            <span class="my-10 text-xl">Met ShareRental verdien je eenvoudig extra inkomsten door je onbenutte gereedschap te verhuren. Ons platform biedt gebruiksvriendelijke tools en een groeiende community van betrouwbare huurders. Samen zorgen we voor een efficiënter gebruik van middelen, terwijl jij geniet van extra financiële voordelen en een netwerk van gelijkgestemden. Doe mee en ontdek hoe eenvoudig en winstgevend het kan zijn!</span>
            <NuxtLink to="/register">
              <Button unstyled class="rounded-lg bg-white font-bold text-black w-36 h-12 mt-4">Gratis registreren</Button>
            </NuxtLink>
          </div>
          <div class="w-1/2 hidden md:block">
            <NuxtImg src="forklift-transparent-background.png" sizes="620px" alt="rental"/>
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
            <span class="text-xl font-bold">Registreren</span>
            <span class="mt-2">Maak een account aan via de registratie pagina</span>
          </div>
          <div class="flex flex-col m-5 md:m-20 w-80 hidden md:block">
            <NuxtImg src="1.png" sizes="200px" alt="rental"/>
          </div>
          <div>
            <div class="flex flex-col m-5 md:m-20 w-80 hidden md:block">
              <NuxtImg src="2.png" sizes="200px" alt="rental"/>
            </div>
          </div>
          <div>
            <div class="flex flex-col m-5 md:m-20 w-80">
              <span class="text-xl font-bold">Artikelen toevoegen</span>
              <span class="mt-2"> Maak artikelen aan die je wilt verhuren via het platform</span>
            </div>
          </div>
          <div>
            <div class="flex flex-col m-5 md:m-20 w-80">
              <span class="text-xl font-bold">Verhuren</span>
              <span class="mt-2">Begin meteen met verhuren!</span>
            </div>
          </div>

          <div>
            <div class="flex flex-col m-5 md:m-20 w-80 hidden md:block">
              <NuxtImg src="3.png" sizes="200px" alt="rental"/>
            </div>
          </div>
        </div>
      </div>
    </section>

    <sr-cta-lessor></sr-cta-lessor>

  </div>
</template>

<style scoped>

</style>