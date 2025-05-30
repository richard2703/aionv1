<script setup>
import { onMounted, ref } from "vue";
import { Head, Link, useForm } from "@inertiajs/vue3";
import axios from "axios";
import Layout from "@/Layouts/Layout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import Textarea from "primevue/textarea";
import { showToast } from "@/Pages/utils/SweetAlert.service";
import { isUrlValid } from "../utils/linkValidator";

const props = defineProps({
    proveedor: Object,
});

const proveedor = ref(props.proveedor);
const areas = ref([]);
const procesos = ref([]);

const form = useForm({
    area_id: proveedor.value.area_id,
    proceso_id: proveedor.value.proceso_id,
    nombre: proveedor.value.nombre,
    servicio: proveedor.value.servicio,
    pagina_web: proveedor.value.pagina_web,
    link_orden: proveedor.value.link_orden,
    telefono: proveedor.value.telefono,
    correo: proveedor.value.correo,
    info: proveedor.value.info,
    video: "",
});

onMounted(() => {
    getAreas();
    getProcesos(proveedor.value.area_id);
});
const getAreas = async () => {
    try {
        const response = await axios.get("/api/areas");
        areas.value = response.data;
    } catch (error) {
        console.error(error);
    }
};

const getProcesos = async (area_id) => {
    try {
        const response = await axios.get(route("procesos.byArea", area_id));
        procesos.value = response.data;
    } catch (error) {
        console.error(error);
    }
};

const onChange = (event) => {
    const taget_id = event.target.value;
    axios
        .get(route("procesos.byArea", taget_id))
        .then((response) => {
            procesos.value = response.data;
        })
        .catch((error) => {
            console.log(error);
        });
};

const submit = async () => {
    if (isUrlValid(form.pagina_web)) {
        const formData = new FormData();
        formData.append("area_id", form.area_id);
        formData.append("proceso_id", form.proceso_id);
        formData.append("nombre", form.nombre);
        formData.append("servicio", form.servicio);
        formData.append("pagina_web", form.pagina_web);
        formData.append("link_orden", form.link_orden);
        formData.append("telefono", form.telefono);
        formData.append("correo", form.correo);
        formData.append("info", form.info);
        formData.append("video", form.video);

        await axios
            .post(route("proveedor.update", proveedor.value.id), formData, {
                headers: {
                    "Content-Type": "multipart/form-data",
                },
            })
            .then(() => {
                showToast("Proveedor actualizado con exito", "success");
                form.reset();
                window.location.href = route("proveedores.index");
            })
            .catch((error) => {
                console.error(error);
            });
    } else {
        showToast("El link a la pagina web no es valido", "error");
    }
};
const onFileChange = (key, event) => {
    form[key] = event.target.files[0];
};
</script>

<template>
    <Layout>
        <Head title="Proveedor" />

        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Editar Proveedor</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('proveedores.index')" class="px-1">
                    <h3>Proveedores -</h3>
                </Link>
                <Link
                    :href="route('proveedores.edit', proveedor.id)"
                    class="active"
                >
                    <h3>Editar</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div class="px-4 py-2 bg-white border-b border-gray-200">
                    <div class="container mx-auto">
                        <form @submit.prevent="submit">
                            <div
                                class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-4"
                            >
                                <div class="mt-4">
                                    <InputLabel for="area_id" value="Pilar: " />
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
                                        for="proceso_id"
                                        value="Proceso: "
                                    />
                                    <select
                                        ref="proceso_select"
                                        class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                        v-model="form.proceso_id"
                                        required
                                    >
                                        <option value="" disabled selected>
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
                                    <InputLabel for="nombre" value="Nombre:" />
                                    <TextInput
                                        id="nombre"
                                        v-model="form.nombre"
                                        type="text"
                                        class="mt-1 block w-full"
                                        placeholder="Nombre del proveedor"
                                        required
                                        autocomplete="nombre"
                                    />
                                </div>
                                <div class="mt-4">
                                    <InputLabel
                                        for="servicio"
                                        value="Servicio:"
                                    />
                                    <TextInput
                                        id="servicio"
                                        v-model="form.servicio"
                                        type="text"
                                        class="mt-1 block w-full"
                                        placeholder="Servicio prestado"
                                        required
                                        autocomplete="servicio"
                                    />
                                </div>
                                <div class="mt-4">
                                    <InputLabel
                                        for="servicio"
                                        value="Pagina Web:"
                                    />
                                    <TextInput
                                        id="pagina_web"
                                        v-model="form.pagina_web"
                                        type="text"
                                        class="mt-1 block w-full"
                                        placeholder="https://proveedor_web.com"
                                        required
                                        autocomplete="pagina_web"
                                    />
                                </div>
                                <div class="mt-4">
                                    <InputLabel
                                        for="link_orden"
                                        value="Link para orden de compra:"
                                    />
                                    <TextInput
                                        id="link_orden"
                                        v-model="form.link_orden"
                                        type="text"
                                        class="mt-1 block w-full"
                                        placeholder="https://ERP.com"
                                        required
                                        autocomplete="pagina_web"
                                    />
                                </div>
                                <div class="mt-4">
                                    <InputLabel
                                        for="telefono"
                                        value="No. Telefono:"
                                    />
                                    <TextInput
                                        id="telefono"
                                        v-model="form.telefono"
                                        type="tel"
                                        class="mt-1 block w-full"
                                        placeholder="3312345678"
                                        required
                                        autocomplete="telefono"
                                    />
                                </div>
                                <div class="mt-4">
                                    <InputLabel
                                        for="correo"
                                        value="Correo Electronico:"
                                    />
                                    <TextInput
                                        id="correo"
                                        v-model="form.correo"
                                        type="email"
                                        class="mt-1 block w-full"
                                        placeholder="contacto@ejemplo.com"
                                        required
                                        autocomplete="correo"
                                    />
                                </div>
                            </div>
                            <div class="mt-4 w-full">
                                <InputLabel
                                    for="presentacion"
                                    value="Video de presentación: "
                                />
                                <input
                                    id="video"
                                    type="file"
                                    @change="onFileChange('video', $event)"
                                    class="mt-1 block w-full"
                                    autocomplete="video"
                                />
                                <p class="text-center text-red-500">
                                    (El tamaño del video esta limitado a 100mb)
                                </p>
                            </div>
                            <div class="mt-4 w-full">
                                <InputLabel
                                    for="info"
                                    value="Información Adicional: "
                                />
                                <Textarea
                                    v-model="form.info"
                                    class="w-full"
                                    rows="5"
                                    cols="30"
                                    placeholder="Informacion Adicional (Observaciones ,N. de contrato, etc.)"
                                />
                            </div>

                            <div class="flex items-center justify-end mt-4">
                                <PrimaryButton
                                    class="ms-4 pi pi-save"
                                    :class="{ 'opacity-25': form.processing }"
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
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>

<style></style>
