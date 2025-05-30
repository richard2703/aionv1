<script setup>
import { onMounted, ref } from "vue";
import Layout from "@/Layouts/Layout.vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { showToast } from "../utils/SweetAlert.service";
import Textarea from "primevue/textarea";

const props = defineProps({
    areas: Array,
    departamentos: Array || null,
    challenges: Array || null,
});

const areas = ref(props.areas);
const challenges = ref(props.challenges);
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
    challenge_id: "",
    madurez: "",
    formal: "",
    informal: "",
});

const onChangeArea = async (event) => {
    const taget_id = event.target.value;
    await axios
        .get(route("challenges.byArea", taget_id))
        .then((response) => (challenges.value = response.data.challenges))
        .catch((error) => {
            console.log(error);
        });
};

const submit = () => {
    try {
        form.post(route("opcion.store"), {
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
        <Head title="Opciones" />

        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Opciones</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('opcion.index')" class="px-1">
                    <h3>Opciones -</h3>
                </Link>
                <Link :href="route('opcion.create')" class="active">
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
                                            value="Area: "
                                        />
                                        <select
                                            ref="area_select"
                                            @change="onChangeArea($event)"
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
                                            for="challenge_id"
                                            value="Challenge: "
                                        />

                                        <select
                                            ref="challenge_select"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.challenge_id"
                                            required
                                        >
                                            <option value="" disabled selected>
                                                Seleccione una opcion
                                            </option>
                                            <option
                                                v-for="challenge in challenges"
                                                :key="challenge.id"
                                                :value="challenge.id"
                                            >
                                                {{ challenge.challenge }}
                                            </option>
                                        </select>
                                    </div>

                                    <div class="mt-4">
                                        <InputLabel
                                            for="madurez"
                                            value="Madurez: "
                                        />

                                        <select
                                            ref="madurez_select"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.madurez"
                                            required
                                        >
                                            <option value="" disabled selected>
                                                Seleccione una opcion
                                            </option>
                                            <option value="Nulo">Nulo</option>
                                            <option value="Basico">
                                                Basico
                                            </option>
                                            <option value="Maduro">
                                                Maduro
                                            </option>
                                            <option value="Avanzado">
                                                Avanzado
                                            </option>
                                        </select>
                                    </div>
                                </div>

                                <div
                                    class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-4"
                                >
                                    <div class="mt-4">
                                        <InputLabel
                                            for="formal"
                                            value="Formal: "
                                        />
                                        <Textarea
                                            v-model="form.formal"
                                            rows="5"
                                            cols="30"
                                        />
                                    </div>

                                    <div class="mt-4">
                                        <InputLabel
                                            for="informal"
                                            value="Informal: "
                                        />
                                        <Textarea
                                            v-model="form.informal"
                                            rows="5"
                                            cols="30"
                                        />
                                    </div>
                                </div>
                                <div
                                    v-if="
                                        userPermissions.includes(
                                            'opciones_crear'
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
