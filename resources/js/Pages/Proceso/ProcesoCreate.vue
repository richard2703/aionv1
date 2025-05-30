<script setup>
import { onMounted, ref } from "vue";
import Layout from "@/Layouts/Layout.vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { showToast } from "../utils/SweetAlert.service";
import Textarea from "primevue/textarea";
import { isUrlValid } from "../utils/linkValidator";

const props = defineProps({
    areas: Array,
    departamentos: Array || null,
});

const areas = ref(props.areas);
const departamentos = ref(props.departamentos);
const userPermissions = usePage().props.auth.user.permissions;

const form = useForm({
    area_id: "",
    departamento_id: "",
    nombre: "",
    descripcion: "",
    link_externo: "",
    link_herramienta: "",
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

const onChange = async (event) => {
    const taget_id = event.target.value;
    await axios
        .get(route("departamentos.byArea", taget_id))
        .then((response) => (departamentos.value = response.data.departamentos))
        .catch((error) => {
            console.log(error);
        });
};

const submit = () => {
    try {
        if (isUrlValid(form.link_herramienta)) {
            form.post(route("proceso.store"), {
                onFinish: () => {
                    showToast("El registro ha sido creado", "success");
                    form.reset();
                },
            });
        } else {
            showToast("El link a la herramienta no es valido", "error");
        }
    } catch (error) {
        showToast("Ocurrio un error", "error");
        console.error(error);
    }
};
</script>

<template>
    <Layout>
        <Head title="Procesos" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Procesos</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('proceso.index')" class="px-1">
                    <h3>Procesos -</h3>
                </Link>
                <Link :href="route('proceso.create')" class="active">
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
                                    <div class="mt-4">
                                        <InputLabel
                                            for="departamento_id"
                                            value="Flujo de valor: "
                                        />

                                        <select
                                            ref="departamento_select"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.departamento_id"
                                            required
                                        >
                                            <option value="" disabled selected>
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

                                    <div class="my-4">
                                        <InputLabel
                                            for="nombre"
                                            value="Proceso: "
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
                                    class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-4"
                                >
                                    <div class="my-4 w-full">
                                        <InputLabel
                                            for="link_externo"
                                            value="Link externo: "
                                        />
                                        <Textarea
                                            class="w-full"
                                            v-model="form.link_externo"
                                            rows="5"
                                            cols="30"
                                            :invalid="
                                                !isUrlValid(form.link_externo)
                                            "
                                        />
                                    </div>
                                    <div class="my-4 w-full">
                                        <InputLabel
                                            for="Link Herramienta"
                                            value="Link Herramienta: "
                                        />
                                        <Textarea
                                            class="w-full"
                                            v-model="form.link_herramienta"
                                            rows="5"
                                            cols="30"
                                            :invalid="
                                                !isUrlValid(
                                                    form.link_herramienta
                                                )
                                            "
                                            required
                                        />
                                    </div>
                                </div>
                                <div
                                    class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-4"
                                >
                                    <div class="my-4 w-full">
                                        <InputLabel
                                            for="descripcion"
                                            value="Descripcion: "
                                        />
                                        <Textarea
                                            class="w-full"
                                            v-model="form.descripcion"
                                            rows="5"
                                            cols="30"
                                        />
                                    </div>
                                </div>

                                <hr />
                                <div
                                    v-if="
                                        userPermissions.includes(
                                            'procesos_crear'
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
