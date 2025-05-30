<script setup>
import { ref, onMounted } from "vue";
import { Head, useForm, Link, usePage } from "@inertiajs/vue3";
import Layout from "@/Layouts/Layout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { showToast } from "../utils/SweetAlert.service";

const props = defineProps({});

const title = "Compañia";
const userPremissions = usePage().props.auth.user.permissions;
const membresias = ref();

const form = useForm({
    membresia_id: "",
    nombre: "",
    direccion: "",
    ciudad: "",
    estado: "",
    cp: "",
    pais: "",
    telefono: "",
    sitio_web: "",
});

onMounted(() => {
    getMembresias();
});

const getMembresias = async () => {
    axios
        .get(route("membresias.findAll"))
        .then((response) => {
            console.log(response.data);
            membresias.value = response.data;
        })
        .catch((error) => {
            console.error(error);
        });
};

const submit = async () => {
    try {
        form.post(route("empresas.store"), {
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
    <Layout :title="title">
        <Head title="Compañias" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Compañias</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('empresas.index')" class="px-1">
                    <h3>Compañias -</h3>
                </Link>
                <Link :href="route('empresas.create')" class="active">
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
                                            for="name"
                                            value="Nombre: "
                                        />
                                        <TextInput
                                            id="name"
                                            v-model="form.nombre"
                                            type="text"
                                            class="mt-1 block w-full"
                                            required
                                            autofocus
                                            autocomplete="name"
                                        />
                                    </div>

                                    <div>
                                        <InputLabel
                                            for="direccion"
                                            value="Direccion: "
                                        />
                                        <TextInput
                                            id="direccion"
                                            v-model="form.direccion"
                                            type="text"
                                            class="mt-1 block w-full"
                                            autofocus
                                            autocomplete="direccion"
                                        />
                                    </div>
                                    <div>
                                        <InputLabel
                                            for="ciudad"
                                            value="Ciudad: "
                                        />
                                        <TextInput
                                            id="ciudad"
                                            v-model="form.ciudad"
                                            type="text"
                                            class="mt-1 block w-full"
                                            autofocus
                                            autocomplete="ciudad"
                                        />
                                    </div>
                                    <div>
                                        <InputLabel
                                            for="estado"
                                            value="Estado: "
                                        />
                                        <TextInput
                                            id="estado"
                                            v-model="form.estado"
                                            type="text"
                                            class="mt-1 block w-full"
                                            autofocus
                                            autocomplete="estado"
                                        />
                                    </div>
                                    <div>
                                        <InputLabel
                                            for="cp"
                                            value="Codigo Postal: "
                                        />
                                        <TextInput
                                            id="cp"
                                            v-model="form.cp"
                                            type="text"
                                            class="mt-1 block w-full"
                                            autofocus
                                            autocomplete="cp"
                                        />
                                    </div>
                                    <div>
                                        <InputLabel for="pais" value="Pais: " />
                                        <TextInput
                                            id="pais"
                                            v-model="form.pais"
                                            type="text"
                                            class="mt-1 block w-full"
                                            autofocus
                                            autocomplete="pais"
                                        />
                                    </div>
                                    <div>
                                        <InputLabel
                                            for="telefono"
                                            value="Telefono: "
                                        />
                                        <TextInput
                                            id="telefono"
                                            v-model="form.telefono"
                                            type="text"
                                            class="mt-1 block w-full"
                                            autofocus
                                            autocomplete="telefono"
                                        />
                                    </div>
                                    <div>
                                        <InputLabel
                                            for="sitio_web"
                                            value="Sitio Web: "
                                        />
                                        <TextInput
                                            id="sitio_web"
                                            v-model="form.sitio_web"
                                            type="text"
                                            class="mt-1 block w-full"
                                            autofocus
                                            autocomplete="sitio_web"
                                        />
                                    </div>
                                    <div>
                                        <InputLabel
                                            for="membresia"
                                            value="Membresia: "
                                        />
                                        <select
                                            v-model="form.membresia_id"
                                            name="membresia"
                                            id="membresia"
                                        >
                                            <option value="" disabled selected>
                                                Seleccione una opcion
                                            </option>
                                            <option
                                                v-for="membresia in membresias"
                                                :key="membresia.id"
                                                :value="membresia.id"
                                            >
                                                {{ membresia.nombre }}
                                            </option>
                                        </select>
                                    </div>

                                    <div
                                        class="col-span-full flex items-center justify-end mt-4"
                                    >
                                        <div
                                            v-if="
                                                userPremissions.includes(
                                                    'pilares_crear'
                                                )
                                            "
                                        >
                                            <PrimaryButton
                                                class="pi pi-save ms-4"
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
