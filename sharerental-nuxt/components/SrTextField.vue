<script setup lang="ts">

const props = defineProps<{
  label: string,
  modelValue: string,
  errors: Partial<Record<string, string | undefined>>,
}>()

const emits = defineEmits(['update:modelValue'])

const updateModelValue = (value: string | undefined) => {
  emits('update:modelValue', value);
};

</script>
<template>
  <div>
    <label for="input">{{ label }}</label>
    <div>
      <InputText inputId="input"
                 :model-value="modelValue"
                 v-bind="$attrs"
                 aria-describedby="help"
                 @update:model-value="(value: string | undefined) => updateModelValue(value?.trim())"
                 :class="{ 'p-invalid': errors }"
      />
    </div>
    <small id="help" class="p-error">{{ errors }}</small>
  </div>
</template>