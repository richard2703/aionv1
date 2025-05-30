        <script setup>
        defineProps({
            modelValue: Object
        });

        const emit = defineEmits(['update:modelValue']);
</script>

<template>
    <div>
        <label for="name">Name:</label>
        <input v-model="modelValue.name" type="text" id="name" />
    </div>
</template>

