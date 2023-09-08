<template>
  <FormPage>
    <template #header>
      <span class="font-bold text-xl m-1">Artikel toevoegen</span>
    </template>
    <template #content class="flexbox-column">
      <form @submit.prevent>
        <div class="flexbox-column">
          <label for="fName" class="data-label mb-1">Weergavenaam</label>
          <InputText id="fName" class="mb-1" v-model="formInput.name"></InputText>
        </div>
        <div class="flexbox-column">
          <label for="fNumber" class="data-label mb-1">Eigen referentie</label>
          <InputText id="fNumber" class="mb-1" v-model="formInput.number"></InputText>
        </div>
        <div class="flexbox-column">
          <label for="fPostalCode" class="data-label mb-1">Categorie</label>
          <Dropdown v-model="formInput.category" :options="categories" optionLabel="name" placeholder="Kies een categorie" class="" />
        </div>
        <Divider align="left" type="solid" class="mb-1">
          <span>Omschrijving</span>
        </Divider>
        <div class="flexbox-column">
          <label for="fHouseNumber" class="data-label mb-1">Huisnummer</label>
          <InputText id="fHouseNumber" class="mb-1" v-model="formInput.houseNumber"></InputText>
        </div>
        <div class="flexbox-column">
          <label for="fHouseNumberAddition" class="data-label mb-1">Toevoeging</label>
          <InputText id="fHouseNumberAddition" class="mb-1 fit"
                     v-model="formInput.houseNumberAddition"></InputText>
        </div>
        <div class="flexbox-column">
          <label for="fStreet" class="data-label mb-1">Straat</label>
          <InputText id="fStreet" class="mb-1 fit" v-model="formInput.street"></InputText>
        </div>
        <div class="flexbox-column">
          <label for="fCity" class="data-label mb-1">Woonplaats</label>
          <InputText id="fCity" class="mb-1 fit" v-model="formInput.city"></InputText>
        </div>
        <Divider align="left" type="solid" class="mb-1">
          <span>Contactgegevens</span>
        </Divider>
        <div class="flexbox-column">
          <label for="fCity" class="data-label mb-1">Telefoonnummer</label>
          <InputText id="fCity" class="mb-1 fit" v-model="formInput.phoneNumber"></InputText>
        </div>
        <div>
          <Button type="submit" @Click="onSubmitNewItem">Aanmaken</Button>
        </div>
      </form>
    </template>
  </FormPage>
</template>
<script setup lang="ts">
const router = useRouter()

const categories = ref([
  { name: 'Stijgers, trappen en hoogwerkers', code: 1 },
  { name: 'Luchtdrukgereedschap', code: 2 },
  { name: 'Electrisch gereedschap', code: 3 },
  { name: 'Betonbewerking', code: 4 },
  { name: 'Grondverzetters, bouwmachines en tuinmateriaal', code: 5 },
  { name: 'Evenementen', code: 6 },
  { name: 'Hef-hijswerktuigen', code: 7 },
  { name: 'Verwarmen, drogen en reinigen', code: 8 },
  { name: 'Transport', code: 9 }
]);

const formInput = reactive({
  name: "",
  number: "",
  category: "",
  postalCode: "",
  houseNumber: "",
  houseNumberAddition: "",
  city: "",
  country: "",
  phoneNumber: ""
})

function onSubmitNewItem() {
  console.log("create")
  formInput.name= "";
  formInput.number= "";
  formInput.category= "";
  formInput.postalCode= "";
  formInput.houseNumber= "";
  formInput.houseNumberAddition= "";
  formInput.city= "";
  formInput.country= "";
  formInput.phoneNumber= "";

  router.push('/items')
}
</script>
<style >

.flexbox-column {
  display: flex;
  flex-direction: column
}

.mb-1 {
  margin-bottom: 1rem
}

.data-label {
  font-weight: bold;
}

</style>