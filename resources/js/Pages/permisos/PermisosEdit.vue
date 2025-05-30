<script setup>
import { Head, useForm, Link, usePage } from "@inertiajs/vue3";
import Layout from "@/Layouts/Layout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { confirmDialog, showToast } from "../utils/SweetAlert.service";

const props = defineProps({
    permiso: Object,
    area: Object,
});

const userPermissions = usePage().props.auth.user.permissions;

const form = useForm({
    name: props.permiso.name,
});

const submit = async () => {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Se modificara el registro!",
            "info"
        );
        if (result.isConfirmed) {
            form.patch(route("permisos.update", props.permiso.id), {
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
</script>

<template>
    <Layout :titulo="title">
        <Head title="Permisos" />

        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Nuevo Permisos</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('permisos.index')" class="px-1">
                    <h3>Permisos -</h3>
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
                                    <div class="mt-4">
                                        <InputLabel
                                            for="nombre"
                                            value="Nombre: "
                                        />
                                        <TextInput
                                            id="name"
                                            v-model="form.name"
                                            type="text"
                                            class="mt-1 block w-full"
                                            required
                                            autocomplete="new-challenge"
                                        />
                                    </div>
                                </div>
                                <div
                                    v-if="
                                        userPermissions.includes(
                                            'permisos_editar'
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
                                            Actualizar</span
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
