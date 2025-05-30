<script setup>
import { ref, onMounted } from "vue";
import { Head, Link, useForm } from "@inertiajs/vue3";
import Layout from "@/Layouts/Layout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { showToast } from "../utils/SweetAlert.service";

const props = defineProps({
    departamentos: Array,
    reporte: Object,
});

const departamentos = ref(props.departamentos);

async function getDepartamentos() {
    await axios
        .get("/api/getFlujo")
        .then((response) => {
            departamentos.value = response.data;
            console.log({ departamentos: departamentos.value });
        })
        .catch((error) => {
            console.log(error);
        });
}
// Pre-fill avisos, highlights, lowlights with the values from the report if available
const avisos = ref(
    props.reporte.avisos && props.reporte.avisos.length
        ? props.reporte.avisos.map((a) => ({ value: a.aviso }))
        : [{ value: "" }]
);

const highlights = ref(
    props.reporte.highlights && props.reporte.highlights.length
        ? props.reporte.highlights.map((h) => ({ value: h.light }))
        : [{ value: "" }]
);

const lowlights = ref(
    props.reporte.lowlights && props.reporte.lowlights.length
        ? props.reporte.lowlights.map((l) => ({ value: l.light }))
        : [{ value: "" }]
);

const form = useForm({
    departamento_id: props.reporte.departamento_id || "",
    avisos: [],
    highlights: [],
    lowlights: [],
});

const submit = () => {
    // Assign the avisos, highlights, and lowlights to the form
    form.avisos = avisos.value.map((a) => a.value);
    form.highlights = highlights.value.map((h) => h.value);
    form.lowlights = lowlights.value.map((l) => l.value);

    form.patch(route("misreporte.update", props.reporte.id), {
        onError: (errors) => {
            console.log(errors);
            showToast(errors.message, "error");
        },
        onFinish: () => form.reset(),
    });
};

// Functions for adding/removing dynamic fields
const addAviso = () => avisos.value.push({ value: "" });
const removeAviso = (index) => avisos.value.splice(index, 1);

const addHighlight = () => highlights.value.push({ value: "" });
const removeHighlight = (index) => highlights.value.splice(index, 1);

const addLowlight = () => lowlights.value.push({ value: "" });
const removeLowlight = (index) => lowlights.value.splice(index, 1);

onMounted(() => {
    // console.log('reportes', reportes.value);
    getDepartamentos();
});
</script>

<template>
    <Layout>
        <Head title="Usuarios" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Editar Reporte</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('reporte.index')" class="px-1">
                    <h3>Reportes -</h3>
                </Link>
                <Link class="active">
                    <h3>Editar</h3>
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
                                        </select>

                                        <!-- <select ref="select"
                                            class="mt-1 border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.departamento_id" required>
                                            <option value="" disabled selected>
                                                Seleccione una opción
                                            </option>
                                            <option v-for="departamento in departamentos" :key="departamento.id"
                                                :value="departamento.id">
                                                {{ departamento.nombre }}
                                            </option>
                                        </select> -->
                                    </div>

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
                                        <button
                                            type="button"
                                            @click="removeHighlight(index)"
                                            class="ml-2 text-red-500"
                                        >
                                            Eliminar
                                        </button>
                                    </div>
                                    <button
                                        type="button"
                                        @click="addHighlight"
                                        class="mt-2 text-blue-500"
                                    >
                                        Añadir Highlight
                                    </button>

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
                                        <button
                                            type="button"
                                            @click="removeLowlight(index)"
                                            class="ml-2 text-red-500"
                                        >
                                            Eliminar
                                        </button>
                                    </div>
                                    <button
                                        type="button"
                                        @click="addLowlight"
                                        class="mt-2 text-blue-500"
                                    >
                                        Añadir Lowlight
                                    </button>

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
                                        <button
                                            type="button"
                                            @click="removeAviso(index)"
                                            class="ml-2 text-red-500"
                                        >
                                            Eliminar
                                        </button>
                                    </div>
                                    <button
                                        type="button"
                                        @click="addAviso"
                                        class="mt-2 text-blue-500"
                                    >
                                        Añadir Aviso
                                    </button>

                                    <div
                                        class="col-span-full flex items-center justify-end mt-4"
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
                                                Actualizar</span
                                            >
                                        </PrimaryButton>
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
