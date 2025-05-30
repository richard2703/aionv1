<script setup>
import { onMounted, ref } from "vue";
import Layout from "@/Layouts/Layout.vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { showToast } from "../utils/SweetAlert.service";
import Textarea from "primevue/textarea";

const props = defineProps({
    areas: Array,
    departamentos: Array || null,
    procedimientos: Array,
});

const areas = ref(props.areas);
const departamentos = ref(props.departamentos);
const procesos = ref(props.procesos);
const procedimientos = ref(props.procedimientos);
const userPermissions = usePage().props.auth.user.permissions;

const form = useForm({
    area_id: "",
    departamento_id: "",
    proceso_id: "",
    procedimiento_id: "",
    nombre: "",
    descripcion: "",
    link_externo: "",
});

onMounted(() => {
    getAreas();
});

async function getAreas() {
    await axios
        .get("/api/areas")
        .then((response) => (areas.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}

async function getDepartamentos(event) {
    const taget_id = event.target.value;

    await axios
        .get(route("departamentos.byArea", taget_id))
        .then((response) => (departamentos.value = response.data.departamentos))
        .catch((error) => {
            console.log(error);
        });
}

async function getProcesos(event) {
    const taget_id = event.target.value;

    await axios
        .get(route("procesos.byDepartamento", taget_id))
        .then((response) => (procesos.value = response.data.procesos))
        .catch((error) => {
            console.log(error);
        });
}

async function getProcedimientos(event) {
    const taget_id = event.target.value;
    await axios
        .get(route("procedimientos.byProceso", taget_id))
        .then(
            (response) => (procedimientos.value = response.data.procedimientos)
        )
        .catch((error) => {
            console.log(error);
        });
}

const submit = () => {
    try {
        form.post(route("estandar.store"), {
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
</script>

<template>
    <Layout>
        <Head title="Estandares" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Estandares</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('estandar.index')" class="px-1">
                    <h3>Estandares -</h3>
                </Link>
                <Link :href="route('estandar.create')" class="active">
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
                                    <div class="mt-4">
                                        <InputLabel
                                            for="area_id"
                                            value="Pilar: "
                                        />
                                        <select
                                            ref="area_select"
                                            @change="getDepartamentos($event)"
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
                                    <div class="mt-4">
                                        <InputLabel
                                            for="departamento_id"
                                            value="Flujo de valor: "
                                        />

                                        <select
                                            ref="departamento_select"
                                            @change="getProcesos($event)"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.departamento_id"
                                        >
                                            <option value="" selected>
                                                Seleccione una opcion
                                            </option>
                                            <option
                                                v-for="departamento in departamentos"
                                                :key="departamento.id"
                                                :value="departamento.id"
                                            >
                                                {{ departamento.nombre }}
                                            </option>
                                        </select>
                                    </div>

                                    <div class="mt-4">
                                        <InputLabel
                                            for="proceso_id"
                                            value="Proceso: "
                                        />

                                        <select
                                            ref="proceso_select"
                                            @change="getProcedimientos($event)"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.proceso_id"
                                        >
                                            <option value="" selected>
                                                Seleccione una opcion
                                            </option>
                                            <option
                                                v-for="proceso in procesos"
                                                :key="proceso.id"
                                                :value="proceso.id"
                                            >
                                                {{ proceso.nombre }}
                                            </option>
                                        </select>
                                    </div>

                                    <div class="mt-4">
                                        <InputLabel
                                            for="procedimiento_id"
                                            value="Procedimiento: "
                                        />

                                        <select
                                            ref="procedimiento_select"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.procedimiento_id"
                                            require
                                        >
                                            <option value="" selected>
                                                Seleccione una opcion
                                            </option>
                                            <option
                                                v-for="procedimiento in procedimientos"
                                                :key="procedimiento.id"
                                                :value="procedimiento.id"
                                            >
                                                {{ procedimiento.nombre }}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="my-4">
                                        <InputLabel
                                            for="nombre"
                                            value="Estandar: "
                                        />
                                        <TextInput
                                            id="nombre"
                                            v-model="form.nombre"
                                            type="text"
                                            class="mt-1 block w-full"
                                            required
                                            autocomplete="new-challenge"
                                        />
                                    </div>
                                </div>
                                <div
                                    class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-4"
                                >
                                    <div class="my-4">
                                        <InputLabel
                                            for="descripcion"
                                            value="Descripcion: "
                                        />
                                        <Textarea
                                            v-model="form.descripcion"
                                            rows="5"
                                            cols="30"
                                        />
                                    </div>
                                    <div class="my-4">
                                        <InputLabel
                                            for="link_externo"
                                            value="Link externo: "
                                        />
                                        <Textarea
                                            v-model="form.link_externo"
                                            rows="5"
                                            cols="30"
                                        />
                                    </div>
                                </div>
                                <hr />
                                <div
                                    v-if="
                                        userPermissions.includes(
                                            'estandares_crear'
                                        )
                                    "
                                    class="flex items-center justify-end mt-4"
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
