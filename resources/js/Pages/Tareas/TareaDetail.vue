<script setup>
import { onMounted, ref } from "vue";
import Layout from "@/Layouts/Layout.vue";
import { Head, useForm, Link } from "@inertiajs/vue3";
import axios from "axios";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import AutoComplete from "primevue/autocomplete";
import Textarea from "primevue/textarea";
import { showToast } from "@/Pages/utils/SweetAlert.service";
import Image from "primevue/image";

const props = defineProps({
    tarea: Object,
});

const tarea = ref(props.tarea);
const areas = ref({});
const minutas = ref({});
const departamentos = ref({});
const usuarios = ref([]);
const filteredUsuarios = ref();

const evidencias = ref({});

const form = useForm({
    area_id: tarea.value.area_id,
    departamento_id: tarea.value.departamento_id,
    minuta_id: tarea.value.minuta_id,
    responsable_id: tarea.value.responsable ? tarea.value.responsable.name : "",
    revisor_id: tarea.value.revisor ? tarea.value.revisor.name : "",
    tarea: tarea.value.tarea,
    fecha: tarea.value.fecha,
    nota: tarea.value.nota,
    estatus_id: tarea.value.estatus_id,
});

onMounted(() => {
    getAreas();
    getDepartamentos(tarea.value.area_id);
    getUsuarios();
    getMinutas();
    getEvidencias();
});

const getAreas = async () => {
    try {
        const response = await axios.get("/api/areas");
        areas.value = response.data;
    } catch (error) {
        console.error(error);
    }
};

const onChange = async (event) => {
    await getDepartamentos(event.target.value);
};

const getDepartamentos = async (area_id) => {
    try {
        const response = await axios.get(
            route("departamentos.byArea", area_id)
        );
        departamentos.value = response.data.departamentos;
    } catch (error) {
        console.error(error);
    }
};

const getUsuarios = async () => {
    try {
        const response = await axios.get("/api/usuarios/all/todo");
        usuarios.value = response.data;
    } catch (error) {
        console.error(error);
    }
};

const getMinutas = async () => {
    try {
        const response = await axios.get("/api/minutas");
        minutas.value = response.data.data;
    } catch (error) {
        console.error(error);
    }
};

const submit = async () => {
    try {
        await form.patch(route("tareas.update", tarea.value.id), {
            onFinish: () => {
                showToast("El registro ha sido creado", "success");
                window.location.href = route("tareas.misTareas");
            },
        });
    } catch (error) {
        showToast("Ocurrio un error", "error");
        console.error(error);
    }
};

const search = (event) => {
    setTimeout(() => {
        if (!event.query.trim().length) {
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

const getEvidencias = async () => {
    try {
        const response = await axios.get(
            route("tareaEvidencia.getByTarea", tarea.value.id)
        );
        evidencias.value = response.data;
    } catch (error) {
        console.error(error);
    }
};
</script>

<template>
    <Layout>
        <Head title="Tareas" />

        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Tareas</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('tareas.misTareas')" class="px-1">
                    <h3>Tareas -</h3>
                </Link>
                <Link :href="route('tareas.detail', tarea.id)" class="active">
                    <h3>Detalle</h3>
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
                                <div class="mt-4">
                                    <InputLabel
                                        for="minuta_id"
                                        value="Reunión:"
                                    />
                                    <TextInput
                                        id="minuta"
                                        v-model="tarea.minuta.alias"
                                        type="text"
                                        class="mt-1 block w-full"
                                        disabled
                                    />
                                </div>

                                <div class="mt-4">
                                    <InputLabel for="area_id" value="Pilar: " />
                                    <TextInput
                                        id="pilar"
                                        v-model="tarea.area.nombre"
                                        type="text"
                                        class="mt-1 block w-full"
                                        disabled
                                    />
                                </div>

                                <div class="mt-4">
                                    <InputLabel
                                        for="departamento_id"
                                        value="Flujo de valor: "
                                    />
                                    <TextInput
                                        id="flujo_valor"
                                        v-model="tarea.departamento.nombre"
                                        type="text"
                                        class="mt-1 block w-full"
                                        disabled
                                    />
                                </div>

                                <hr class="my-4" />

                                <div class="mt-4">
                                    <InputLabel for="tarea" value="Titulo:" />
                                    <TextInput
                                        id="tarea"
                                        v-model="tarea.tarea"
                                        type="text"
                                        class="mt-1 block w-full"
                                        disabled
                                    />
                                </div>

                                <div class="mt-4 z-30">
                                    <InputLabel
                                        for="responsable_id"
                                        value="Responsable:"
                                    />

                                    <div v-if="tarea.responsable">
                                        <TextInput
                                            id="responsable"
                                            v-model="tarea.responsable.name"
                                            type="text"
                                            class="mt-1 block w-full"
                                            disabled
                                        />
                                    </div>
                                    <div v-else>
                                        <InputLabel
                                            class="text-red-500"
                                            value="Sin responsable"
                                        />
                                    </div>
                                </div>

                                <div class="mt-4 z-30">
                                    <InputLabel
                                        for="revisor_id"
                                        value="Cliente de la tarea:"
                                    />
                                    <div v-if="tarea.revisor">
                                        <TextInput
                                            id="rivisor"
                                            v-model="tarea.revisor.name"
                                            type="text"
                                            class="mt-1 block w-full"
                                            disabled
                                        />
                                    </div>
                                    <div v-else>
                                        <InputLabel
                                            class="text-red-500"
                                            value="Sin revisor"
                                        />
                                    </div>
                                </div>
                                <div class="mt-4">
                                    <InputLabel
                                        for="estatus"
                                        value="Estatus: "
                                    />
                                    <TextInput
                                        id="estatus"
                                        v-model="tarea.estatus.titulo"
                                        type="text"
                                        class="mt-1 block w-full"
                                        disabled
                                    />
                                </div>
                                <div class="mt-4">
                                    <InputLabel
                                        for="fecha"
                                        value="Fecha de entrega:"
                                    />
                                    <TextInput
                                        id="pilar"
                                        v-model="tarea.fecha"
                                        type="text"
                                        class="mt-1 block w-full"
                                        disabled
                                    />
                                </div>
                                <div class="my-4">
                                    <InputLabel for="nota" value="Notas: " />
                                    <Textarea
                                        class="mt-1 block w-full"
                                        v-model="tarea.nota"
                                        rows="5"
                                        cols="30"
                                        disabled
                                    />
                                </div>
                            </form>
                        </div>
                        <div class="contaier mx-auto">
                            <div class="grid grid-cols-1 gap-4">
                                <InputLabel
                                    for="img_ref"
                                    value="Muestra del trabajo realizado: "
                                />
                                <div class="grid grid-cols-1 gap-4">
                                    <div
                                        v-for="(evidencia, index) in evidencias"
                                        :key="index"
                                        class="card flex justify-evenly hover:bg-slate-100"
                                    >
                                        <a
                                            :href="evidencia.img_ref"
                                            download
                                            class="cursor-pointer text-blue-500 text-xl"
                                        >
                                            referencia a documento
                                            {{ Number(index) + 1 }}</a
                                        >
                                        <!-- <img :src="evidencia" alt="" srcset=""> -->
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>
