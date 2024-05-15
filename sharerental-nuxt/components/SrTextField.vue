<script setup lang="ts">

defineProps<{
  label: string,
  modelValue: string | null,
  errors: Partial<Record<string, string | undefined>>,
}>()

const emits = defineEmits(['update:modelValue'])

const updateModelValue = (value: string | undefined) => {
  emits('update:modelValue', value);
};

</script>
<template>
  <div class="w-full">
    <div class="my-2">
      <InputText inputId="input"
                 :placeholder="label"
                 :pt="{ root: 'w-full' }"
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