        <script setup>
        defineProps({
            modelValue: Object
        });

        const emit = defineEmits(['update:modelValue']);
</script>

<template>
    <div>
        <label for="email">Email:</label>
        <input v-model="modelValue.email" type="email" id="email" />
    </div>
</template>

