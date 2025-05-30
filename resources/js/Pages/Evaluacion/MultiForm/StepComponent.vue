<script setup>
import { ref, watch } from 'vue';
import ToggleButton from 'primevue/togglebutton';

const props = defineProps({
    modelValue: Object, // Parent's form data
    name: String,
    step: Number,
    challenge: Object, // Challenge object with options
    length: Number,
    visible: {
        type: Boolean,
        default: false
    }
});

const emit = defineEmits(['update:modelValue']);

// Local state
const challenge = ref(props.challenge);
const checked = ref(true); // Toggle between formal/informal
const selectedOption = ref(null); // Track selected radio option

// Watch selectedOption and emit changes to parent
watch(selectedOption, (newValue) => {
    // Emit the updated modelValue as an object, not a string
    console.log({ newValue });

    const updatedValue = {
        assessmentAsignado_id: props.modelValue.assessmentAsignado_id,
        assessment_id: props.modelValue.assessment_id,
        seccion_id: props.modelValue.seccion_id,
        area_id: props.modelValue.area_id,
        departamento_id: props.modelValue.departamento_id,
        challenge_id: challenge.value.id,
        opcion_id: newValue.id,
        valor_opcion: newValue.madurez,
        label: challenge.value.challenge
    };

    emit('update:modelValue', updatedValue);
});
</script>

<template>
    <div v-if="visible">
        <!-- Challenge Title -->
        <div>
            <h4 class="text-xl font-bold text-center">{{ challenge.challenge }}</h4>
        </div>

        <br>

        <!-- ToggleButton to switch between Formal and Informal -->
        <div class="card flex justify-center">
            <ToggleButton v-model="checked" class="w-24" onLabel="Formal" offLabel="Informal" />
        </div>

        <br>

        <!-- Render radio buttons based on checked (Formal/Informal) -->
        <div v-for="(opcion, index) in challenge.opciones" :key="index">
            <div v-if="checked" class="p-2 flex items-center gap-4 border rounded">
                <input type="radio" :id="'opcion-' + index + 1" :name="`opcion${step}`" :value="opcion"
                    v-model="selectedOption">
                <label class="w-full" :for="'opcion-' + index + 1">{{ opcion.formal }}</label><br>
            </div>
            <div v-else class="p-2 flex items-center gap-4 border rounded">
                <input type="radio" :id="'opcion-' + index + 1" :name="`opcion${step}`" :value="opcion"
                    v-model="selectedOption">
                <label class="w-full" :for="'opcion-' + index + 1">{{ opcion.informal }}</label><br>
            </div>
        </div>

        <br>
        <br>

        <!-- Step indicator -->
        <div class="text-center text-gray-500 text-xl">
            {{ step }} / {{ length }}
        </div>
    </div>
</template>

<style scoped>
/* You can add scoped styles here */
</style>
