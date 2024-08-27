<script setup lang="ts">

defineProps<{
  label: string,
  modelValue: number | null | undefined,
  errors:  string | undefined,
}>()

const emits = defineEmits(['update:modelValue'])

const updateModelValue = (value: string | undefined) => {
  emits('update:modelValue', value);
};

</script>
<template>
  <div class="w-full">
    <div class="my-2">
      <Label :for="$attrs.id" class="block text-sm font-medium text-gray-700">{{ label }}</Label>
      <InputNumber inputId="input"
                 :pt="{ root: 'w-full' }"
                 :model-value="modelValue"
                 v-bind="$attrs"
                 aria-describedby="help"
                 @update:model-value="(value: number | undefined) => updateModelValue(value)"
                 :class="{ 'p-invalid': errors }"
      />
    </div>
    <small id="help" class="p-error">{{ errors }}</small>
  </div>
</template>