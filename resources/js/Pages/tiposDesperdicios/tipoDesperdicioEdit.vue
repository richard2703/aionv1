<script setup>
import { onMounted, ref } from "vue";
import Layout from "@/Layouts/Layout.vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { showToast } from "../utils/SweetAlert.service";
import Textarea from "primevue/textarea";
import AutoComplete from "primevue/autocomplete";
import Select from "primevue/select";

const props = defineProps({
    areas: Array,
    departamentos: Array || null,
    procesos: Array,
    usuarios: Array,
    tipoDesperdicio: Object,
});

const areas = ref(props.areas);
const departamentos = ref(props.departamentos);
const procesos = ref(props.procesos);
const usuarios = ref(props.usuarios);
const tipoDesperdicio = ref(props.tipoDesperdicio);
const filteredUsuarios = ref();
const tiposMinutas = ref([]);

const title = "tiposDesperdicios";

const userPermissions = usePage().props.auth.user.permissions;
const form = useForm({
    area_id: tipoDesperdicio.value.area_id,
    departamento_id: tipoDesperdicio.value.departamento_id,
    nombre: tipoDesperdicio.value.nombre,
    descripcion: tipoDesperdicio.value.descripcion,
    tipo: tipoDesperdicio.value.tipo,
});

async function getAreas() {
    await axios
        .get("/api/areas")
        .then((response) => (areas.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}

async function onChange(eventOrValue) {
    const target_id =
        eventOrValue && eventOrValue.target
            ? eventOrValue.target.value
            : eventOrValue;
    await axios
        .get(route("departamentos.byArea", target_id))
        .then((response) => (departamentos.value = response.data.departamentos))
        .catch((error) => {
            console.log(error);
        });
}

const submit = () => {
    try {
        form.patch(
            route("tiposDesperdicios.update", tipoDesperdicio.value.id),
            {
                onFinish: () => {
                    showToast("El registro ha sido creado", "success");
                    form.reset();
                },
            }
        );
    } catch (error) {
        showToast("Ocurrio un error", "error");
        console.error(error);
    }
};

onMounted(() => {
    getAreas();
    onChange(tipoDesperdicio.value.area_id);
});
console.log({ procesos: procesos });
const search = (event) => {
    console.log("buscando");
    setTimeout(() => {
        if (!event.query.trim().length) {
            // console.log(filteredUsuarios.value);
            filteredUsuarios.value = [...usuarios.value];
        } else {
            filteredUsuarios.value = usuarios.value.filter((usuario) => {
                return usuario.name
                    .toLowerCase()
                    .includes(event.query.toLowerCase());
            });
        }
    }, 250);
};
</script>

<template>
    <Layout :titulo="title">
        <Head title="Desperdicio" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Nuevo desperdicio</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('encargadoFlujo.index')" class="px-1">
                    <h3>Desperdicios -</h3>
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
                                    <!-- <div class="mt-4">
                                        <InputLabel for="area_id" value="Pilar: " />
                                        <select ref="area_select" @change="onChange($event)"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.area_id" required>
                                            <option value="" disabled selected>
                                                Seleccione una opcion
                                            </option>
                                            <option v-for="area in areas" :key="area.id" :value="area.id">
                                                {{ area.nombre }}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="mt-4">
                                        <InputLabel for="departamento_id" value="Flujo de valor: " />

                                        <select ref="departamento_select"
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
                                            value="Tipo: "
                                        />

                                        <select
                                            ref="departamento_select"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.tipo"
                                            required
                                        >
                                            <option value="" disabled selected>
                                                Seleccione una opcion
                                            </option>
                                            <option value="Equipos">
                                                Equipos
                                            </option>
                                            <option value="Materiales">
                                                Materiales
                                            </option>
                                            <option value="Energia">
                                                Energia
                                            </option>
                                            <option value="Gente">Gente</option>
                                            <option value="Otros">Otros</option>
                                        </select>
                                    </div>
                                    <!-- <div class="mt-4">
                                        <InputLabel for="Tipo" value="Tipo: " />
                                        <TextInput id="tipo" v-model="form.tipo" type="text" class="mt-1 block w-full"
                                            required autocomplete="tipo" />
                                    </div> -->
                                    <div class="mt-4">
                                        <InputLabel
                                            for="Nombre"
                                            value="Nombre: "
                                        />
                                        <!-- <AutoComplete v-model="form.lider_id" optionLabel="name"
                                            :suggestions="filteredUsuarios" forceSelection @complete="search"
                                            placeholder="" /> -->
                                        <TextInput
                                            id="tarea"
                                            v-model="form.nombre"
                                            type="text"
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
                                        <!-- <AutoComplete v-model="form.lider_id" optionLabel="name"
                                            :suggestions="filteredUsuarios" forceSelection @complete="search"
                                            placeholder="" /> -->
                                        <TextInput
                                            id="descripcion"
                                            v-model="form.descripcion"
                                            type="text"
                                            class="mt-1 block w-full"
                                            required
                                            autocomplete="descripcion"
                                        />
                                    </div>
                                </div>
                                <div
                                    class="px-4 my-4 pt-2 flex justify-end bg-white border-t border-gray-200"
                                >
                                    <div
                                        v-if="
                                            userPermissions.includes(
                                                'tipo_desperdicio_editar'
                                            )
                                        "
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
