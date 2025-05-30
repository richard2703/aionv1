<script setup>
import { ref } from "vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import Layout from "@/Layouts/Layout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { showToast } from "../utils/SweetAlert.service";

const props = defineProps({
    departamentos: Array,
});

const departamentos = ref(props.departamentos);

// Estado para los campos dinámicos
const avisos = ref([{ value: "" }]);
const highlights = ref([{ value: "" }]);
const lowlights = ref([{ value: "" }]);
const errors = ref([{ value: "" }]);
const userPremissions = usePage().props.auth.user.permissions;

async function getDepartamentos() {
    await axios
        .get("/api/getFlujo")
        .then((response) => {
            departamentos.value = response.data;
            // console.log({ departamentos: departamentos.value });
        })
        .catch((error) => {
            console.log(error);
        });
}

const form = useForm({
    nombre: "",
    departamento_id: "",
    avisos: [],
    highlights: [],
    lowlights: [],
});

const submit = () => {
    // Asignar los valores de highlights y lowlights al formulario antes de enviarlo
    form.avisos = avisos.value.map((a) => a.value);
    form.highlights = highlights.value.map((h) => h.value);
    form.lowlights = lowlights.value.map((l) => l.value);

    form.post(route("reporte.store"), {
        onError: (errors) => {
            console.log(errors);
            showToast(errors.message, "error");
        },
        // onFinish: () => {
        //     if (!errors) {
        //         showToast("El registro ha sido creado", "success");

        //     }
        // }
        onFinish: () => form.reset(),
    });
};

// Funciones para añadir y eliminar campos dinámicos

const addAviso = () => avisos.value.push({ value: "" });
const removeAviso = (index) => avisos.value.splice(index, 1);

const addHighlight = () => highlights.value.push({ value: "" });
const removeHighlight = (index) => highlights.value.splice(index, 1);

const addLowlight = () => lowlights.value.push({ value: "" });
const removeLowlight = (index) => lowlights.value.splice(index, 1);

getDepartamentos();
</script>

<template>
    <Layout>
        <Head title="Reporte" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Nuevo Reporte</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('reporte.index')" class="px-1">
                    <h3>Reportes -</h3>
                </Link>
                <Link class="active">
                    <h3>Nuevo</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>
                    <div
                        class="px-4 my-4 py-2 flex justify-end bg-white border-b border-gray-200"
                    ></div>
                    <div class="px-4 py-2 bg-white border-b border-gray-200">
                        <div class="container mx-auto">
                            <form @submit.prevent="submit">
                                <div
                                    class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-4"
                                >
                                    <div>
                                        <InputLabel
                                            for="area_id"
                                            value="Flujo de valor: "
                                        />
                                        <select
                                            ref="select"
                                            class="mt-1 border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.departamento_id"
                                            required
                                        >
                                            <option value="" disabled selected>
                                                Seleccione una opción
                                            </option>
                                            <option
                                                v-for="departamento in departamentos"
                                                :key="departamento.id"
                                                :value="
                                                    departamento.departamento.id
                                                "
                                            >
                                                {{
                                                    departamento.departamento
                                                        .nombre
                                                }}
                                            </option>
                                            <!-- <option v-for="departamento in departamentos" :key="departamento.id"
                                                :value="departamento.id">
                                                {{ departamento.nombre }}
                                            </option> -->
                                        </select>
                                    </div>

                                    <!-- <div>
                                        <InputLabel for="Avisos" value="Avisos:" />
                                        <TextInput id="aviso" v-model="form.aviso" type="text" class="mt-1 block w-full"
                                            autocomplete="aviso" />
                                    </div> -->

                                    <!-- Campos dinámicos para Highlight -->
                                    <div
                                        class="col-span-full flex items-center mt-4"
                                    >
                                        <InputLabel
                                            for="Highlight"
                                            value="Highlight:"
                                        />
                                    </div>
                                    <div
                                        v-for="(highlight, index) in highlights"
                                        :key="index"
                                        class="col-span-full flex items-center justify-between"
                                    >
                                        <TextInput
                                            v-model="highlight.value"
                                            type="text"
                                            class="mt-1 block w-full"
                                            autocomplete="Highlight"
                                            maxlength="250"
                                        />
                                        <div
                                            v-if="
                                                userPremissions.includes(
                                                    'reporte_eliminar'
                                                )
                                            "
                                        >
                                            <button
                                                type="button"
                                                @click="removeHighlight(index)"
                                                class="ml-2 text-red-500"
                                            >
                                                Eliminar
                                            </button>
                                        </div>
                                    </div>

                                    <div
                                        v-if="
                                            userPremissions.includes(
                                                'reporte_crear'
                                            )
                                        "
                                    >
                                        <button
                                            type="button"
                                            @click="addHighlight"
                                            class="mt-2 text-blue-500"
                                        >
                                            Añadir Highlight
                                        </button>
                                    </div>

                                    <!-- Campos dinámicos para Lowlight -->
                                    <div
                                        class="col-span-full flex items-center mt-4"
                                    >
                                        <InputLabel
                                            for="Lowlight"
                                            value="Lowlight:"
                                        />
                                    </div>
                                    <div
                                        v-for="(lowlight, index) in lowlights"
                                        :key="index"
                                        class="col-span-full flex items-center justify-between"
                                    >
                                        <TextInput
                                            v-model="lowlight.value"
                                            type="text"
                                            class="mt-1 block w-full"
                                            autocomplete="Lowlight"
                                            maxlength="250"
                                        />
                                        <div
                                            v-if="
                                                userPremissions.includes(
                                                    'reporte_eliminar'
                                                )
                                            "
                                        >
                                            <button
                                                type="button"
                                                @click="removeLowlight(index)"
                                                class="ml-2 text-red-500"
                                            >
                                                Eliminar
                                            </button>
                                        </div>
                                    </div>

                                    <div
                                        v-if="
                                            userPremissions.includes(
                                                'reporte_crear'
                                            )
                                        "
                                    >
                                        <button
                                            type="button"
                                            @click="addLowlight"
                                            class="mt-2 text-blue-500"
                                        >
                                            Añadir Lowlight
                                        </button>
                                    </div>

                                    <!-- Campos dinámicos para Avisos -->
                                    <div
                                        class="col-span-full flex items-center mt-4"
                                    >
                                        <InputLabel
                                            for="Avisos"
                                            value="Avisos:"
                                        />
                                    </div>
                                    <div
                                        v-for="(aviso, index) in avisos"
                                        :key="index"
                                        class="col-span-full flex items-center justify-between"
                                    >
                                        <TextInput
                                            v-model="aviso.value"
                                            type="text"
                                            class="mt-1 block w-full"
                                            autocomplete="Aviso"
                                        />
                                        <div
                                            v-if="
                                                userPremissions.includes(
                                                    'reporte_eliminar'
                                                )
                                            "
                                        >
                                            <button
                                                type="button"
                                                @click="removeAviso(index)"
                                                class="ml-2 text-red-500"
                                            >
                                                Eliminar
                                            </button>
                                        </div>
                                    </div>

                                    <div
                                        v-if="
                                            userPremissions.includes(
                                                'reporte_crear'
                                            )
                                        "
                                    >
                                        <button
                                            type="button"
                                            @click="addAviso"
                                            class="mt-2 text-blue-500"
                                        >
                                            Añadir Aviso
                                        </button>
                                    </div>

                                    <div
                                        class="col-span-full flex items-center justify-end mt-4"
                                    >
                                        <div
                                            v-if="
                                                userPremissions.includes(
                                                    'reporte_crear'
                                                )
                                            "
                                        >
                                            <PrimaryButton
                                                class="ms-4 pi pi-save"
                                                :class="{
                                                    'opacity-25':
                                                        form.processing,
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
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>
