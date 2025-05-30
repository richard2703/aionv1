<script setup>
import { onMounted, ref } from "vue";
import { Head, Link, useForm } from "@inertiajs/vue3";
import axios from "axios";
import Layout from "@/Layouts/Layout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import AccionIndex from "@/Pages/sysGestion/Partials/Accion/AccionIndex.vue";
import KpiIndex from "@/Pages/sysGestion/Partials/Kpis/KpiIndex.vue";

const props = defineProps({
    user: Object,
    kpis: Array,
    areas: Array,
    departamentos: Array || null,
});

const title = "sysGestion";
const subTitle = "pdca";
const usuario = ref(props.user);
const areas = ref(props.areas);
const departamentos = ref([]);
const showCorrectivas = ref(false);
const showPreventivas = ref(false);
const showMejoras = ref(false);

const procesos = ref([]);


const form = useForm({
    area_id: usuario.value.area_id,
    departamento_id: usuario.value.departamento_id,
});

onMounted(() => {
    getAreas();
    getDepartamentos(usuario.value.area_id);
    getProcesos()
});

async function getAreas() {
    await axios
        .get("/api/areas")
        .then((response) => (areas.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}

async function getDepartamentos(userArea) {
    await axios
        .get(route("departamentos.byArea", userArea))
        .then((response) => {
            departamentos.value = response.data.departamentos
        })
        .catch((error) => {
            console.log(error);
        });
}

async function onChange(event) {
    const taget_id = event.target.value;
    await axios
        .get(route("departamentos.byArea", taget_id))
        .then((response) => (departamentos.value = response.data.departamentos))
        .catch((error) => {
            console.log(error);
        });
}

async function getProcesos() {
    console.log('departamento_id', form.departamento_id);

    await axios.get(route("procesos.byDepartamento", form.departamento_id))
        .then((response) => {
            procesos.value = response.data.procesos;
            console.log({ procesos: procesos.value });
        })
        .catch((error) => {
            console.log(error);
        });
}
</script>

<template>
    <Layout :titulo="title" :subTitulo="subTitle">

        <Head title="PDCA" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Sistema de Gestion</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                <h3>Home -</h3>
                </Link>
                <Link href="#" class="active">
                <h3>Sistema de gestion</h3>
                </Link>
                <Link :href="route('sysgestion.index')" class="active">
                <h3>PDCA</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>
                    <div class="px-4 py-2 flex justify-end bg-white border-b border-gray-200">
                        <div class="container mx-auto">
                            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                                <div class="mt-4">
                                    <InputLabel for="area_id" value="Pilar: " />
                                    <select ref="area_select" @change="onChange($event)"
                                        class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                        v-model="form.area_id" required>
                                        <option v-for="area in areas" :key="area.id" :value="area.id">
                                            {{ area.nombre }}
                                        </option>
                                    </select>
                                </div>
                                <div class="mt-4">
                                    <InputLabel for="departamento_id" value="Flujo de valor: " />

                                    <select ref="departamento_select" @change="getProcesos()"
                                        class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                        v-model="form.departamento_id" required>
                                        <option value="" disabled selected>
                                            Seleccione una opcion
                                        </option>
                                        <option v-for="departamento in departamentos" :key="departamento.id"
                                            :value="departamento.id">
                                            {{ departamento.nombre }}
                                        </option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="px-4 py-2 bg-white border-b border-gray-200">
                        <!-- <div class="grid grid-cols-2 sm:grid-cols-2 lg:grid-cols-2 gap-4 hidden sm:grid">
                            <span class="text-2xl font-bold text-center">Plan</span>
                            <span class="text-2xl font-bold text-center">Check</span>
                        </div> -->
                        <KpiIndex :departamento_id="form.departamento_id" />
                    </div>

                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-4">
                        <div class="m-4">
                            <!-- Procesos -->
                            <div class="max-h-48 overflow-y-auto">
                                <div class="text-center">
                                    <span class="text-2xl font-bold">Do</span>
                                </div>
                                <table class="min-w-full border-collapse">
                                    <thead>
                                        <tr>
                                            <th class="py-2 px-4 border" colspan="2">
                                                Procesos
                                            </th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <div v-for="proceso in procesos" class="w-full">
                                            <!-- <tr v-for="procedimiento in proceso.procedimientos"> -->
                                            <td class="py-2 px-4">
                                                <div v-if="proceso.link_herramienta">
                                                    <a target="blank" :href="proceso.link_herramienta"
                                                        class="text-blue-500 hover:underline curson-pointer">
                                                        {{ proceso.nombre || '-' }}
                                                    </a>
                                                </div>
                                                <div v-else>
                                                    <a href="#"
                                                        class="text-slate-400 hover:underline cursor-not-allowed">
                                                        {{ proceso.nombre || '-' }}
                                                    </a>
                                                </div>
                                            </td>
                                            <!-- </tr> -->
                                            <!-- <tr v-for="procedimiento in proceso.procedimientos">
                                                <td class="py-2 px-4">
                                                    <div v-if="procedimiento.link_herramienta">
                                                        <a target="blank" :href="procedimiento.link_herramienta"
                                                            class="text-blue-500 hover:underline curson-pointer">
                                                            {{ procedimiento.nombre || '-' }}
                                                        </a>
                                                    </div>
                                                    <div v-else>
                                                        <a href="#"
                                                            class="text-slate-400 hover:underline cursor-not-allowed">
                                                            {{ procedimiento.nombre || '-' }}
                                                        </a>
                                                    </div>
                                                </td>
                                            </tr> -->
                                        </div>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                        <div class="m-4">
                            <!-- Acciones -->
                            <div class="text-center">
                                <span class="text-2xl font-bold">Act</span>
                            </div>
                            <table class="min-w-full border-collapse">
                                <thead>
                                    <tr>
                                        <th class="py-2 px-4 border" colspan="2">
                                            Acciones
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td class="py-2 px-4 border">
                                            <div>
                                                <span>Correctivas</span>
                                                <button v-if="!showCorrectivas"
                                                    class="pi pi-angle-down float-right mx-2"
                                                    @click="showCorrectivas = !showCorrectivas">
                                                </button>
                                                <button v-if="showCorrectivas" class="pi pi-angle-up float-right mx-2"
                                                    @click="showCorrectivas = !showCorrectivas">
                                                </button>
                                            </div>
                                            <div>
                                                <AccionIndex v-if="showCorrectivas === true" :area_id="form.area_id"
                                                    :tipo="'correctiva'" :departamento_id="form.departamento_id" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="py-2 px-4 border">
                                            <div>
                                                <span>Preventivas</span>
                                                <button v-if="!showPreventivas"
                                                    class="pi pi-angle-down float-right mx-2"
                                                    @click="showPreventivas = !showPreventivas">
                                                </button>
                                                <button v-if="showPreventivas" class="pi pi-angle-up float-right mx-2"
                                                    @click="showPreventivas = !showPreventivas">
                                                </button>
                                            </div>
                                            <div>
                                                <AccionIndex v-if="showPreventivas === true" :tipo="'preventiva'"
                                                    :area_id="form.area_id" :departamento_id="form.departamento_id" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="py-2 px-4 border">
                                            <div>
                                                <span>De Mejora</span>
                                                <button v-if="!showMejoras" class="pi pi-angle-down float-right mx-2"
                                                    @click="showMejoras = !showMejoras">
                                                </button>
                                                <button v-if="showMejoras" class="pi pi-angle-up float-right mx-2"
                                                    @click="showMejoras = !showMejoras">
                                                </button>
                                            </div>
                                            <div>
                                                <AccionIndex v-if="showMejoras === true" :tipo="'mejora'"
                                                    :area_id="form.area_id" :departamento_id="form.departamento_id" />
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="py-2 px-4 border">
                                            <Link
                                                :href="route('minutas.index', { area_id: form.area_id, departamento_id: form.departamento_id })"
                                                class="text-blue-500 hover:underline">
                                            Minutas
                                            </Link>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="py-2 px-4 border">
                                            <Link
                                                :href="route('tareas.index', { area_id: form.area_id, departamento_id: form.departamento_id })"
                                                class="text-blue-500 hover:underline">
                                            Tareas
                                            </Link>
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </Layout>
</template>
