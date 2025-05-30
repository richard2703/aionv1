        <script setup>
        defineProps({
            modelValue: Object
        });

        const emit = defineEmits(['update:modelValue']);
</script>

<template>
    <div>
        <label for="password">Password:</label>
        <input v-model="modelValue.password" type="password" id="password" />
    </div>
</template>

