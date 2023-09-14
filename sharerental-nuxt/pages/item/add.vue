<template>
  <Message severity="error" v-if="error" v-bind:sticky="false">{{ error }}</Message>

  <FormPage>
    <template #header>
      <span class="font-bold text-xl m-1">Artikel toevoegen</span>
    </template>
    <template #content class="flexbox-column">
      <form @submit.prevent>
        <div class="flexbox-column">
          <label for="fName" class="data-label mb-1">Weergavenaam</label>
          <InputText inputId="fName" class="mb-1" v-model="formInput.name"></InputText>
        </div>
        <div class="flexbox-column">
          <label for="fNumber" class="data-label mb-1">Eigen referentie</label>
          <InputText inputId="fNumber" class="mb-1" v-model="formInput.number"></InputText>
        </div>
        <div class="flexbox-column">
          <label for="fCategory" class="data-label mb-1">Categorie</label>
          <Dropdown inputId="fCategory" v-model="formInput.category" :options="categories" optionLabel="name"
                    option-value="name"
                    placeholder="Kies een categorie" class=""/>
        </div>
        <Divider align="left" type="solid" class="mb-1">
          <span>Omschrijving</span>
        </Divider>
        <div class="flexbox-column">
          <label for="fShortDescription" class="data-label mb-1">Korte omschrijving</label>
          <Textarea inputId="fShortDescription" class="mb-1" v-model="formInput.shortDescription"></Textarea>
        </div>
        <div class="flexbox-column">
          <label for="fLongDescription" class="data-label mb-1">Lange omschrijving</label>
          <Textarea inputId="fLongDescription" class="mb-1" v-model="formInput.longDescription"></Textarea>
        </div>
        <div class="flexbox-column">
          <label for="fDeliveryPossible" class="data-label mb-1">Bezorgen mogelijk</label>
          <Checkbox inputId="fDeliveryPossible" :binary="true" class="mb-1"
                    v-model="formInput.deliveryPossible"></Checkbox>
        </div>
        <div class="flexbox-column" v-if="formInput.deliveryPossible">
          <label for="fDeliveryPrice" class="data-label mb-1">Prijs voor bezorgen</label>
          <InputNumber v-model="formInput.deliveryPrice" inputId="fDeliveryPrice" mode="currency"
                       currency="EUR"></InputNumber>
        </div>

        <Divider align="left" type="solid" class="mb-1">
          <span>Details</span>
        </Divider>
        <div class="flexbox-column">
          <label for="fPrice24h" class="data-label mb-1">Prijs per dag</label>
          <InputNumber v-model="formInput.price24h" inputId="fPrice24h" mode="currency" currency="EUR"></InputNumber>
        </div>
        <div class="flexbox-column">
          <label for="fPrice48h" class="data-label mb-1">Prijs per twee dagen</label>
          <InputNumber v-model="formInput.price48h" inputId="fPrice48h" mode="currency" currency="EUR"></InputNumber>
        </div>
        <div class="flexbox-column">
          <label for="fPrice168h" class="data-label mb-1">Prijs per week</label>
          <InputNumber v-model="formInput.price168h" inputId="fPrice168h" mode="currency" currency="EUR"></InputNumber>
        </div>
        <Divider align="left" type="solid" class="mb-1">
          <span>Aanvullende gegevens</span>
        </Divider>

        <div class="flexbox-column">
          <label for="brand" class="data-label mb-1">Merk</label>
          <InputText inputId="brand" class="mb-1" v-model="formInput.brand"></InputText>
        </div>
        <div class="flexbox-column">
          <label for="intrinsicWeightKilograms" class="data-label mb-1">Gewicht</label>
          <InputNumber v-model="formInput.intrinsicWeightKilograms" inputId="intrinsicWeightKilograms"
                       suffix=" kg"></InputNumber>
        </div>

        <div class="flexbox-column" v-if="formInput.category === 'Stijgers, trappen en hoogwerkers'">
          <label for="materialType" class="data-label mb-1">Type materiaal</label>
          <InputText inputId="materialType" class="mb-1" v-model="formInput.materialType"></InputText>
        </div>

        <div class="flexbox-column" v-if="formInput.category === 'Stijgers, trappen en hoogwerkers' ||
        formInput.category === 'Hef-hijswerktuigen'">
          <label for="fReachMeters" class="data-label mb-1">Bereik</label>
          <InputNumber v-model="formInput.reachMeters" inputId="fReachMeters" suffix="meter"
                       currency="EUR"></InputNumber>
        </div>
        <div class="flexbox-column" v-if="formInput.category === 'Stijgers, trappen en hoogwerkers' ||
        formInput.category === 'Hef-hijswerktuigen'">
          <label for="carryingWeightKilograms" class="data-label mb-1">Maximale draaggewicht</label>
          <InputNumber v-model="formInput.carryingWeightKilograms" inputId="carryingWeightKilograms"
                       suffix=" kg"></InputNumber>
        </div>
        <div class="flexbox-column" v-if="formInput.category === 'Stijgers, trappen en hoogwerkers'">
          <label for="maximumWorkHeightMeters" class="data-label mb-1">Maximale werkhoogte</label>
          <InputNumber v-model="formInput.maximumWorkHeightMeters" inputId="maximumWorkHeightMeters"
                       suffix=" m"></InputNumber>
        </div>

        <div class="flexbox-column" v-if="formInput.category === 'Luchtdrukgereedschap'">
          <label for="maximumPressureBars" class="data-label mb-1">Maximale drukvermogen</label>
          <InputNumber v-model="formInput.maximumPressureBars" inputId="maximumPressureBars"
                       suffix=" bar"></InputNumber>
        </div>
        <div class="flexbox-column" v-if="formInput.category === 'Luchtdrukgereedschap'">
          <label for="maximumHorsePower" class="data-label mb-1">Maximale vermogen</label>
          <InputNumber v-model="formInput.maximumHorsePower" inputId="maximumHorsePower"
                       suffix=" pk"></InputNumber>
        </div>

        <div class="flexbox-column" v-if="formInput.category === 'Elektrisch gereedschap' ||
          formInput.category === 'Verwarmen, drogen en reinigen'">
          <label for="requiredPowerVoltageVolt" class="data-label mb-1">Benodigde stroomtoevoer</label>
          <InputNumber v-model="formInput.requiredPowerVoltageVolt" inputId="requiredPowerVoltageVolt"
                       suffix=" V"></InputNumber>
        </div>

        <div class="flexbox-column" v-if="formInput.category === 'Betonbewerking'">
          <label for="workWidthMeters" class="data-label mb-1">Werkbreedte</label>
          <InputNumber v-model="formInput.workWidthMeters" inputId="workWidthMeters"
                       suffix=" m"></InputNumber>
        </div>
        <div class="flexbox-column" v-if="formInput.category === 'Betonbewerking'">
          <label for="vacuumAttachmentPossible" class="data-label mb-1">Stofzuiger aansluiting</label>
          <Checkbox inputId="vacuumAttachmentPossible" :binary="true" class="mb-1"
                    v-model="formInput.vacuumAttachmentPossible"></Checkbox>
        </div>

        <div class="flexbox-column" v-if="formInput.category === 'Gondverzetters, bouwmachines en tuinmateriaal'">
          <label for="capacityLiters" class="data-label mb-1">Bakinhoud</label>
          <InputNumber v-model="formInput.capacityLiters" inputId="capacityLiters"
                       suffix=" L"></InputNumber>
        </div>

        <div class="flexbox-column" v-if="formInput.category === 'Evenementen'">
          <label for="itemHeight" class="data-label mb-1">Artikelhoogte</label>
          <InputNumber v-model="formInput.itemHeight" inputId="itemHeight"
                       suffix=" m"></InputNumber>
        </div>
        <div class="flexbox-column" v-if="formInput.category === 'Evenementen'">
          <label for="itemWidth" class="data-label mb-1">Artikelbreedte</label>
          <InputNumber v-model="formInput.itemWidth" inputId="itemWidth"
                       suffix=" m"></InputNumber>
        </div>
        <div class="flexbox-column" v-if="formInput.category === 'Evenementen'">
          <label for="itemLength" class="data-label mb-1">Artikellengte</label>
          <InputNumber v-model="formInput.itemLength" inputId="itemLength"
                       suffix=" m"></InputNumber>
        </div>
        <div class="flexbox-column" v-if="formInput.category === 'Verwarmen, drogen en reinigen'">
          <label for="powerWatt" class="data-label mb-1">Vermogen</label>
          <InputNumber v-model="formInput.powerWatt" inputId="powerWatt"
                       suffix=" W"></InputNumber>
        </div>

        <div class="flexbox-column" v-if="formInput.category === 'Verwarmen, drogen en reinigen'">
          <label for="maximumSurfaceSquareMeters" class="data-label mb-1">Maximale oppervlakte</label>
          <InputNumber v-model="formInput.maximumSurfaceSquareMeters" inputId="maximumSurfaceSquareMeters"
                       suffix=" W"></InputNumber>
        </div>

        <div class="flexbox-column mt-5">
          <Button type="submit" @Click="onSubmitNewItem">Aanmaken</Button>
        </div>
      </form>
    </template>
  </FormPage>
</template>
<script setup lang="ts">
import {RentalItemInput} from "~/schemas/openapi/rentalItem";
import RentalItemClient from "~/services/api/RentalItem";

const router = useRouter()
const error = ref<String | undefined>(undefined)
const $rentalItemClient: RentalItemClient = useNuxtApp().$rentalItemClient;

const categories = ref([
  {name: 'Stijgers, trappen en hoogwerkers'},
  {name: 'Luchtdrukgereedschap'},
  {name: 'Electrisch gereedschap'},
  {name: 'Betonbewerking'},
  {name: 'Grondverzetters, bouwmachines en tuinmateriaal'},
  {name: 'Evenementen'},
  {name: 'Hef-hijswerktuigen'},
  {name: 'Verwarmen, drogen en reinigen'},
  {name: 'Transport'}
]);

const formInput = reactive<RentalItemInput>({
  name: "",
  number: undefined,
  category: undefined,
  shortDescription: undefined,
  longDescription: undefined,
  deliveryPossible: false,
  deliveryPrice: undefined,
  price24h: undefined,
  price48h: undefined,
  price168h: undefined,
  reachMeters: undefined,
  carryingWeightKilograms: undefined,
  maximumWorkHeightMeters: undefined,
  intrinsicWeightKilograms: undefined,
  maximumPressureBars: undefined,
  maximumHorsePower: undefined,
  requiredPowerVoltageVolt: undefined,
  workWidthMeters: undefined,
  capacityLiters: undefined,
  itemHeight: undefined,
  itemWidth: undefined,
  itemLength: undefined,
  powerWatt: undefined,
  maximumSurfaceSquareMeters: undefined,
  materialType: undefined,
  brand: undefined,
  vacuumAttachmentPossible: false
})

function onSubmitNewItem() {

  $rentalItemClient.create(formInput)
      .then(success => {
            router.push('/items')

            formInput.name = "";
            formInput.number = "";
            formInput.category = "";
            formInput.shortDescription = "";
            formInput.longDescription = "";
            formInput.deliveryPossible = false;
            formInput.deliveryPrice = undefined;
            formInput.price24h = undefined;
            formInput.price48h = undefined;
            formInput.price168h = undefined;
            formInput.reachMeters = undefined;
            formInput.carryingWeightKilograms = undefined;
            formInput.maximumWorkHeightMeters = undefined;
            formInput.intrinsicWeightKilograms = undefined;
            formInput.maximumPressureBars = undefined;
            formInput.maximumHorsePower = undefined;
            formInput.requiredPowerVoltageVolt = undefined;
            formInput.workWidthMeters = undefined;
            formInput.capacityLiters = undefined;
            formInput.itemHeight = undefined;
            formInput.itemWidth = undefined;
            formInput.itemLength = undefined;
            formInput.powerWatt = undefined;
            formInput.maximumSurfaceSquareMeters = undefined;
            formInput.materialType = undefined;
            formInput.brand = undefined;
            formInput.vacuumAttachmentPossible = false;
          },
          failureReason => {
            error.value = "Er is iets fout gegaan"
          })
}

</script>
<style>

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