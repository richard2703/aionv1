<script setup>
import { ref } from "vue";
import Layout from "@/Layouts/Layout.vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { showToast } from "../utils/SweetAlert.service";
import TextInput from "@/Components/TextInput.vue";
import InputError from "@/Components/InputError.vue";

const props = defineProps({
    areas: Array,
    departamentos: Array || null,
    challenges: Array || null,
});

const title = "Objetivos";
const departamentos = ref(props.departamentos);
const challenges = ref(props.challenges);
const userPermissions = usePage().props.auth.user.permissions;

const form = useForm({
    objetivo: "",
    meta: "",
});

const onChangeArea = async (event) => {
    const taget_id = event.target.value;
    await axios
        .get(route("departamentos.byArea", taget_id))
        .then((response) => (departamentos.value = response.data.departamentos))
        .catch((error) => {
            console.log(error);
        });
};

const onChangeDepartamento = async (event) => {
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
        form.post(route("objetivo.store"), {
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
    <Layout :titulo="title">
        <Head title="Objetivos" />

        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Objetivo Nuevo</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('objetivo.index')" class="px-1">
                    <h3>Objetivos -</h3>
                </Link>
                <h3>Nuevo</h3>
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
                                            for="objetivo"
                                            value="Objetivo: "
                                        />
                                        <TextInput
                                            id="objetivo"
                                            v-model="form.objetivo"
                                            type="text"
                                            class="mt-1 block w-full"
                                            required
                                            autofocus
                                            autocomplete="objetivo"
                                        />
                                        <InputError
                                            class="mt-2"
                                            :message="form.errors.objetivo"
                                        />
                                    </div>
                                    <div class="mt-4">
                                        <InputLabel for="meta" value="Meta: " />
                                        <TextInput
                                            id="meta"
                                            v-model="form.meta"
                                            type="text"
                                            class="mt-1 block w-full"
                                            required
                                            autocomplete="meta"
                                        />
                                        <InputError
                                            class="mt-2"
                                            :message="form.errors.meta"
                                        />
                                    </div>
                                </div>

                                <div
                                    v-if="
                                        userPermissions.includes(
                                            'objetivos_crear'
                                        )
                                    "
                                    class="px-4 my-4 pt-2 flex justify-end bg-white border-t border-gray-200"
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
