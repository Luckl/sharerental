<script setup lang="ts">
import {type Renter, RenterApi, RenterType} from "~/schemas/openapi/renter";
import * as yup from "yup";
import {useForm} from "vee-validate";
import {useUserStore} from "~/services/stores/userStore";
import {useToast} from "primevue/usetoast";
import {createUserWithEmailAndPassword} from "firebase/auth";
import {UserApi, UserUserTypeEnum, ZipcodeApi} from "~/schemas/openapi/contactForm";
import {RenterTypeEnum, useRenterTypeStore} from "~/services/stores/renterTypeStore";
import SrTextField from "~/components/SrTextField.vue";

const $renterApi: RenterApi = useNuxtApp().$renterApi;
const userApi: UserApi = useNuxtApp().$userApi;
const zipcodeApi: ZipcodeApi = useNuxtApp().$zipcodeApi;

defineProps<{
  modelValue: Renter | undefined
}>()

const renterTypeStore = storeToRefs(useRenterTypeStore())
const auth = useFirebaseAuth()! // only exists on client side
const userStore = useUserStore()
const toast = useToast()

const emits = defineEmits(['update:modelValue'])

const updateModelValue = (value: Renter | undefined) => {
  emits('update:modelValue', value);
};

onMounted(() => {
  if (userStore.user) {
    email.value = userStore.user.email ?? ""
    getRenter()
  } else {
    loadEmptyRenterObject()
  }
  subscribeToNewsletter.value = true
})

const loadEmptyRenterObject = () => {
  editRenterInfo.value = true
  renterType.value = renterTypeStore.renterType.value === RenterTypeEnum.Business ? RenterType.Business : RenterType.Private
}

const schema = yup.object({
  renter: yup.object({
    renterType: yup.mixed().oneOf([RenterType.Private, RenterType.Business]).required().label("Type huurder"),
    firstName: yup.string().required().label("Voornaam"),
    lastName: yup.string().required().label("Achternaam"),
    email: yup.string().email().required().label("Emailadres"),
    phoneNumber: yup.string().required().label("Telefoonnummer"),
    location: yup.object({
      street: yup.string().required().label("Straat"),
      houseNumber: yup.string().required().label("Huisnummer"),
      postalCode: yup.string().required().label("Postcode"),
      city: yup.string().required().label("Stad"),
      country: yup.string().required().label("Land"),
    }),
    companyName: yup.string()
        .when('renterType', ([renterType], companyName) => {
          return renterType === RenterType.Business
              ? companyName.required().label("Bedrijfsnaam")
              : companyName
        }),
    chamberOfCommerce: yup.string()
        .when('renterType', ([renterType], chamberOfCommerce) => {
          return renterType === RenterType.Business
              ? chamberOfCommerce.required().label("KvK nummer")
              : chamberOfCommerce
        }),
    vatNumber: yup.string()
        .when('renterType', ([renterType], vatNumber) => {
          return renterType === RenterType.Business
              ? vatNumber.label("BTW nummer (optioneel)")
              : vatNumber
        })
  }),
  createAccount: yup.boolean().label("Maak een account aan"),
  password: yup.string()
      .when('createAccount',
          ([createAccount], password) =>
              createAccount === true
                  ? password.label("Wachtwoord").required().min(6)
                  : password),
  passwordConfirm: yup.string()
      .when('createAccount',
          ([createAccount], passwordConfirm) =>
              createAccount === true
                  ? passwordConfirm.label("Wachtwoord herhalen").required().oneOf([yup.ref('password')], 'Wachtwoorden moeten overeenkomen')
                  : passwordConfirm),
  subscribeToNewsletter: yup.boolean().label("Hou me op de hoogte over nieuws en aanbiedingen")
});

const {defineField, errors, values, validate} = useForm({
  validationSchema: schema,
  initialValues: {
    renter: {
      id: 0,
      renterType: renterTypeStore.renterType.value === RenterTypeEnum.Business ? RenterType.Business : RenterType.Private,
      firstName: "",
      lastName: "",
      email: "",
      phoneNumber: "",
      location: {
        street: "",
        houseNumber: "",
        postalCode: "",
        city: "",
        country: ""
      },
      companyName: "",
      chamberOfCommerce: "",
      vatNumber: ""
    },
    createAccount: false,
    password: "",
    passwordConfirm: "",
    subscribeToNewsletter: true
  }
});

watch(values, (value) => {
  const tmpRenter = {...value.renter}
  tmpRenter.id = existingRenterId.value
  updateModelValue(tmpRenter)
})

const [createAccount] = defineField("createAccount")
const [renterType] = defineField("renter.renterType")
const [firstName] = defineField("renter.firstName")
const [lastName] = defineField("renter.lastName")
const [email] = defineField("renter.email")
const [phoneNumber] = defineField("renter.phoneNumber")
const [street] = defineField("renter.location.street")
const [houseNumber] = defineField("renter.location.houseNumber")
const [postalCode] = defineField("renter.location.postalCode")
const [city] = defineField("renter.location.city")
const [country] = defineField("renter.location.country")
const [companyName] = defineField("renter.companyName")
const [chamberOfCommerce] = defineField("renter.chamberOfCommerce")
const [vatNumber] = defineField("renter.vatNumber")
const [password] = defineField("password")
const [passwordConfirm] = defineField("passwordConfirm")
const [subscribeToNewsletter] = defineField("subscribeToNewsletter")

const existingRenterId = ref(0);
const editRenterInfo = ref(false);

const submitForm = async () => {
  return await validate()
      .then((result => {
        if (!result.valid) {
          return false
        }

        if (createAccount.value) {
          createUserWithEmailAndPassword(auth, email.value, password.value)
              .then(() => {
                    userStore.refreshUser()
                        .then(() =>
                            userApi.registerUser({
                              user: {
                                userType: UserUserTypeEnum.Renter
                              }
                            })
                        )
                  },
                  (reason) => {
                    toast.add({
                      severity: 'error', summary: 'Er is iets fout gegaan', detail: reason,
                      life: 5000
                    })
                  })
        }
        return true
  }))
}

const fetchZipInfo = async () => {
  if (postalCode.value.length === 6 && houseNumber.value.length > 0) {
    const response = await zipcodeApi.getAddressByZipcode({
      zipcode: postalCode.value,
      houseNumber: houseNumber.value
    })

    street.value = response.street ?? ""
    city.value = response.city ?? ""
    country.value = response.country ?? ""
  }
}

function getRenter() {
  $renterApi.getRenter().then(
      success => {

        renterTypeStore.renterType.value = success.renterType === RenterType.Business ? RenterTypeEnum.Business : RenterTypeEnum.Private

        existingRenterId.value = success.id
        renterType.value = success.renterType
        email.value = success.email
        firstName.value = success.firstName
        lastName.value = success.lastName
        phoneNumber.value = success.phoneNumber
        street.value = success.location.street ?? ""
        houseNumber.value = success.location.houseNumber ?? ""
        postalCode.value = success.location.postalCode ?? ""
        city.value = success.location.city ?? ""
        country.value = success.location.country ?? ""
        companyName.value = success.companyName ?? ""
        chamberOfCommerce.value = success.chamberOfCommerce ?? ""
        vatNumber.value = success.vatNumber ?? ""

        updateModelValue(success)
      },
      () => {
        loadEmptyRenterObject()
      }
  )
}


defineExpose({
  submitForm
})
</script>
<template>
  <div v-if="!editRenterInfo">
    <span class="p-text-secondary block mb-5">Controleer je gegevens.</span>
    <div class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">Email</div>
      <div>{{ modelValue?.email }}</div>
    </div>
    <div class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">Type huurder</div>
      <div>{{ modelValue?.renterType === RenterType.Business ? 'Zakelijk' : 'Particulier' }}</div>
    </div>
    <div class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">Naam</div>
      <div>{{ modelValue?.firstName }}</div>
    </div>
    <div class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">Achternaam</div>
      <div>{{ modelValue?.lastName }}</div>
    </div>
    <div class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">Telefoonnummer</div>
      <div>{{ modelValue?.phoneNumber }}</div>
    </div>

    <div v-if="modelValue?.renterType === RenterType.Business" class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">Bedrijfsnaam</div>
      <div>{{ modelValue?.companyName }}</div>
    </div>

    <div v-if="modelValue?.renterType === RenterType.Business" class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">KvK nummer</div>
      <div>{{ modelValue?.chamberOfCommerce }}</div>
    </div>

    <div v-if="modelValue?.renterType === RenterType.Business" class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">BTW nummer (optioneel)</div>
      <div>{{ modelValue?.vatNumber }}</div>
    </div>

    <div class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">Straat</div>
      <div>{{ modelValue?.location?.street }}</div>
    </div>
    <div class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">Huisnummer</div>
      <div>{{ modelValue?.location?.houseNumber }}</div>
    </div>
    <div class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">Postcode</div>
      <div>{{ modelValue?.location?.postalCode }}</div>
    </div>
    <div class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">Stad</div>
      <div>{{ modelValue?.location?.city }}</div>
    </div>
    <div class="flex flex-row-2 justify-between pr-20">
      <div class="font-bold">Land</div>
      <div>{{ modelValue?.location?.country }}</div>
    </div>
  </div>
  <div class="flex flex-col" v-else>
    <form novalidate>
      <span class="text-xl font-bold block mb-5">Vul je gegevens in.</span>
      <div class="flex gap-2">
        <div class="flex flex-row gap-8">
          <div class=" h-8 align-middle">
            <label for="Particulier" class="mr-2">Particulier</label>
            <RadioButton v-model="renterType" :value="RenterType.Private" binary inputId="Particulier"></RadioButton>
          </div>
          <div>
            <label for="Zakelijk" class="mr-2">Zakelijk</label>
            <RadioButton v-model="renterType" :value="RenterType.Business" binary inputId="Zakelijk"></RadioButton>
          </div>
        </div>
      </div>

      <div v-if="renterType === RenterType.Business" class="flex gap-2">
        <sr-text-field label="Bedrijfsnaam" v-model="companyName"
                       :errors="errors['renter.companyName']"></sr-text-field>
      </div>
      <div v-if="renterType === RenterType.Business" class="flex gap-2">
        <sr-text-field label="KvK nummer" v-model="chamberOfCommerce"
                       :errors="errors['renter.chamberOfCommerce']"></sr-text-field>
      </div>
      <div v-if="renterType === RenterType.Business" class="flex gap-2">
        <sr-text-field label="BTW nummer" v-model="vatNumber" :errors="errors['renter.vatNumber']"></sr-text-field>
      </div>

      <div class="flex gap-2">
        <sr-text-field label="Emailadres" :disabled="userStore.user" placeholder="Emailadres" type="email"
                       v-model="email"
                       :errors="errors['renter.email']"></sr-text-field>
      </div>
      <div class="flex gap-2 my-1 items-center">
        <Checkbox v-model="subscribeToNewsletter" binary></Checkbox>
        <div>
          <label for="subscribeToNewsletter">Hou me op de hoogte over nieuws en aanbiedingen</label>
        </div>
      </div>
      <div v-if="!userStore.user" class="flex gap-2 my-1 items-center">
        <Checkbox v-model="createAccount"
                  :class="{ 'p-invalid': errors.createAccount }"
                  binary
        ></Checkbox>
        <div>
          <label for="createAccount">Maak een account aan</label>
        </div>
      </div>
      <div class="flex gap-2" v-if="createAccount && !userStore.user">
        <sr-text-field label="Wachtwoord" type="password" v-model="password" :errors="errors.password"></sr-text-field>
      </div>
      <div class="flex gap-2" v-if="createAccount && !userStore.user">
        <sr-text-field label="Wachtwoord herhalen" type="password" v-model="passwordConfirm"
                       :errors="errors.passwordConfirm"></sr-text-field>
      </div>
      <divider></divider>
      <div class="flex gap-2">
        <sr-text-field label="Voornaam" v-model="firstName" :errors="errors['renter.firstName']"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Achternaam" v-model="lastName" :errors="errors['renter.lastName']"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Telefoonnummer" v-model="phoneNumber"
                       :errors="errors['renter.phoneNumber']"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Postcode" @change="fetchZipInfo()" v-model="postalCode"
                       :errors="errors['renter.location.postalCode']"></sr-text-field>
        <sr-text-field label="Huisnummer" @change="fetchZipInfo()" v-model="houseNumber"
                       :errors="errors['renter.location.houseNumber']"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Straat" disabled v-model="street"
                       :errors="errors['renter.location.street']"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Plaatsnaam" disabled v-model="city"
                       :errors="errors['renter.location.city']"></sr-text-field>
      </div>
      <div class="flex gap-2">
        <sr-text-field label="Land" disabled v-model="country"
                       :errors="errors['renter.location.country']"></sr-text-field>
      </div>
    </form>
  </div>
  <div v-if="!editRenterInfo">
    <Button type="button" label="Aanpassen" @click="editRenterInfo = true; existingRenterId = 0"></Button>
  </div>
</template>
