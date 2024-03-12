import PrimeVue from 'primevue/config'
import Button from 'primevue/button'
import InputText from 'primevue/inputtext'
import Toast from 'primevue/toast'
import ToastService from 'primevue/toastservice'
import Password from "primevue/password";
import Message from "primevue/message";
import Card from "primevue/card";
import Sidebar from "primevue/sidebar";
import Editor from "primevue/editor";
import {defineNuxtPlugin} from "#app";
import Tooltip from "primevue/tooltip";
import RadioButton from "primevue/radiobutton";
import Divider from "primevue/divider";
import Column from "primevue/column";
import DataTable from "primevue/datatable";
import Dialog from "primevue/dialog";
import Dropdown from "primevue/dropdown";
import Textarea from "primevue/textarea";
import InputNumber from "primevue/inputnumber";
import Checkbox from "primevue/checkbox";
import FileUpload from "primevue/fileupload";
import Image from "primevue/image";
import InputSwitch from "primevue/inputswitch";
import Calendar from "primevue/calendar";
import Galleria from "primevue/galleria";
import Tag from "primevue/tag";
import Panel from "primevue/panel";
import Accordion from "primevue/accordion";
import AccordionTab from "primevue/accordiontab";

export default defineNuxtPlugin(nuxtApp => {
    nuxtApp.vueApp.use(PrimeVue, {
        pt: {
            sidebar: {
                header: {
                    class: 'gap-16'
                }
            }
        }
    })
    nuxtApp.vueApp.use(ToastService)
    nuxtApp.vueApp.component('Button', Button)
    nuxtApp.vueApp.component('InputText', InputText)
    nuxtApp.vueApp.component('Toast', Toast)
    nuxtApp.vueApp.component('Password', Password)
    nuxtApp.vueApp.component('Message', Message)
    nuxtApp.vueApp.component('Card', Card)
    nuxtApp.vueApp.component('Sidebar', Sidebar)
    nuxtApp.vueApp.component('Editor', Editor)
    nuxtApp.vueApp.component('RadioButton', RadioButton)
    nuxtApp.vueApp.component('Divider', Divider)
    nuxtApp.vueApp.component('DataTable', DataTable)
    nuxtApp.vueApp.component('Column', Column)
    nuxtApp.vueApp.component('Dialog', Dialog)
    nuxtApp.vueApp.component('Dropdown', Dropdown)
    nuxtApp.vueApp.component('Textarea', Textarea)
    nuxtApp.vueApp.component('InputNumber', InputNumber)
    nuxtApp.vueApp.component('Checkbox', Checkbox)
    nuxtApp.vueApp.component('FileUpload', FileUpload)
    nuxtApp.vueApp.component('Image', Image)
    nuxtApp.vueApp.component('InputSwitch', InputSwitch)
    nuxtApp.vueApp.component('Calendar', Calendar)
    nuxtApp.vueApp.component('Galleria', Galleria)
    nuxtApp.vueApp.component('Tag', Tag)
    nuxtApp.vueApp.component('Panel', Panel)
    nuxtApp.vueApp.component('Accordion', Accordion)
    nuxtApp.vueApp.component('AccordionTab', AccordionTab)

    nuxtApp.vueApp.directive('Tooltip', Tooltip)

    //other components that you need
})
