<script setup>
import { ref, onMounted } from "vue";
import { Head, useForm, Link, usePage } from "@inertiajs/vue3";
import Layout from "@/Layouts/Layout.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { showToast } from "../utils/SweetAlert.service";
import ConfigDashboard from "@/Pages/Config/Partials/ConfigDashboard.vue";
import ConfigTipoMinuta from "@/Pages/Config/Partials/ConfigTipoMinuta.vue";
import ConfigPortada from "@/Pages/Config/Partials/ConfigPortada.vue";
import ConfigEventos from "./Partials/ConfigEventos.vue";

const count = ref(0);
const userPermissions = usePage().props.auth.user.permissions;
const template = ref("");
onMounted(() => {
    if (userPermissions.includes("personalizacion_home")) {
        template.value = "dashboard";
        return;
    } else if (userPermissions.includes("personalizacion_portada_reporte")) {
        template.value = "Portada";
        return;
    } else if (userPermissions.includes("personalizacion_tipo_minutas")) {
        template.value = "tipoMinuta";
        return;
    } else if (userPermissions.includes("personalizacion_eventos")) {
        template.value = "eventos";
        return;
    } else {
        template.value = "";
        return;
    }
});
// const template = userPermissions.includes("personalizacion_home")
//     ? ref("dashboard")
//     : ref("");
</script>

<template>
    <Layout title="Personalizaciones">
        <Head title="Personalizaciones" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Personalizaciones</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('config.index')" class="px-1">
                    <h3>Personalización</h3>
                </Link>
            </div>
        </div>

        <div>
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>
                    <div
                        class="px-4 my-4 py-2 flex justify-end bg-white border-b border-gray-200"
                    ></div>
                    <div class="px-4 py-2 bg-white border-b border-gray-200">
                        <div class="container mx-auto">
                            <div
                                class="grid sm:grid-cols-1 md:grid-cols-2 bg-slate-50"
                            >
                                <div class="bg-white p-4">
                                    <h2 class="text-2xl">
                                        Menu de Personalización
                                    </h2>

                                    <ul class="space-y-2">
                                        <li
                                            class="text-blue-300 hover:text-blue-800 font-bold text-xl"
                                        >
                                            <div
                                                v-if="
                                                    userPermissions.includes(
                                                        'personalizacion_home'
                                                    )
                                                "
                                            >
                                                <button
                                                    @click="
                                                        template = 'dashboard'
                                                    "
                                                >
                                                    Dashboard
                                                </button>
                                            </div>
                                        </li>
                                        <!-- TODO: eliminar si no se usa -->
                                        <li
                                            class="text-blue-300 hover:text-blue-800 font-bold text-xl"
                                        >
                                            <div
                                                v-if="
                                                    userPermissions.includes(
                                                        'personalizacion_tipo_minutas'
                                                    )
                                                "
                                            >
                                                <button
                                                    @click="
                                                        template = 'tipoMinuta'
                                                    "
                                                >
                                                    Tipos de minuta
                                                </button>
                                            </div>
                                        </li>

                                        <li
                                            class="text-blue-300 hover:text-blue-800 font-bold text-xl"
                                        >
                                            <div
                                                v-if="
                                                    userPermissions.includes(
                                                        'personalizacion_portada_reporte'
                                                    )
                                                "
                                            >
                                                <button
                                                    @click="
                                                        template = 'Portada'
                                                    "
                                                >
                                                    Portada de Reporte
                                                </button>
                                            </div>
                                        </li>
                                        <li
                                            class="text-blue-300 hover:text-blue-800 font-bold text-xl"
                                        >
                                            <div
                                                v-if="
                                                    userPermissions.includes(
                                                        'personalizacion_eventos'
                                                    )
                                                "
                                            >
                                                <button
                                                    @click="
                                                        template = 'eventos'
                                                    "
                                                >
                                                    Eventos
                                                </button>
                                            </div>
                                        </li>
                                    </ul>
                                </div>
                                <div class="bg-white p-4">
                                    <ConfigDashboard
                                        v-if="template === 'dashboard'"
                                    />
                                    <ConfigTipoMinuta
                                        v-if="template === 'tipoMinuta'"
                                    />
                                    <ConfigPortada
                                        v-if="template === 'Portada'"
                                    />
                                    <ConfigEventos
                                        v-if="template === 'eventos'"
                                    />
                                    <div v-if="template === 'seccion4'">
                                        {{ template }}
                                    </div>
                                    <div v-if="template === 'seccion5'">
                                        {{ template }}
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>
