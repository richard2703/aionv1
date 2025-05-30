<script setup>
import { Head, Link } from "@inertiajs/vue3";
import { ref, onMounted, watch, computed, reactive } from "vue";
import Layout from "@/Layouts/Layout.vue";
import StepComponent from "./MultiForm/StepComponent.vue";
import axios from "axios";

const props = defineProps({
    assessmentAsignado: Object,
});

const assessmentAsignado = ref(props.assessmentAsignado);
const seccion = ref(assessmentAsignado.value.seccion);
const challenges = ref(seccion.value.challenge);

// Estado para manejar el paso actual
const currentStep = ref(0);

// Comprobar si es el último paso
const isLastStep = computed(() => currentStep.value === fields.length - 1);

// Error handling for required fields
const errors = reactive({});

// Move to next step only if current step fields are valid
const nextStep = () => {
    if (validateStep(currentStep.value)) {
        if (currentStep.value < fields.length - 1) {
            currentStep.value++;
        }
    }
};

// Move to previous step
const prevStep = () => {
    if (currentStep.value > 0) {
        currentStep.value--;
    }
};

// Validate fields of the current step
const validateStep = (stepIndex) => {
    const currentField = reactFormData[`challenge${stepIndex + 1}`];
    if (!currentField.valor_opcion) {
        errors[stepIndex] = "***Este campo es obligatorio***";
        return false;
    } else {
        errors[stepIndex] = ""; // Clear errors if valid
        return true;
    }
};

// Reactive form data and dynamic fields
const reactFormData = reactive({});
const fields = reactive([]);
onMounted(() => {
    challenges.value.forEach((challenge, index) => {
        addField(challenge, index);
    });
});

// Function to add dynamic fields
const addField = (challenge, index) => {
    const newField = {
        assessmentAsignado_id: assessmentAsignado.value.id,
        assessment_id: assessmentAsignado.value.assessment_id,
        seccion_id: seccion.value.id,
        area_id: seccion.value.area_id,
        departamento_id: seccion.value.departamento_id,
        challenge_id: challenge.id,
        opcion_id: "",
        valor_opcion: "", // Required field
        label: challenge.challenge,
    };
    fields.push(newField);
    reactFormData[`challenge${index + 1}`] = newField;
};

// Submit function
const submitReactiveForm = () => {
    const formDataToSend = new FormData();
    for (const key in reactFormData) {
        console.log({ key: reactFormData[key] });

        formDataToSend.append(key, reactFormData[key]);
    }
    if (validateStep(currentStep.value)) {
        axios
            .post(route("evaluacion.store"), reactFormData)
            .then((response) => {
                window.location.href = route(
                    "evaluacion.select",
                    assessmentAsignado.value.assessment_id
                );
            });
    }
};
</script>

<template>
    <Layout :titulo="title" :subTitulo="subTitle">
        <Head title="Assessment" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Evaluaciones</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link href="#" class="px-1">
                    <h3>Assessment -</h3>
                </Link>
                <Link :href="route('evaluacion.index')" class="active">
                    <h3>Evaluaciones</h3>
                </Link>
            </div>
        </div>

        <div
            class="p-4 bg-white overflow-hidden shadow-xl sm:rounded-lg w-full"
        >
            <StepComponent
                v-for="(challenge, index) in challenges"
                :key="index"
                :step="index + 1"
                :name="challenge.challenge"
                :challenge="challenge"
                :length="challenges.length"
                :visible="currentStep === index"
                v-model="reactFormData[`challenge${index + 1}`]"
            />
            <span v-if="errors[currentStep]" class="text-lg">{{
                errors[currentStep]
            }}</span>

            <div
                class="navigation justify-evenly text-center text-gray-500 text-xl"
            >
                <button
                    class="hover:text-indigo-500"
                    @click="prevStep"
                    :disabled="currentStep === 0"
                >
                    Anterior
                </button>
                <button
                    class="hover:text-indigo-500"
                    @click="nextStep"
                    v-if="!isLastStep"
                >
                    Siguiente
                </button>
                <button
                    class="hover:text-indigo-500"
                    @click="submitReactiveForm"
                    v-if="isLastStep"
                >
                    Terminar
                </button>
            </div>
        </div>
    </Layout>
</template>

<style scoped>
.navigation {
    margin-top: 20px;
    display: flex;
    gap: 25px;
}

div > span {
    display: block;
    text-align: center;
    font-weight: bold;
    color: red;
}
</style>
