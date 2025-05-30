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
});

const areas = ref(props.areas);
const secciones = ref([]);
const userPermissions = usePage().props.auth.user.permissions;

async function getAreas() {
    await axios
        .get("/api/areas")
        .then((response) => (areas.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}

const form = useForm({
    area_id: "",
    departamento_id: "",
    seccion_id: "",
    challenge: "",
});

const onAreaChange = async (event) => {
    const taget_id = event.target.value;
    await axios
        .get(route("secciones.byArea", taget_id))
        .then((response) => {
            secciones.value = response.data;
            console.log({ secciones: secciones.value });
        })
        .catch((error) => {
            console.log(error);
        });
};

const submit = () => {
    try {
        form.post(route("challenge.store"), {
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
});
</script>

<template>
    <Layout>
        <Head title="Challenges" />

        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Challenges</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('challenge.index')" class="px-1">
                    <h3>Challenges -</h3>
                </Link>
                <Link :href="route('challenge.create')" class="active">
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
                                <div class="mt-4">
                                    <InputLabel for="area_id" value="Pilar: " />
                                    <select
                                        ref="area_select"
                                        @change="onAreaChange($event)"
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
                                        for="seccion_select"
                                        value="Seccion: "
                                    />

                                    <select
                                        ref="seccion_select"
                                        class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                        v-model="form.seccion_id"
                                        required
                                    >
                                        <option value="" disabled selected>
                                            Seleccione una opcion
                                        </option>
                                        <option
                                            v-for="seccion in secciones"
                                            :key="seccion.id"
                                            :value="seccion.id"
                                        >
                                            {{ seccion.titulo }}
                                        </option>
                                    </select>
                                </div>

                                <div class="mt-4">
                                    <InputLabel
                                        for="challenge"
                                        value="Challenge: "
                                    />
                                    <TextInput
                                        id="challenge"
                                        v-model="form.challenge"
                                        type="text"
                                        class="mt-1 block w-full"
                                        required
                                        autocomplete="new-challenge"
                                    />
                                </div>

                                <div
                                    v-if="
                                        userPermissions.includes(
                                            'challenges_crear'
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
