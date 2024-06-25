<template>
  <form @submit.prevent>
    <div class="flexbox-column">
      <label for="fName" class="data-label mb-1">Weergavenaam</label>
      <InputText inputId="fName" class="mb-1" v-model="props.rentalItem.name"></InputText>
    </div>
    <div class="flexbox-column">
    <label for="fExternalReference" class="data-label mb-1">Eigen referentie</label>
    <InputText inputId="fExternalReference" class="mb-1" v-model="props.rentalItem.externalReference"></InputText>
  </div>
    <div class="flexbox-column">
      <label for="fCategory" class="data-label mb-1">Categorie</label>
      <Dropdown inputId="fCategory" v-model="props.rentalItem.category" :options="categories" optionLabel="name"
                option-value="name"
                placeholder="Kies een categorie" class=""/>
    </div>
    <Divider align="left" type="solid" class="mb-1">
      <span>Omschrijving</span>
    </Divider>
    <div class="flexbox-column">
      <label for="fShortDescription" class="data-label mb-1">Korte omschrijving</label>
      <Textarea inputId="fShortDescription" class="mb-1" v-model="props.rentalItem.shortDescription"></Textarea>
    </div>
    <div class="flexbox-column">
      <label for="fRentToRenterType" class="data-label mb-1">Verhuren aan</label>
      <Dropdown inputId="fRentToRenterType" v-model="props.rentalItem.rentToRenterType"
                :options="renterTypes" option-value="value" option-label="name" showClear placeholder="Alle type klanten" class="mb-1"></Dropdown>
    </div>
    <div class="flexbox-column">
      <label for="fLongDescription" class="data-label mb-1">Lange omschrijving</label>
      <Textarea inputId="fLongDescription" class="mb-1" v-model="props.rentalItem.longDescription"></Textarea>
    </div>

    <div class="flexbox-column">
      <label for="fAutomaticallyAcceptTransaction" class="data-label mb-1">Transacties voor dit artikel automatisch accepteren</label>
      <Checkbox inputId="fDeliveryPossible" binary class="mb-1"
                v-model="props.rentalItem.automaticallyAcceptTransaction"></Checkbox>
    </div>

    <div class="flexbox-column">
      <label for="fDeliveryPossible" class="data-label mb-1">Bezorgen mogelijk</label>
      <Checkbox inputId="fDeliveryPossible" :binary="true" class="mb-1"
                v-model="props.rentalItem.deliveryPossible"></Checkbox>
    </div>

    <div class="flexbox-column" v-if="props.rentalItem.deliveryPossible">
      <label for="fDeliveryPrice" class="data-label mb-1">Prijs voor bezorgen</label>
      <InputNumber v-model="props.rentalItem.deliveryPrice" inputId="fDeliveryPrice" mode="currency"
                   currency="EUR"></InputNumber>
    </div>

    <Divider align="left" type="solid" class="mb-1">
      <span>Details</span>
    </Divider>
    <div class="flexbox-column">
      <label for="fPrice24h" class="data-label mb-1">Prijs per dag</label>
      <InputNumber v-model="props.rentalItem.price24h" inputId="fPrice24h" mode="currency" currency="EUR"></InputNumber>
    </div>
    <div class="flexbox-column">
      <label for="fPrice48h" class="data-label mb-1">Prijs per twee dagen</label>
      <InputNumber v-model="props.rentalItem.price48h" inputId="fPrice48h" mode="currency" currency="EUR"></InputNumber>
    </div>
    <div class="flexbox-column">
      <label for="fPrice168h" class="data-label mb-1">Prijs per week</label>
      <InputNumber v-model="props.rentalItem.price168h" inputId="fPrice168h" mode="currency" currency="EUR"></InputNumber>
    </div>

    <div class="flexbox-column">
      <label for="fAmount" class="data-label mb-1">Aantal</label>
      <InputNumber v-model="props.rentalItem.amount" inputId="fAmount"></InputNumber>
    </div>


    <Divider align="left" type="solid" class="mb-1">
      <span>Aanvullende gegevens</span>
    </Divider>

    <div class="flexbox-column">
      <label for="brand" class="data-label mb-1">Merk</label>
      <InputText inputId="brand" class="mb-1" v-model="props.rentalItem.brand"></InputText>
    </div>
    <div class="flexbox-column">
      <label for="intrinsicWeightKilograms" class="data-label mb-1">Gewicht</label>
      <InputNumber v-model="props.rentalItem.intrinsicWeightKilograms" inputId="intrinsicWeightKilograms"
                   suffix=" kg"></InputNumber>
    </div>

    <div class="flexbox-column" v-if="props.rentalItem.category === 'Stijgers, trappen en hoogwerkers'">
      <label for="materialType" class="data-label mb-1">Type materiaal</label>
      <InputText inputId="materialType" class="mb-1" v-model="props.rentalItem.materialType"></InputText>
    </div>

    <div class="flexbox-column" v-if="props.rentalItem.category === 'Stijgers, trappen en hoogwerkers' ||
        props.rentalItem.category === 'Hef-hijswerktuigen'">
      <label for="fReachMeters" class="data-label mb-1">Bereik</label>
      <InputNumber v-model="props.rentalItem.reachMeters" inputId="fReachMeters" suffix="meter"
                   currency="EUR"></InputNumber>
    </div>
    <div class="flexbox-column" v-if="props.rentalItem.category === 'Stijgers, trappen en hoogwerkers' ||
        props.rentalItem.category === 'Hef-hijswerktuigen'">
      <label for="carryingWeightKilograms" class="data-label mb-1">Maximale draaggewicht</label>
      <InputNumber v-model="props.rentalItem.carryingWeightKilograms" inputId="carryingWeightKilograms"
                   suffix=" kg"></InputNumber>
    </div>
    <div class="flexbox-column" v-if="props.rentalItem.category === 'Stijgers, trappen en hoogwerkers'">
      <label for="maximumWorkHeightMeters" class="data-label mb-1">Maximale werkhoogte</label>
      <InputNumber v-model="props.rentalItem.maximumWorkHeightMeters" inputId="maximumWorkHeightMeters"
                   suffix=" m"></InputNumber>
    </div>

    <div class="flexbox-column" v-if="props.rentalItem.category === 'Luchtdrukgereedschap'">
      <label for="maximumPressureBars" class="data-label mb-1">Maximale drukvermogen</label>
      <InputNumber v-model="props.rentalItem.maximumPressureBars" inputId="maximumPressureBars"
                   suffix=" bar"></InputNumber>
    </div>
    <div class="flexbox-column" v-if="props.rentalItem.category === 'Luchtdrukgereedschap'">
      <label for="maximumHorsePower" class="data-label mb-1">Maximale vermogen</label>
      <InputNumber v-model="props.rentalItem.maximumHorsePower" inputId="maximumHorsePower"
                   suffix=" pk"></InputNumber>
    </div>

    <div class="flexbox-column" v-if="props.rentalItem.category === 'Elektrisch gereedschap' ||
          props.rentalItem.category === 'Verwarmen, drogen en reinigen'">
      <label for="requiredPowerVoltageVolt" class="data-label mb-1">Benodigde stroomtoevoer</label>
      <InputNumber v-model="props.rentalItem.requiredPowerVoltageVolt" inputId="requiredPowerVoltageVolt"
                   suffix=" V"></InputNumber>
    </div>

    <div class="flexbox-column" v-if="props.rentalItem.category === 'Betonbewerking'">
      <label for="workWidthMeters" class="data-label mb-1">Werkbreedte</label>
      <InputNumber v-model="props.rentalItem.workWidthMeters" inputId="workWidthMeters"
                   suffix=" m"></InputNumber>
    </div>
    <div class="flexbox-column" v-if="props.rentalItem.category === 'Betonbewerking'">
      <label for="vacuumAttachmentPossible" class="data-label mb-1">Stofzuiger aansluiting</label>
      <Checkbox inputId="vacuumAttachmentPossible" :binary="true" class="mb-1"
                v-model="props.rentalItem.vacuumAttachmentPossible"></Checkbox>
    </div>

    <div class="flexbox-column" v-if="props.rentalItem.category === 'Gondverzetters, bouwmachines en tuinmateriaal'">
      <label for="capacityLiters" class="data-label mb-1">Bakinhoud</label>
      <InputNumber v-model="props.rentalItem.capacityLiters" inputId="capacityLiters"
                   suffix=" L"></InputNumber>
    </div>

    <div class="flexbox-column" v-if="props.rentalItem.category === 'Evenementen'">
      <label for="itemHeight" class="data-label mb-1">Artikelhoogte</label>
      <InputNumber v-model="props.rentalItem.itemHeight" inputId="itemHeight"
                   suffix=" m"></InputNumber>
    </div>
    <div class="flexbox-column" v-if="props.rentalItem.category === 'Evenementen'">
      <label for="itemWidth" class="data-label mb-1">Artikelbreedte</label>
      <InputNumber v-model="props.rentalItem.itemWidth" inputId="itemWidth"
                   suffix=" m"></InputNumber>
    </div>
    <div class="flexbox-column" v-if="props.rentalItem.category === 'Evenementen'">
      <label for="itemLength" class="data-label mb-1">Artikellengte</label>
      <InputNumber v-model="props.rentalItem.itemLength" inputId="itemLength"
                   suffix=" m"></InputNumber>
    </div>
    <div class="flexbox-column" v-if="props.rentalItem.category === 'Verwarmen, drogen en reinigen'">
      <label for="powerWatt" class="data-label mb-1">Vermogen</label>
      <InputNumber v-model="props.rentalItem.powerWatt" inputId="powerWatt"
                   suffix=" W"></InputNumber>
    </div>

    <div class="flexbox-column" v-if="props.rentalItem.category === 'Verwarmen, drogen en reinigen'">
      <label for="maximumSurfaceSquareMeters" class="data-label mb-1">Maximale oppervlakte</label>
      <InputNumber v-model="props.rentalItem.maximumSurfaceSquareMeters" inputId="maximumSurfaceSquareMeters"
                   suffix=" m2"></InputNumber>
    </div>
    <div class="flexbox-column mt-5">
      <Button type="submit" @click="props.submit">{{props.submitButtonText}}</Button>
    </div>
  </form>
</template>

<script setup lang="ts">
import { ref } from "vue";
import type {RentalItemInput} from "~/schemas/openapi/rentalItem";

interface Props {
  rentalItem: RentalItemInput;
  submit: Function;
  submitButtonText: string;
}

// Define props and emitters here if needed
const props = defineProps<Props>()
const renterTypes = ref([
  { name: 'Bedrijven', value: 'BUSINESS' },
  { name: 'Particulieren', value: 'PRIVATE' },
  { name: 'Alle type klanten', value: null }
]);

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
</script>

<style scoped>
.flexbox-column {
  display: flex;
  flex-direction: column;
}

.mb-1 {
  margin-bottom: 1rem;
}

.data-label {
  font-weight: bold;
}
</style>