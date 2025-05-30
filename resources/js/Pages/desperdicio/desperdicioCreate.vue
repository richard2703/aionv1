<script setup>
import { onMounted, ref } from "vue";
import Layout from "@/Layouts/Layout.vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { showToast } from "../utils/SweetAlert.service";

const props = defineProps({
    areas: Array,
    departamentos: Array || null,
    tipos: Array,
});

const title = "Desperdicios";
const areas = ref(props.areas);
const departamentos = ref(props.departamentos);
const tipos = ref(props.tipos);
const userPremissions = usePage().props.auth.user.permissions;

const form = useForm({
    area_id: "",
    departamento_id: "",
    tipoDesperdicio_id: "",
    descripcion: "",
    monto: "",
    rango: "",
    recurrencia: "",
    detectabilidad: "",
});

async function getAreas() {
    await axios
        .get("/api/areas")
        .then((response) => (areas.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}

const onChange = async (event) => {
    const taget_id = event.target.value;
    await axios
        .get(route("departamentos.byArea", taget_id))
        .then((response) => (departamentos.value = response.data.departamentos))
        .catch((error) => {
            console.log(error);
        });
};

const getTipos = async (event) => {
    // const taget_id = event.target.value;
    const taget_id = 1;

    await axios
        .get(route("desperdicio.byDepartamento", taget_id))
        .then((response) => (tipos.value = response.data.tipos))
        .catch((error) => {
            console.log(error);
        });
};

const submit = () => {
    try {
        form.post(route("desperdicio.store"), {
            onFinish: () => {
                showToast("El registro ha sido creado", "success");
                form.reset();
            },
        });
    } catch (error) {
        showToast("Ocurrio un error", "error");
        console.error(error);
    }
};

onMounted(() => {
    getAreas();
    getTipos(1);
});

const showTooltipRango = ref(false);
const showTooltipRecurrencia = ref(false);
const showTooltipDetectabilidad = ref(false);
</script>

<template>
    <Layout :titulo="title">
        <Head title="Desperdicios" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Nuevo desperdicio</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('desperdicio.index')" class="px-1">
                    <h3>Desperdicios -</h3>
                </Link>
                <Link class="active">
                    <h3>Nuevo</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white shadow-xl sm:rounded-lg">
                <div>
                    <div
                        class="px-4 my-4 py-2 flex justify-end bg-white border-b border-gray-200"
                    ></div>
                    <div class="px-4 py-2 bg-white border-b border-gray-200">
                        <div class="container mx-auto">
                            <form @submit.prevent="submit">
                                <div
                                    class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4"
                                >
                                    <div class="mt-4">
                                        <InputLabel
                                            for="area_id"
                                            value="Pilar: "
                                        />
                                        <select
                                            ref="area_select"
                                            @change="onChange($event)"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.area_id"
                                            required
                                        >
                                            <option value="" disabled selected>
                                                Seleccione una opcion
                                            </option>
                                            <option
                                                v-for="area in areas"
                                                :key="area.id"
                                                :value="area.id"
                                            >
                                                {{ area.nombre }}
                                            </option>
                                        </select>
                                    </div>

                                    <!--   <div class="mt-4">
                                        <InputLabel for="departamento_id" value="Flujo de valor: " />

                                        <select ref="departamento_select" @change="getTipos($event)"
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
                                    </div> -->

                                    <div class="mt-4">
                                        <InputLabel
                                            for="departamento_id"
                                            value="Tipo desperdicio: "
                                        />

                                        <select
                                            ref="departamento_select"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.tipoDesperdicio_id"
                                            required
                                        >
                                            <option value="" disabled selected>
                                                Seleccione una opcion
                                            </option>
                                            <option
                                                v-for="tipo in tipos"
                                                :key="tipo.id"
                                                :value="tipo.id"
                                            >
                                                {{ tipo.tipo }} -
                                                {{ tipo.nombre }}
                                            </option>
                                        </select>
                                    </div>

                                    <div class="mt-4">
                                        <InputLabel
                                            for="monto"
                                            value="Monto $ : "
                                        />
                                        <TextInput
                                            id="tarea"
                                            v-model="form.monto"
                                            type="number"
                                            step="any"
                                            class="mt-1 block w-full"
                                            required
                                            autocomplete="tarea"
                                        />
                                    </div>
                                    <div class="mt-4">
                                        <InputLabel
                                            for="Descripcion"
                                            value="Descripcion: "
                                        />
                                        <TextInput
                                            id="descripcion"
                                            v-model="form.descripcion"
                                            type="text"
                                            class="mt-1 block w-full"
                                            required
                                            autocomplete="descripcion"
                                            maxlength="250"
                                        />
                                    </div>
                                    <!-- <div class="mt-4">
                                        <InputLabel for="Rango" value="Rango: " />
                                        <TextInput id="rango" v-model="form.rango" type="number"
                                            class="mt-1 block w-full" required autocomplete="rango" min="1" max="10" />
                                    </div> -->
                                    <div class="mt-4 relative">
                                        <!-- Etiqueta del campo -->
                                        <label
                                            for="Rango"
                                            class="block text-sm font-medium text-gray-700"
                                            >Rango:
                                            <!-- Ícono para el tooltip -->
                                            <!-- <span class="ml-2 text-blue-500 cursor-pointer"
                                                @mouseenter="showTooltipRango = true"
                                                @mouseleave="showTooltipRango = false">
                                                <i class="pi pi-save"></i>
                                            </span> -->
                                            <button
                                                @click="showTooltipRango = true"
                                                class="ml-2 text-blue-500 underline"
                                            >
                                                Ver ejemplo
                                            </button>
                                        </label>

                                        <!-- Campo de texto -->
                                        <input
                                            id="rango"
                                            v-model="form.rango"
                                            type="number"
                                            class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                            required
                                            autocomplete="rango"
                                            min="1"
                                            max="10"
                                        />

                                        <!-- Modal -->
                                        <div
                                            v-if="showTooltipRango"
                                            class="fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center z-50"
                                        >
                                            <div
                                                class="bg-white p-6 rounded-lg shadow-lg max-w-full max-h-full overflow-y-auto"
                                            >
                                                <h3
                                                    class="text-lg font-bold mb-4"
                                                >
                                                    Ejemplo de Rango
                                                </h3>

                                                <!-- Contenido de la imagen con tamaño ajustado -->
                                                <img
                                                    src="../../../img/amef/rangoAMEF.png"
                                                    alt="Ejemplo de Rango"
                                                    style="width: 600px"
                                                />

                                                <!-- Botón de cerrar -->
                                                <button
                                                    @click="
                                                        showTooltipRango = false
                                                    "
                                                    class="mt-4 text-white bg-red-500 px-4 py-2 rounded"
                                                >
                                                    Cerrar
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mt-4 relative">
                                        <!-- Etiqueta del campo -->
                                        <label
                                            for="Recurrencia"
                                            class="block text-sm font-medium text-gray-700"
                                            >Recurrencia:
                                            <!-- Ícono para el tooltip -->
                                            <button
                                                @click="
                                                    showTooltipRecurrencia = true
                                                "
                                                class="ml-2 text-blue-500 underline"
                                            >
                                                Ver ejemplo
                                            </button>
                                        </label>

                                        <!-- Campo de texto -->
                                        <input
                                            id="recurrencia"
                                            v-model="form.recurrencia"
                                            type="number"
                                            class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                            required
                                            autocomplete="recurrencia"
                                            min="1"
                                            max="10"
                                        />

                                        <!-- Modal -->

                                        <div
                                            v-if="showTooltipRecurrencia"
                                            class="fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center z-50"
                                        >
                                            <div
                                                class="bg-white p-6 rounded-lg shadow-lg max-w-full max-h-full overflow-y-auto"
                                            >
                                                <h3
                                                    class="text-lg font-bold mb-4"
                                                >
                                                    Ejemplo de Recurrencia
                                                </h3>

                                                <!-- Contenido de la imagen con tamaño ajustado -->
                                                <img
                                                    src="../../../img/amef/ocurrenciaAMEF.png"
                                                    alt="Ejemplo de Rango"
                                                    style="width: 600px"
                                                />

                                                <!-- Botón de cerrar -->
                                                <button
                                                    @click="
                                                        showTooltipRecurrencia = false
                                                    "
                                                    class="mt-4 text-white bg-red-500 px-4 py-2 rounded"
                                                >
                                                    Cerrar
                                                </button>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="mt-4 relative">
                                        <!-- Etiqueta del campo -->
                                        <label
                                            for="Detectabilidad"
                                            class="block text-sm font-medium text-gray-700"
                                            >Detectabilidad:
                                            <button
                                                @click="
                                                    showTooltipDetectabilidad = true
                                                "
                                                class="ml-2 text-blue-500 underline"
                                            >
                                                Ver ejemplo
                                            </button>
                                        </label>

                                        <!-- Campo de texto -->
                                        <input
                                            id="detectabilidad"
                                            v-model="form.detectabilidad"
                                            type="number"
                                            class="mt-1 block w-full border-gray-300 rounded-md shadow-sm focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm"
                                            required
                                            autocomplete="detectabilidad"
                                            min="1"
                                            max="10"
                                        />
                                        <!-- Modal -->
                                        <div
                                            v-if="showTooltipDetectabilidad"
                                            class="fixed inset-0 bg-gray-500 bg-opacity-75 flex items-center justify-center z-50"
                                        >
                                            <div
                                                class="bg-white p-6 rounded-lg shadow-lg max-w-full max-h-full overflow-y-auto"
                                            >
                                                <h3
                                                    class="text-lg font-bold mb-4"
                                                >
                                                    Ejemplo de Detectabilidad
                                                </h3>

                                                <!-- Contenido de la imagen con tamaño ajustado -->
                                                <img
                                                    src="../../../img/amef/deteccionAMEF.png"
                                                    alt="Ejemplo de Rango"
                                                    style="width: 600px"
                                                />

                                                <!-- Botón de cerrar -->
                                                <button
                                                    @click="
                                                        showTooltipDetectabilidad = false
                                                    "
                                                    class="mt-4 text-white bg-red-500 px-4 py-2 rounded"
                                                >
                                                    Cerrar
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div
                                    v-if="
                                        userPremissions.includes(
                                            'desperdicios_crear'
                                        )
                                    "
                                    class="px-4 my-4 pt-2 flex justify-end bg-white border-t border-gray-200"
                                >
                                    <PrimaryButton
                                        class="ms-4 pi pi-save"
                                        :class="{
                                            'opacity-25': form.processing,
                                        }"
                                        :disabled="form.processing"
                                    >
                                        <span
                                            class="p-1"
                                            :style="{
                                                fontSize: '10px',
                                            }"
                                        >
                                            Guardar</span
                                        >
                                    </PrimaryButton>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>
