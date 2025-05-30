<script setup>
import { onMounted, ref } from "vue";
import Layout from "@/Layouts/Layout.vue";
import { Head, useForm, Link, usePage } from "@inertiajs/vue3";
import SectionBorder from "@/Components/SectionBorder.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { confirmDialog, showToast } from "../utils/SweetAlert.service";

const props = defineProps({
    usuario: Object,
    areas: Array,
    departamentos: Array || null,
    roles: Array,
    roles_usuario: Array,
});

const usuario = ref(props.usuario);
const areas = ref(props.areas);
const departamentos = ref(props.departamentos);
const roles = ref(props.roles);
const userArea = usuario.value.area_id;
const userPermissions = usePage().props.auth.user.permissions;
const userRol = ref(usePage().props.auth.user.roles);
const empresa = ref(usePage().props.auth.user.empresa.nombre);

const profileForm = useForm({
    name: usuario.value.name,
    email: usuario.value.email,
    area_id: usuario.value.area_id,
    departamento_id: usuario.value.departamento_id,
    // roles: usuario.value.roles.map(role => role.name),
    roles: usuario.value.roles
        ? usuario.value.roles.map((role) => role.name)
        : [],
    selectedRoles: props.roles_usuario,
    empresa: empresa.value,
});

const passwordForm = useForm({
    password: "",
    password_confirmation: "",
});

async function getAreas() {
    await axios
        .get("/api/areas")
        .then((response) => (areas.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}

async function getDepartamentos(userArea) {
    await axios
        .get(route("departamentos.byArea", userArea))
        .then((response) => (departamentos.value = response.data.departamentos))
        .catch((error) => {
            console.log(error);
        });
}

async function onChange(event) {
    const taget_id = event.target.value;
    await axios
        .get(route("departamentos.byArea", taget_id))
        .then((response) => (departamentos.value = response.data.departamentos))
        .catch((error) => {
            console.log(error);
        });
}

async function submitProfile() {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Se modificara el registro!",
            "info"
        );
        if (result.isConfirmed) {
            profileForm.patch(route("user.update", usuario.value.id), {
                onFinish: () => {
                    showToast("El registro ha sido actualizado", "success");
                    profileForm.reset();
                },
            });
        }
    } catch (error) {
        console.error(error);
        showToast("Ocurrio un error", "error");
    }
}

async function submitPassword() {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Se modificara la contraseña del usuario!",
            "warning"
        );
        if (result.isConfirmed) {
            passwordForm.patch(route("user.updatePassword", usuario.value.id), {
                onFinish: () => {
                    showToast("La contraseña ha sido actualizada", "success");
                    passwordForm.reset();
                },
            });
        }
    } catch (error) {
        console.error(error);
        showToast("Ocurrio un error", "error");
    }
}

onMounted(() => {
    getAreas();
    getDepartamentos(userArea);
});
</script>

<template>
    <Layout>
        <Head title="Perfil" />

        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Usuarios</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('user.index')" class="px-1">
                    <h3>Usuarios -</h3>
                </Link>
                <Link :href="route('user.edit', usuario.id)" class="active">
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
                            <form @submit.prevent="submitProfile">
                                <!-- Name -->
                                <div class="col-span-6 sm:col-span-4">
                                    <InputLabel for="name" value="Nombre:" />
                                    <TextInput
                                        id="name"
                                        v-model="profileForm.name"
                                        type="text"
                                        class="mt-1 block w-full"
                                        required
                                        autocomplete="name"
                                    />
                                    <InputError
                                        :message="profileForm.errors.name"
                                        class="mt-2"
                                    />
                                </div>

                                <!-- Email -->
                                <div class="col-span-6 sm:col-span-4">
                                    <InputLabel
                                        for="email"
                                        value="Correo electrónico:"
                                    />
                                    <TextInput
                                        id="email"
                                        v-model="profileForm.email"
                                        type="email"
                                        class="mt-1 block w-full"
                                        required
                                        autocomplete="username"
                                    />
                                    <InputError
                                        :message="profileForm.errors.email"
                                        class="mt-2"
                                    />

                                    <div
                                        v-if="
                                            $page.props.jetstream
                                                .hasEmailVerification &&
                                            user.email_verified_at === null
                                        "
                                    >
                                        <p class="text-sm mt-2">
                                            Your email address is unverified.

                                            <Link
                                                :href="
                                                    route('verification.send')
                                                "
                                                method="post"
                                                as="button"
                                                class="underline text-sm text-gray-600 hover:text-gray-900 rounded-md focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                                                @click.prevent="
                                                    sendEmailVerification
                                                "
                                            >
                                                Click here to re-send the
                                                verification email.
                                            </Link>
                                        </p>

                                        <div
                                            v-show="verificationLinkSent"
                                            class="mt-2 font-medium text-sm text-green-600"
                                        >
                                            A new verification link has been
                                            sent to your email address.
                                        </div>
                                    </div>
                                </div>

                                <!-- Area -->
                                <div class="mt-4">
                                    <InputLabel for="area_id" value="Pilar: " />
                                    <select
                                        ref="area_select"
                                        @change="onChange($event)"
                                        class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                        v-model="profileForm.area_id"
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

                                <!-- Departamento -->
                                <div class="mt-4">
                                    <InputLabel
                                        for="departamento_id"
                                        value="Flujo de valor: "
                                    />
                                    <select
                                        ref="departamento_select"
                                        class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                        v-model="profileForm.departamento_id"
                                        required
                                    >
                                        <option value="" disabled selected>
                                            Seleccione una opcion
                                        </option>
                                        <option
                                            v-for="departamento in departamentos"
                                            :key="departamento.id"
                                            :value="departamento.id"
                                        >
                                            {{ departamento.nombre }}
                                        </option>
                                    </select>
                                </div>

                                <div class="mt-4">
                                    <InputLabel
                                        for="empresa"
                                        value="Compañia: "
                                    />
                                    <InputLabel
                                        for="empresa-name"
                                        class="text-[20px] font-bold pl-6"
                                        :value="profileForm.empresa"
                                    />
                                </div>

                                <!-- Roles -->
                                <!-- <div class="mt-4">
                                    <InputLabel for="roles" value="Roles: " />
                                    <select multiple
                                        class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                        v-model="profileForm.roles" required>
                                        <option v-for="role in roles" :key="role.name" :value="role.name">
                                            {{ role.name }}
                                        </option>
                                    </select>
                                </div> -->

                                <div class="mt-4">
                                    <InputLabel for="roles" value="Rol: " />
                                    <div>
                                        <div
                                            v-for="role in roles"
                                            :key="role.id"
                                            class="mt-2"
                                        >
                                            <label class="flex items-center">
                                                <div
                                                    v-if="
                                                        $page.props.auth.user.roles.includes(
                                                            'superadmin'
                                                        )
                                                    "
                                                >
                                                    <input
                                                        type="checkbox"
                                                        v-model="
                                                            profileForm.selectedRoles
                                                        "
                                                        :value="role.id"
                                                        class="form-checkbox"
                                                    />
                                                    <span class="ml-2">{{
                                                        role.name
                                                    }}</span>
                                                </div>
                                                <div
                                                    v-else-if="
                                                        $page.props.auth.user.roles.includes(
                                                            'admin'
                                                        )
                                                    "
                                                >
                                                    <div
                                                        v-if="
                                                            role.name !==
                                                                'superadmin' &&
                                                            role.name !==
                                                                'lider_pilar'
                                                        "
                                                    >
                                                        <input
                                                            type="checkbox"
                                                            v-model="
                                                                profileForm.selectedRoles
                                                            "
                                                            :value="role.id"
                                                            class="form-checkbox"
                                                        />
                                                        <span class="ml-2">{{
                                                            role.name
                                                        }}</span>
                                                    </div>
                                                </div>
                                                <div v-else>
                                                    <div
                                                        v-if="
                                                            role.name === 'user'
                                                        "
                                                    >
                                                        <input
                                                            type="checkbox"
                                                            v-model="
                                                                profileForm.selectedRoles
                                                            "
                                                            :value="role.id"
                                                            class="form-checkbox"
                                                        />
                                                        <span class="ml-2">{{
                                                            role.name
                                                        }}</span>
                                                    </div>
                                                </div>
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <!-- <div class="mt-4">
                                        <InputLabel value="Permisos: " />
                                        <div>
                                            <div v-for="permiso in props.permissions" :key="permiso.id" class="mt-2">
                                                <label class="flex items-center">
                                                    <input type="checkbox" v-model="form.selectedPermisos"
                                                        :value="permiso.id" class="form-checkbox" />
                                                    <span class="ml-2">{{ permiso.name }}</span>
                                                </label>
                                            </div>
                                        </div>
                                    </div> -->

                                <div class="flex items-center justify-end mt-4">
                                    <div
                                        v-if="
                                            userPermissions.includes(
                                                'usuarios_editar'
                                            )
                                        "
                                    >
                                        <PrimaryButton
                                            class="ms-4 pi pi-save"
                                            :class="{
                                                'opacity-25':
                                                    profileForm.processing,
                                            }"
                                            :disabled="profileForm.processing"
                                        >
                                            <span
                                                class="p-1"
                                                :style="{
                                                    fontSize: '10px',
                                                }"
                                            >
                                                Actualizar perfil</span
                                            >
                                        </PrimaryButton>
                                    </div>
                                </div>
                            </form>

                            <SectionBorder />

                            <h2 class="text-2xl my-4">Cambio de contraseña</h2>

                            <form @submit.prevent="submitPassword">
                                <div class="col-span-6 sm:col-span-4">
                                    <InputLabel
                                        for="password"
                                        value="Nueva contraseña"
                                    />
                                    <TextInput
                                        id="password"
                                        ref="passwordInput"
                                        v-model="passwordForm.password"
                                        type="password"
                                        class="mt-1 block w-full"
                                        autocomplete="new-password"
                                    />
                                    <InputError
                                        :message="passwordForm.errors.password"
                                        class="mt-2"
                                    />
                                </div>

                                <div class="col-span-6 sm:col-span-4">
                                    <InputLabel
                                        for="password_confirmation"
                                        value="Confirmar contraseña"
                                    />
                                    <TextInput
                                        id="password_confirmation"
                                        v-model="
                                            passwordForm.password_confirmation
                                        "
                                        type="password"
                                        class="mt-1 block w-full"
                                        autocomplete="new-password"
                                    />
                                    <InputError
                                        :message="
                                            passwordForm.errors
                                                .password_confirmation
                                        "
                                        class="mt-2"
                                    />
                                </div>

                                <div class="flex items-center justify-end mt-4">
                                    <div
                                        v-if="
                                            userPermissions.includes(
                                                'usuarios_editar'
                                            )
                                        "
                                    >
                                        <PrimaryButton
                                            class="ms-4 pi pi-save"
                                            :class="{
                                                'opacity-25':
                                                    passwordForm.processing,
                                            }"
                                            :disabled="passwordForm.processing"
                                        >
                                            <span
                                                class="p-1"
                                                :style="{
                                                    fontSize: '10px',
                                                }"
                                            >
                                                Actualizar contraseña</span
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
