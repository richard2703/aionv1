<script setup>
import { onMounted, ref } from "vue";
import Layout from "@/Layouts/Layout.vue";
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import InputError from "@/Components/InputError.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { showToast } from "../utils/SweetAlert.service";

const props = defineProps({
    areas: Array,
    departamentos: Array || null,
    roles: Array,
});

const areas = ref(props.areas);
const departamentos = ref(props.departamentos);
const roles = ref(props.roles);
const userPermissions = usePage().props.auth.user.permissions;
const userRol = ref(usePage().props.auth.user.roles);
const empresas = ref("");

async function getAreas() {
    await axios
        .get("/api/areas")
        .then((response) => (areas.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}

const form = useForm({
    name: "",
    email: "",
    password: "",
    password_confirmation: "",
    area_id: "",
    departamento_id: "",
    empresa_id: "",
    roles: [],
});

const getEmpresas = async () => {
    await axios.get(route("empresas.findAll")).then((response) => {
        console.log("empresas", response.data);

        if (userRol.value.includes("admin")) {
            empresas.value = response.data.filter((item) => {
                return item.id === usePage().props.auth.user.empresa.id;
            });
        } else {
            empresas.value = response.data;
        }
    });
};

const onChange = async (event) => {
    const target_id = event.target.value;
    await axios
        .get(route("departamentos.byArea", target_id))
        .then((response) => (departamentos.value = response.data.departamentos))
        .catch((error) => {
            console.log(error);
        });
};

const submit = async () => {
    try {
        form.post(route("user.store"), {
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
    // empresas = userRol.value.includes("admin")
    //     ? ref(usePage().props.auth.user.empresa.nombre)
    //     : ref("");
    getEmpresas();
});
</script>

<template>
    <Layout>
        <Head title="Usuario" />
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
                <Link :href="route('user.create')" class="active">
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
                                <div>
                                    <InputLabel for="name" value="Nombre" />
                                    <TextInput
                                        id="name"
                                        v-model="form.name"
                                        type="text"
                                        class="mt-1 block w-full"
                                        required
                                        autofocus
                                        autocomplete="name"
                                    />
                                    <InputError
                                        class="mt-2"
                                        :message="form.errors.name"
                                    />
                                </div>

                                <div class="mt-4">
                                    <InputLabel
                                        for="email"
                                        value="Correo electronico"
                                    />
                                    <TextInput
                                        id="email"
                                        v-model="form.email"
                                        type="email"
                                        class="mt-1 block w-full"
                                        required
                                        autocomplete="username"
                                    />
                                    <InputError
                                        class="mt-2"
                                        :message="form.errors.email"
                                    />
                                </div>

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
                                        for="departamento_id"
                                        value="Flujo de valor: "
                                    />
                                    <select
                                        ref="departamento_select"
                                        class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                        v-model="form.departamento_id"
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
                                        for="empresa_id"
                                        value="Compañia: "
                                    />
                                    <select
                                        ref="empresa_select"
                                        class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                        v-model="form.empresa_id"
                                        required
                                    >
                                        <option value="" disabled selected>
                                            Seleccione una opcion
                                        </option>
                                        <option
                                            v-for="empresa in empresas"
                                            :key="empresa.id"
                                            :value="empresa.id"
                                        >
                                            {{ empresa.nombre }}
                                        </option>
                                    </select>
                                </div>

                                <div class="mt-4">
                                    <InputLabel value="Roles: " />
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
                                                        v-model="form.roles"
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
                                                            role.name ===
                                                            'admin'
                                                        "
                                                    >
                                                        <input
                                                            type="checkbox"
                                                            v-model="form.roles"
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
                                                            v-model="form.roles"
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

                                <div class="mt-4">
                                    <InputLabel
                                        for="password"
                                        value="Password"
                                    />
                                    <TextInput
                                        id="password"
                                        v-model="form.password"
                                        type="password"
                                        class="mt-1 block w-full"
                                        required
                                        autocomplete="new-password"
                                    />
                                    <InputError
                                        class="mt-2"
                                        :message="form.errors.password"
                                    />
                                </div>

                                <div class="mt-4">
                                    <InputLabel
                                        for="password_confirmation"
                                        value="Confirm Password"
                                    />
                                    <TextInput
                                        id="password_confirmation"
                                        v-model="form.password_confirmation"
                                        type="password"
                                        class="mt-1 block w-full"
                                        required
                                        autocomplete="new-password"
                                    />
                                    <InputError
                                        class="mt-2"
                                        :message="
                                            form.errors.password_confirmation
                                        "
                                    />
                                </div>

                                <div class="flex items-center justify-end mt-4">
                                    <div
                                        v-if="
                                            userPermissions.includes(
                                                'usuarios_crear'
                                            )
                                        "
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
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>
