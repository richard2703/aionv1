<script setup>
import { ref } from "vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { showToast } from "../utils/SweetAlert.service";
import Layout from "@/Layouts/Layout.vue";

const props = defineProps({
    role: Object,
    permissions: Array,
    rolePermissions: Array,
});

const title = "Editar Rol";

const userPermissions = usePage().props.auth.user.permissions;

const form = useForm({
    name: props.role.name,
    descripcion: props.role.descripcion,
    selectedPermisos: props.rolePermissions,
});

const submit = () => {
    try {
        form.patch(route("roles.update", props.role.id), {
            onFinish: () => {
                showToast("El rol ha sido actualizado", "success");
            },
        });
    } catch (error) {
        showToast("Ocurrió un error", "error");
        console.error(error);
    }
};
</script>

<template>
    <Layout :titulo="title">

        <Head title="Editar Rol" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Editar Rol</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                <h3>Home -</h3>
                </Link>
                <Link :href="route('roles.index')" class="px-1">
                <h3>Roles -</h3>
                </Link>
                <Link class="active">
                <h3>Editar</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>
                    <div class="px-4 my-4 py-2 flex justify-end bg-white border-b border-gray-200"></div>
                    <div class="px-4 py-2 bg-white border-b border-gray-200">
                        <div class="container mx-auto">
                            <form @submit.prevent="submit">
                                <div class="grid grid-cols-1 gap-4">
                                    <div class="mt-4">
                                        <InputLabel for="nombre" value="Nombre: " />
                                        <TextInput id="name" v-model="form.name" type="text" class="mt-1 block w-full"
                                            required autocomplete="new-challenge" />
                                    </div>
                                    <div class="mt-4">
                                        <InputLabel for="descripcion" value="Describcion: " />
                                        <TextInput id="descripcion" v-model="form.descripcion" type="text"
                                            class="mt-1 block w-full" required autocomplete="new-challenge" />
                                    </div>
                                </div>
                                <div class="mt-4">
                                    <InputLabel value="Permisos: " />
                                    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-2">
                                        <div v-for="permiso in props.permissions" :key="permiso.id" class="mt-2">
                                            <label class="flex items-center">
                                                <input type="checkbox" v-model="form.selectedPermisos
                                                    " :value="permiso.id" class="form-checkbox" />
                                                <span class="ml-2">{{
                                                    permiso.name
                                                    }}</span>
                                            </label>
                                        </div>
                                    </div>
                                </div>
                                <div v-if="
                                    userPermissions.includes('roles_editar')
                                " class="px-4 my-4 pt-2 flex justify-end bg-white border-t border-gray-200">
                                    <PrimaryButton class="ms-4 pi pi-save" :class="{
                                        'opacity-25': form.processing,
                                    }" :disabled="form.processing">
                                        <span class="p-1" :style="{
                                            fontSize: '10px',
                                        }">
                                            actualizar</span>
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
