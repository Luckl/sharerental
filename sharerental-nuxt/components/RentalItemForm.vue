<script setup lang="ts">
import {ref, watch} from "vue";
import * as yup from "yup";
import {useForm} from "vee-validate";
import {useToast} from "primevue/usetoast";
import {DisplayStatus, type RentalItem} from "~/schemas/openapi/rentalItem";
import SrNumberField from "~/components/SrNumberField.vue";
import SrTextField from "~/components/SrTextField.vue";

const props = defineProps<{
  modelValue: RentalItem | undefined;
}>();

const emits = defineEmits(['update:modelValue']);

const existingRentalItemId = ref(0)
const existingRentalItemDisplayStatus = ref(DisplayStatus.Inactive)
const toast = useToast();

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

const renterTypes = ref([
  {name: 'Bedrijven', value: 'BUSINESS'},
  {name: 'Particulieren', value: 'PRIVATE'},
  {name: 'Alle type klanten', value: null}
]);

const schema = yup.object({
  rentalItem: yup.object({
    name: yup.string().required().label("Weergavenaam"),
    externalReference: yup.string().label("Eigen referentie"),
    category: yup.string().required().label("Categorie"),
    shortDescription: yup.string().label("Korte omschrijving"),
    longDescription: yup.string().label("Lange omschrijving"),
    rentToRenterType: yup.string().label("Verhuren aan"),
    automaticallyAcceptTransaction: yup.boolean().label("Automatisch accepteren"),
    deliveryPossible: yup.boolean().label("Bezorgen mogelijk"),
    deliveryPrice: yup.number().when('deliveryPossible', ([deliveryPossible], deliveryPrice) => {
      return deliveryPossible ? deliveryPrice.required() : deliveryPrice;
    }),
    price24h: yup.number().required().label("Prijs per dag"),
    price168h: yup.number().nullable(true).label("Prijs per week"),
    deposit: yup.number().required().label("Borg"),
    amount: yup.number().required().label("Aantal"),
    brand: yup.string().label("Merk"),
    intrinsicWeightKilograms: yup.number().label("Gewicht"),
    // Add conditional fields based on category
    materialType: yup.string().when('category', ([category], materialType) => {
          if (category === 'Stijgers, trappen en hoogwerkers') {
            return materialType;
          } else {
            return materialType;
          }
        }
    ),
    reachMeters: yup.number().when('category', ([category], reachMeters) => {
      if (category === 'Stijgers, trappen en hoogwerkers' || category === 'Hef-hijswerktuigen') {
        return reachMeters;
      } else {
        return reachMeters;
      }
    }),
    carryingWeightKilograms:
        yup.number().when('category', ([category], carryingWeightKilograms) => {
          if (category === 'Stijgers, trappen en hoogwerkers' || category === 'Hef-hijswerktuigen') {
            return carryingWeightKilograms;
          } else {
            return carryingWeightKilograms;
          }
        }),
    maximumWorkHeightMeters:
        yup.number().when('category', ([category], maximumWorkHeightMeters) => {
          if (category === 'Stijgers, trappen en hoogwerkers') {
            return maximumWorkHeightMeters;
          } else {
            return maximumWorkHeightMeters;
          }
        }),
    maximumPressureBars:
        yup.number().when('category', ([category], maximumPressureBars) => {
          if (category === 'Luchtdrukgereedschap') {
            return maximumPressureBars;
          } else {
            return maximumPressureBars;
          }
        }),
    maximumHorsePower:
        yup.number().when('category', ([category], maximumHorsePower) => {
          if (category === 'Luchtdrukgereedschap') {
            return maximumHorsePower;
          } else {
            return maximumHorsePower;
          }
        }),
    requiredPowerVoltageVolt:
        yup.number().when('category', ([category], requiredPowerVoltageVolt) => {
          if (category === 'Electrisch gereedschap' || category === 'Verwarmen, drogen en reinigen') {
            return requiredPowerVoltageVolt;
          } else {
            return requiredPowerVoltageVolt;
          }
        }),
    workWidthMeters:
        yup.number().when('category', ([category], workWidthMeters) => {
          if (category === 'Betonbewerking') {
            return workWidthMeters;
          } else {
            return workWidthMeters;
          }
        }),
    vacuumAttachmentPossible:
        yup.boolean().when('category', ([category], vacuumAttachmentPossible) => {
          if (category === 'Betonbewerking') {
            return vacuumAttachmentPossible;
          } else {
            return vacuumAttachmentPossible;
          }
        }),
    capacityLiters:
        yup.number().when('category', ([category], capacityLiters) => {
          if (category === 'Grondverzetters, bouwmachines en tuinmateriaal') {
            return capacityLiters;
          } else {
            return capacityLiters;
          }
        }),
    itemHeight:
        yup.number().when('category', ([category], itemHeight) => {
          if (category === 'Evenementen') {
            return itemHeight;
          } else {
            return itemHeight;
          }
        }),
    itemWidth:
        yup.number().when('category', ([category], itemWidth) => {
          if (category === 'Evenementen') {
            return itemWidth;
          } else {
            return itemWidth;
          }
        }),
    itemLength:
        yup.number().when('category', ([category], itemLength) => {
          if (category === 'Evenementen') {
            return itemLength;
          } else {
            return itemLength;
          }
        }),
    powerWatt:
        yup.number().when('category', ([category], powerWatt) => {
          if (category === 'Verwarmen, drogen en reinigen') {
            return powerWatt;
          } else {
            return powerWatt;
          }
        }),
    maximumSurfaceSquareMeters:
        yup.number().when('category', ([category], maximumSurfaceSquareMeters) => {
          if (category === 'Verwarmen, drogen en reinigen') {
            return maximumSurfaceSquareMeters;
          } else {
            return maximumSurfaceSquareMeters;
          }
        })
  })
});

const {defineField, values, validate, errors} = useForm({
  validationSchema: schema,
  initialValues: {
    rentalItem: {
      id: 0,
      name: "",
      externalReference: "",
      category: undefined,
      shortDescription: undefined,
      longDescription: undefined,
      rentToRenterType: undefined,
      automaticallyAcceptTransaction: false,
      deliveryPossible: false,
      deliveryPrice: undefined,
      price24h: undefined,
      price48h: undefined,
      price168h: undefined,
      deposit: 0,
      amount: 1,
      brand: undefined,
      intrinsicWeightKilograms: undefined,
      reachMeters: undefined,
      carryingWeightKilograms: undefined,
      maximumWorkHeightMeters: undefined,
      maximumPressureBars: undefined,
      maximumHorsePower: undefined,
      requiredPowerVoltageVolt: undefined,
      workWidthMeters: undefined,
      vacuumAttachmentPossible: false,
      capacityLiters: undefined,
      itemHeight: undefined,
      itemWidth: undefined,
      itemLength: undefined,
      powerWatt: undefined,
      maximumSurfaceSquareMeters: undefined,
      materialType: undefined
    }
  }
});

const [name] = defineField('rentalItem.name');
const [externalReference] = defineField('rentalItem.externalReference');
const [category] = defineField('rentalItem.category');
const [shortDescription] = defineField('rentalItem.shortDescription');
const [longDescription] = defineField('rentalItem.longDescription');
const [rentToRenterType] = defineField('rentalItem.rentToRenterType');
const [automaticallyAcceptTransaction] = defineField('rentalItem.automaticallyAcceptTransaction');
const [deliveryPossible] = defineField('rentalItem.deliveryPossible');
const [deliveryPrice] = defineField('rentalItem.deliveryPrice');
const [price24h] = defineField('rentalItem.price24h');
const [price168h] = defineField('rentalItem.price168h');
const [deposit] = defineField('rentalItem.deposit');
const [amount] = defineField('rentalItem.amount');
const [brand] = defineField('rentalItem.brand');
const [intrinsicWeightKilograms] = defineField('rentalItem.intrinsicWeightKilograms');
const [reachMeters] = defineField('rentalItem.reachMeters');
const [carryingWeightKilograms] = defineField('rentalItem.carryingWeightKilograms');
const [maximumWorkHeightMeters] = defineField('rentalItem.maximumWorkHeightMeters');
const [maximumPressureBars] = defineField('rentalItem.maximumPressureBars');
const [maximumHorsePower] = defineField('rentalItem.maximumHorsePower');
const [requiredPowerVoltageVolt] = defineField('rentalItem.requiredPowerVoltageVolt');
const [workWidthMeters] = defineField('rentalItem.workWidthMeters');
const [vacuumAttachmentPossible] = defineField('rentalItem.vacuumAttachmentPossible');
const [capacityLiters] = defineField('rentalItem.capacityLiters');
const [itemHeight] = defineField('rentalItem.itemHeight');
const [itemWidth] = defineField('rentalItem.itemWidth');
const [itemLength] = defineField('rentalItem.itemLength');
const [powerWatt] = defineField('rentalItem.powerWatt');
const [maximumSurfaceSquareMeters] = defineField('rentalItem.maximumSurfaceSquareMeters');
const [materialType] = defineField('rentalItem.materialType');

watch(() => props.modelValue, (value) => {
  if (value) {
    existingRentalItemId.value = value.id
    existingRentalItemDisplayStatus.value = value.displayStatus
    name.value = value.name
    externalReference.value = value.externalReference
    category.value = value.category
    shortDescription.value = value.shortDescription
    longDescription.value = value.longDescription
    rentToRenterType.value = value.rentToRenterType
    automaticallyAcceptTransaction.value = value.automaticallyAcceptTransaction
    deliveryPossible.value = value.deliveryPossible
    deliveryPrice.value = value.deliveryPrice
    price24h.value = value.price24h
    price168h.value = value.price168h
    deposit.value = value.deposit
    amount.value = value.amount
    brand.value = value.brand
    intrinsicWeightKilograms.value = value.intrinsicWeightKilograms
    reachMeters.value = value.reachMeters
    carryingWeightKilograms.value = value.carryingWeightKilograms
    maximumWorkHeightMeters.value = value.maximumWorkHeightMeters
    maximumPressureBars.value = value.maximumPressureBars
    maximumHorsePower.value = value.maximumHorsePower
    requiredPowerVoltageVolt.value = value.requiredPowerVoltageVolt
    workWidthMeters.value = value.workWidthMeters
    vacuumAttachmentPossible.value = value.vacuumAttachmentPossible
    capacityLiters.value = value.capacityLiters
    itemHeight.value = value.itemHeight
    itemWidth.value = value.itemWidth
    itemLength.value = value.itemLength
    powerWatt.value = value.powerWatt
    maximumSurfaceSquareMeters.value = value.maximumSurfaceSquareMeters
    materialType.value = value.materialType

    updateModelValue(value)
  }
})

watch(values, (value) => {
  const tmpRentalItem: RentalItem = {...value.rentalItem}
  tmpRentalItem.id = existingRentalItemId.value
  tmpRentalItem.displayStatus = existingRentalItemDisplayStatus.value
  updateModelValue(tmpRentalItem)
})

const updateModelValue = (value: RentalItem | undefined) => {
  emits('update:modelValue', value);
};

const submitRentalItemForm = async () => {
  const isValid = await validate();
  if (!isValid.valid) {
    toast.add({severity: 'error', summary: 'Er is iets fout gegaan', detail: 'Controleer de velden.', life: 5000});
    return false;
  }
  return true;
};

defineExpose({
  submitRentalItemForm
});
</script>

<template>
  <form novalidate>

    <div class="flex gap-2">
      <sr-text-field label="Weergavenaam" v-model="name"
                     :errors="errors['rentalItem.name']"></sr-text-field>
    </div>
    <div class="flex gap-2">
      <sr-text-field label="Eigen referentie" v-model="externalReference"
                     :errors="errors['rentalItem.externalReference']"></sr-text-field>
    </div>
    <div class="flex gap-2">
      <div class="w-full">
        <div class="my-2">
          <Dropdown inputId="category" placeholder="Categorie" :pt="{ root: 'w-full' }"
                    v-model="category" :options="categories" optionLabel="name"
                    option-value="name" aria-describedby="categoryhelp">
          </Dropdown>
        </div>
        <small id="categoryhelp" class="p-error">{{ errors['rentalItem.category'] }}</small>
      </div>
    </div>

    <Divider align="left" type="solid" class="mb-1">
      <span>Omschrijving</span>
    </Divider>
    <div class="flex gap-2">
      <div class="w-full">
        <div class="my-2">
          <Textarea inputId="shortDescription" placeholder="Korte omschrijving" :pt="{ root: 'w-full' }"
                    v-model="shortDescription" aria-describedby="shortDescriptionHelp"
                    :class="{ 'p-invalid': errors }">
          </Textarea>
        </div>
        <small id="shortDescriptionHelp" class="p-error">{{ errors['rentalItem.shortDescription'] }}</small>
      </div>
    </div>
    <div class="flex gap-2">
      <div class="w-full">
        <div class="my-2">
          <Textarea inputId="longDescription" placeholder="Lange omschrijving" :pt="{ root: 'w-full h-40' }"
                    v-model="longDescription" aria-describedby="longDescriptionhelp"
                    :class="{ 'p-invalid': errors }">
          </Textarea>
        </div>
        <small id="longDescriptionhelp" class="p-error">{{ errors['rentalItem.longDescription'] }}</small>
      </div>
    </div>
    <div class="flex gap-2">
      <div class="w-full">
        <label for="input" class="block text-sm font-medium text-gray-700">Verhuren aan</label>
        <div class="my-2">
          <Dropdown inputId="rentToRenterType" placeholder="Alle type klanten" :pt="{ root: 'w-full' }"
                    v-model="rentToRenterType" :options="renterTypes" option-value="value"
                    option-label="name" aria-describedby="rentToRenterTypehelp" >
          </Dropdown>
        </div>
        <small id="rentToRenterTypehelp" class="p-error">{{ errors['rentalItem.rentToRenterType'] }}</small>
      </div>
    </div>

    <Divider align="left" type="solid" class="mb-1">
      <span>Verhuur voorwaarden</span>
    </Divider>
    <div class="flex gap-2">
      <div class="w-full">
        <div class="my-2">
          <Checkbox inputId="automaticallyAcceptTransaction" v-model="automaticallyAcceptTransaction" binary
                    aria-describedby="automaticallyAcceptTransactionhelp" :class="{ 'p-invalid': errors }">
          </Checkbox>
          <label for="automaticallyAcceptTransaction" class="ml-2">Automatisch accepteren</label>
        </div>
        <small id="automaticallyAcceptTransactionhelp" class="p-error">{{ errors['rentalItem.automaticallyAcceptTransaction'] }}</small>
      </div>
    </div>

    <div class="flex gap-2">
      <div class="w-full">
        <div class="my-2">
          <Checkbox inputId="deliveryPossible" v-model="deliveryPossible" binary
                    aria-describedby="deliveryPossiblehelp" :class="{ 'p-invalid': errors }">
          </Checkbox>
          <label for="deliveryPossible" class="ml-2">Bezorgen mogelijk</label>
        </div>
        <small id="deliveryPossiblehelp" class="p-error">{{ errors['rentalItem.deliveryPossible'] }}</small>
      </div>
    </div>
    <div v-if="deliveryPossible" class="flex gap-2">
      <sr-number-field label="Prijs voor bezorgen" v-model="deliveryPrice"
                       mode="currency" currency="EUR" locale="nl-NL"
                       :errors="errors['rentalItem.deliveryPrice']"></sr-number-field>
    </div>

    <Divider align="left" type="solid" class="mb-1">
      <span>Prijs en kosten</span>
    </Divider>

    <div class="flex gap-2">
      <sr-number-field label="Prijs per dag (ex. btw)" v-model="price24h"
                       mode="currency" currency="EUR" locale="nl-NL"
                       :errors="errors['rentalItem.price24h']"></sr-number-field>
    </div>
    <div class="flex gap-2">
      <sr-number-field label="Prijs per week (ex. btw)" v-model="price168h"
                       mode="currency" currency="EUR" locale="nl-NL"
                       :errors="errors['rentalItem.price168h']"></sr-number-field>
    </div>

    <div class="flex gap-2">
      <sr-number-field label="Borg" v-model="deposit"
                       mode="currency" currency="EUR" locale="nl-NL"
                       :errors="errors['rentalItem.deposit']"></sr-number-field>
    </div>
    <div class="flex gap-2">
      <sr-number-field label="Aantal artikelen beschikbaar" v-model="amount"
                       :errors="errors['rentalItem.amount']"></sr-number-field>
    </div>

    <div class="flex gap-2">
      <sr-text-field label="Merk" v-model="brand"
                     :errors="errors['rentalItem.brand']"></sr-text-field>
    </div>
    <div class="flex gap-2">
      <sr-number-field label="Gewicht (kg)" v-model="intrinsicWeightKilograms"
                       :maxFractionDigits="5" suffix=" kg"
                       :errors="errors['rentalItem.intrinsicWeightKilograms']"></sr-number-field>
    </div>
    <div v-if="category === 'Stijgers, trappen en hoogwerkers'"
         class="flex gap-2">
      <sr-number-field label="Bereik (m)" v-model="reachMeters"
                       :maxFractionDigits="5" suffix=" m"
                       :errors="errors['rentalItem.reachMeters']"></sr-number-field>
    </div>
    <div v-if="category === 'Stijgers, trappen en hoogwerkers'"
         class="flex gap-2">
      <sr-number-field label="Hefvermogen (kg)" v-model="carryingWeightKilograms"
                       :maxFractionDigits="5" suffix=" kg"
                       :errors="errors['rentalItem.carryingWeightKilograms']"></sr-number-field>
    </div>
    <div v-if="category === 'Stijgers, trappen en hoogwerkers'"
         class="flex gap-2">
      <sr-number-field label="Maximale werkhoogte
        (m)" v-model="maximumWorkHeightMeters"
                       :maxFractionDigits="5" suffix=" m"
                       :errors="errors['rentalItem.maximumWorkHeightMeters']"></sr-number-field>
    </div>
    <div v-if="category === 'Luchtdrukgereedschap'"
         class="flex gap-2">
      <sr-number-field label="Maximale druk (bar)" v-model="maximumPressureBars"
                       :maxFractionDigits="5" suffix=" bar"
                       :errors="errors['rentalItem.maximumPressureBars']"></sr-number-field>
    </div>
    <div v-if="category === 'Luchtdrukgereedschap'"
         class="flex gap-2">
      <sr-number-field label="Maximaal vermogen (pk)" v-model="maximumHorsePower"
                       :maxFractionDigits="5" suffix=" pk"
                       :errors="errors['rentalItem.maximumHorsePower']"></sr-number-field>
    </div>
    <div v-if="category === 'Electrisch gereedschap'"
         class="flex gap-2">
      <sr-number-field label="Vereist voltage (V)" v-model="requiredPowerVoltageVolt"
                       :maxFractionDigits="5" suffix=" V"
                       :errors="errors['rentalItem.requiredPowerVoltageVolt']"></sr-number-field>
    </div>
    <div v-if="category === 'Betonbewerking'"
         class="flex gap-2">
      <sr-number-field label="Werkbreedte (m)" v-model="workWidthMeters"
                       :maxFractionDigits="5" suffix=" m"
                       :errors="errors['rentalItem.workWidthMeters']"></sr-number-field>
    </div>
    <div v-if="category === 'Betonbewerking'"
         class="flex gap-2">
      <div class="w-full">
        <div class="my-2">
          <Checkbox inputId="vacuumAttachmentPossible" v-model="vacuumAttachmentPossible"
                    :maxFractionDigits="5" binary
                    aria-describedby="vacuumAttachmentPossiblehelp" :class="{ 'p-invalid': errors }">
          </Checkbox>
          <label for="vacuumAttachmentPossible" class="ml-2">Vacuum mogelijk</label>
        </div>
        <small id="vacuumAttachmentPossiblehelp" class="p-error">{{ errors['rentalItem.vacuumAttachmentPossible'] }}</small>
      </div>
    </div>
    <div v-if="category === 'Grondverzetters, bouwmachines en tuinmateriaal'"
         class="flex gap-2">
      <sr-number-field label="Capaciteit (l)" v-model="capacityLiters"
                       :maxFractionDigits="5" suffix=" l"
                       :errors="errors['rentalItem.capacityLiters']"></sr-number-field>
    </div>
    <div v-if="category === 'Evenementen'"
         class="flex gap-2">
      <sr-number-field label="Hoogte (cm)" v-model="itemHeight"
                       :maxFractionDigits="5" suffix=" cm"
                       :errors="errors['rentalItem.itemHeight']"></sr-number-field>
    </div>
    <div v-if="category === 'Evenementen'"
         class="flex gap-2">
      <sr-number-field label="Breedte (cm)" v-model="itemWidth"
                       :maxFractionDigits="5" suffix=" cm"
                       :errors="errors['rentalItem.itemWidth']"></sr-number-field>
    </div>
    <div v-if="category === 'Evenementen'"
         class="flex gap-2">
      <sr-number-field label="Lengte (cm)" v-model="itemLength"
                       :maxFractionDigits="5" suffix=" cm"
                       :errors="errors['rentalItem.itemLength']"></sr-number-field>
    </div>
    <div v-if="category === 'Verwarmen, drogen en reinigen'"
         class="flex gap-2">
      <sr-number-field label="Vermogen (W)" v-model="powerWatt"
                       :maxFractionDigits="5" suffix=" W"
                       :errors="errors['rentalItem.powerWatt']"></sr-number-field>
    </div>
    <div v-if="category === 'Verwarmen, drogen en reinigen'"
         class="flex gap-2">
      <sr-number-field label="Maximale oppervlakte (m²)" v-model="maximumSurfaceSquareMeters"
                       :maxFractionDigits="5" suffix=" m²"
                       :errors="errors['rentalItem.maximumSurfaceSquareMeters']"></sr-number-field>
    </div>
    <div v-if="category === 'Stijgers, trappen en hoogwerkers'"
         class="flex gap-2">
      <sr-text-field label="Materiaal type" v-model="materialType"
                     :errors="errors['rentalItem.materialType']"></sr-text-field>
    </div>
  </form>
</template>
