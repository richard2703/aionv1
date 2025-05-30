<script setup>
import PrimaryButton from '@/Components/PrimaryButton.vue';
import Layout from '@/Layouts/Layout.vue';
import { Head, Link } from '@inertiajs/vue3';
import { onMounted, ref } from 'vue';

const props = defineProps({
    evaluacion: Object,
    usuario: Object
});

const title = "assessment";
const subTitle = "evaluaciones";
const evaluacion = ref(props.evaluacion);
const usuario = ref(props.usuario);
const incompleto = ref();
const completo = ref();

onMounted(() => {
    incompleto.value = 'p-6 w-full bg-yellow-200 border-b border-gray-200 hover:bg-gray-50 cursor-pointer block flex justify-between';
    completo.value = 'p-6 w-full bg-green-300 border-b border-gray-200-gray-50 block flex justify-between cursor-not-allowed';
})
const goToEvaluacion = (assessment_asignado) => {
    if (assessment_asignado.estatus === "INCOMPLETO") {
        window.location.href = route('evaluacion.form', assessment_asignado.id);
    }
}
console.log({ evaluacion: props.evaluacion });
function formatNumber(value) {
    if (value == null) return ''; // Manejar el caso cuando el valor es nulo o indefinido
    return parseFloat(value).toFixed(2);
}
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
                <Link :href="route('evaluacion.index')" class="px-1">
                <h3>Evaluaciones -</h3>
                </Link>
                <Link href="#" class="active">
                <h3>Selector</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>

                    <div class="p-4 bg-white border-b border-gray-200">
                        <div v-for="(pilar, key) in evaluacion">
                            <div
                                v-if="($page.props.auth.user.roles.includes('lider_pilar') && usuario.area_id == pilar[0].seccion.area_id) || $page.props.auth.user.roles.includes('superadmin')">
                                <h3 class="text-lg font-medium leading-6 text-gray-900">{{ key }}</h3>
                                <br>
                                <button v-for="assessmentAsignado in pilar" class="w-full"
                                    @click=" goToEvaluacion(assessmentAsignado)"
                                    :class="[assessmentAsignado.estatus === 'INCOMPLETO' ? incompleto : completo]">
                                    <div class="w-full flex justify-between">
                                        <span class="w-full text-left">{{ assessmentAsignado.seccion.titulo }}</span>
                                        <span class="w-full">{{ formatNumber(assessmentAsignado.promedio_seccion) ??
                                            'N/A'
                                            }}</span>
                                        <span class="w-full">{{ assessmentAsignado.estatus }}</span>
                                    </div>
                                </button>
                                <br>
                                <hr>
                                <br>
                            </div>
                        </div>
                        <div v-if="!$page.props.auth.user.roles.includes('superadmin')">
                            <div class="p-4 bg-white border-b border-gray-200 text-center rounded">

                                Este módulo está reservado para líderes de pilar, para mayor información contacta
                                con el
                                administrador.
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </Layout>
</template>
