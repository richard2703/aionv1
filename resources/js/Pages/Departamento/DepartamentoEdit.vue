<script setup>
import { ref } from "vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import Layout from "@/Layouts/Layout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { confirmDialog, showToast } from "../utils/SweetAlert.service";

const props = defineProps({
    areas: Array,
    departamento: Object,
});

const areas = ref(props.areas);
const departamento = ref(props.departamento);
const userPermissions = usePage().props.auth.user.permissions;

async function getAreas() {
    await axios
        .get("/api/areas")
        .then((response) => {
            areas.value = response.data;
        })
        .catch((error) => {
            console.log(error);
        });
}

const form = useForm({
    nombre: departamento.value.nombre,
    area_id: departamento.value.area_id,
    descripcion: departamento.value.descripcion,
});

const submit = async () => {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Se modificara el registro!",
            "info"
        );
        if (result.isConfirmed) {
            form.patch(route("departamento.update", props.departamento.id), {
                onFinish: () => {
                    showToast("El registro ha sido actualizado", "success");
                    form.reset();
                },
            });
        }
    } catch (error) {
        console.error(error);
    }
};

getAreas();
</script>

<template>
    <Layout>
        <Head title="Flujos de valor" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Flujos de valor</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('departamento.index')" class="px-1">
                    <h3>Flujos de valor -</h3>
                </Link>
                <Link :href="route('departamento.create')" class="active">
                    <h3>Actualizar</h3>
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
                                            for="area_id"
                                            value="Pilar: "
                                        />
                                        <select
                                            ref="select"
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

                                    <div>
                                        <InputLabel
                                            for="descripcion"
                                            value="Descripcion:"
                                        />
                                        <TextInput
                                            id="descripcion"
                                            v-model="form.descripcion"
                                            type="text"
                                            class="mt-1 block w-full"
                                            autocomplete="descripcion"
                                        />
                                    </div>

                                    <div
                                        class="col-span-full flex items-center justify-end mt-4"
                                    >
                                        <div
                                            v-if="
                                                userPermissions.includes(
                                                    'flujos_de_valor_editar'
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
                                                    Actualizar</span
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
