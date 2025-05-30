<script setup>
import { Head, Link } from "@inertiajs/vue3";
import { ref, onMounted, watch, computed, reactive } from "vue";
import Layout from "@/Layouts/Layout.vue";
import Step1Component from "./MultiForm/Step1Component.vue";
import Step2Component from "./MultiForm/Step2Component.vue";
import Step3Component from "./MultiForm/Step3Component.vue";
import FormStep from "./MultiForm/FormStep.vue";
import StepComponent from "./MultiForm/StepComponent.vue";


// Definir los pasos
const steps = ref([
    { key: 'step1', component: Step1Component },
    { key: 'step2', component: Step2Component },
    { key: 'step3', component: Step3Component },
    { key: 'step4', component: Step3Component },
    { key: 'step5', component: Step3Component },
    { key: 'step6', component: Step3Component },
    { key: 'step7', component: Step3Component },
    { key: 'step8', component: Step3Component },
    { key: 'step9', component: Step3Component },
    { key: 'step10', component: Step3Component },
]);

// Datos del formulario
const formData = ref({
    step1: { name: '' },
    step2: { email: '' },
    step3: { password: '' },
    step4: { password_confirmation: '' },
    step5: { password_confirmation: '' },
    step6: { password_confirmation: '' },
    step7: { password_confirmation: '' },
    step8: { password_confirmation: '' },
    step9: { password_confirmation: '' },
    step10: { password_confirmation: '' },
});

// Estado para manejar el paso actual
const currentStep = ref(0);

// Comprobar si es el último paso
const isLastStep = computed(() => currentStep.value === fields.length - 1);

// Funciones para cambiar de paso
const nextStep = () => {
    if (currentStep.value < fields.length - 1) {
        currentStep.value++;
    }
};

const prevStep = () => {
    if (currentStep.value > 0) {
        currentStep.value--;
    }
};

// Función para enviar el formulario
const submitForm = () => {
    console.log('Formulario enviado:', formData);
    // Aquí puedes manejar el envío del formulario
};

/***********************************************************************/
// Definimos el formulario reactivo
const reactFormData = reactive({})

onMounted(() => {
    for (let i = 0; i < 5; i++) {
        addField()
    }
})
// Definimos los campos dinámicos del formulario
const fields = reactive([
    // { label: 'Nombre', name: 'nombre', type: 'text' },
    // { label: 'Edad', name: 'edad', type: 'number' }
])

// Función para añadir un nuevo campo dinámico
const addField = () => {
    const newField = {
        name: `field${fields.length + 1}`,
        key: fields.length + 1,
        label: `Campo ${fields.length + 1}`,
        name: `campo${fields.length + 1}`,
        type: 'text' // Puedes hacer esto dinámico
    }
    fields.push(newField)
    reactFormData[newField.name] = '' // Inicializamos el nuevo campo en formData
}

console.log({ fields });

// Función para eliminar un campo
const removeField = (index) => {
    const fieldName = fields[index].name
    delete reactFormData[fieldName] // Eliminamos del formData
    fields.splice(index, 1) // Eliminamos del array de campos
}

// Función para manejar el submit y convertir los datos en FormData
const submitReactiveForm = () => {
    const formDataToSend = new FormData()

    for (const key in reactFormData) {
        formDataToSend.append(key, reactFormData[key])
    }

    // Aquí enviarías el formDataToSend, por ejemplo, con Axios
    console.log([...formDataToSend.entries()]) // Para ver los datos en consola
}

</script>


<template>
    <Layout :titulo="title" :subTitulo="subTitle">

        <Head title="Departamento" />
        <div>

            <!-- <FormStep v-for="(step, index) in steps" :key="index" :visible="currentStep === index">
                <component :is="step.component" v-model="formData[step.key]" />
            </FormStep> -->
            <!-- Componente StepComponent reutilizable -->
            <!-- Swap fields for each step or other -->
            {{ fields }}
            <StepComponent v-for="(field, index) in fields" :key="index" :step="index + 1" :name="index + 1"
                :visible="currentStep === index" v-model="reactFormData[field]" />

            <div class="navigation">
                <button @click="prevStep" :disabled="currentStep === 0">Previous</button>
                <button @click="nextStep" v-if="!isLastStep">Next</button>
                <button @click="submitReactiveForm" v-if="isLastStep">Submit</button>
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
</style>
