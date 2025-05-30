        <script setup>
        const props = defineProps({
            modelValue: Object,
            name: Number,
            step: Number,
            visible: {
                type: Boolean,
                default: false
            }
        });

        const emit = defineEmits(['update:modelValue']);
        console.log("step", props.step);
        console.log("key", props.name);
        console.log("props", props);


</script>

<template>
    <div v-if="visible">
        {{ step }}

        <!-- Renderiza contenido basado en el step actual -->
        <div v-if="step === name">
            <label for="name">{{ name }}:</label>
            <input type="text" id="name" />
        </div>

        <!--<div v-else-if="step === 2">
            <label for="email">Email:</label>
            <input v-model="modelValue.email" type="email" id="email" />
        </div>

        <div v-else-if="step === 3">
            <label for="password">Password:</label>
            <input v-model="modelValue.password" type="password" id="password" />
        </div> -->

        <!-- Puedes agregar más pasos dinámicamente -->
    </div>


</template>

