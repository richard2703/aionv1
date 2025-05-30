<template>
    <div class="flex flex-col h-screen">
        <!-- Header -->
        <header
            class="flex items-center justify-between bg-gray-800 text-white p-4"
        >
            <div class="flex items-center gap-4">
                <button @click="isOpen = !isOpen" class="text-white md:hidden">
                    <i class="pi pi-bars text-2xl"></i>
                </button>
                <Link href="/" class="flex items-center gap-2">
                    <Logo class="h-10" />
                    <span class="text-lg font-bold">AION Business</span>
                </Link>
            </div>
            <nav class="flex items-center gap-4">
                <div class="relative">
                    <button
                        class="relative text-gray-300 hover:text-white"
                        @click="toggleNotificationMenu"
                    >
                        <i class="pi pi-bell text-xl"></i>
                        <span
                            v-if="countNotifications"
                            class="absolute top-0 right-0 bg-red-500 text-white text-xs w-4 h-4 flex items-center justify-center rounded-full"
                            >{{ countNotifications }}</span
                        >
                    </button>
                </div>
                <div class="relative">
                    <button
                        @click="toggleProfileMenu"
                        class="flex items-center gap-2"
                    >
                        <i
                            :class="[
                                'pi',
                                profileMenuOpen
                                    ? 'pi-chevron-up'
                                    : 'pi-chevron-down',
                            ]"
                        ></i>
                    </button>

                    <div
                        v-if="notificationMenuOpen"
                        class="absolute right-0 mt-2 w-48 bg-white text-gray-800 rounded shadow-lg z-50"
                    >
                        <h3
                            class="px-4 py-2 border-b bg-gray-800 text-sm text-gray-100"
                        >
                            Notificaciones
                        </h3>
                        <div class="mt-2 text-sm bg-white rounded shadow-xl">
                            <div class="block flex justify-end">
                                <Link
                                    class="px-2 py-1 hover:bg-blue-50 text-xs text-blue-500 position-fixed hover:text-blue-300"
                                    @click="markAsRead"
                                >
                                    marcarcon como leido
                                </Link>
                                <Link
                                    class="px-2 py-1 hover:bg-blue-50 text-xs text-blue-500 position-fixed hover:text-blue-300"
                                    @click="deleteReaded"
                                >
                                    Borrar leidos
                                </Link>
                            </div>
                            <div v-for="notification in userNotifications">
                                <Link
                                    v-if="notification.readed == 0"
                                    class="block px-6 py-2 hover:text-white hover:bg-neutral-500"
                                    :href="notification.link"
                                >
                                    {{ notification.titulo }}
                                </Link>
                                <Link
                                    v-if="notification.readed == 1"
                                    class="flex justify-between block px-6 py-2 text-white bg-neutral-400 hover:bg-neutral-500"
                                    :href="notification.link"
                                >
                                    <span>
                                        {{ notification.titulo }}
                                    </span>
                                    <span> ✅ </span>
                                </Link>
                            </div>
                        </div>
                    </div>
                    <div
                        v-if="profileMenuOpen"
                        class="absolute right-0 mt-2 w-48 bg-white text-gray-800 rounded shadow-lg z-50"
                    >
                        <h3
                            class="px-4 py-2 border-b bg-gray-800 text-gray-100"
                        >
                            {{ $page.props.auth.user.user.name }}
                        </h3>

                        <Link
                            class="block w-full text-left px-4 py-2 hover:bg-gray-100"
                            href="/user/profile"
                            >Perfil de Usuario</Link
                        >
                        <Link
                            class="block w-full text-left px-4 py-2 hover:bg-gray-100"
                            href="/tareas/mis-tareas"
                            >Mis Tareas</Link
                        >
                        <Link
                            class="block w-full text-left px-4 py-2 hover:bg-gray-100"
                            href="/logout"
                            method="post"
                            as="button"
                            >Cerrar sesión</Link
                        >
                    </div>
                </div>
            </nav>
        </header>

        <!-- Content Area -->
        <div class="flex flex-1 h-full mb-4">
            <!-- Sidebar -->
            <div
                :class="[
                    'bg-gray-800 text-white w-60 p-1',
                    { hidden: !isOpen, block: isOpen },
                    'md:block',
                    'z-50',
                    'md:static',
                    'absolute',
                    'h-screen overflow-auto',
                    'mb-4',
                ]"
            >
                <nav class="flex flex-col space-y-2">
                    <div v-for="item in filteredMenu" :key="item.label">
                        <button
                            @click="
                                item.children
                                    ? toggleSubmenu(item)
                                    : $inertia.visit(route(`${item.route}`))
                            "
                            class="flex items-center justify-between p-2 rounded-md hover:bg-gray-700 hover:text-[#dfb569] w-full"
                        >
                            <div class="flex items-center gap-3">
                                <!-- <i :class="item.icon" class="pi w-5 h-5"></i> -->
                                <span
                                    :class="
                                        openMenus.includes(item)
                                            ? 'text-[#dfb569]'
                                            : ''
                                    "
                                    >{{ item.label }}</span
                                >
                            </div>
                            <i
                                v-if="item.children"
                                :class="[
                                    'pi',
                                    openMenus.includes(item)
                                        ? 'pi-chevron-down'
                                        : 'pi-chevron-right',
                                ]"
                                class="transition-transform"
                            ></i>
                        </button>
                        <div
                            v-if="item.children && openMenus.includes(item)"
                            class="pl-6 space-y-2 max-h-screen"
                        >
                            <button
                                v-for="child in item.children"
                                :key="child.label"
                                @click="handleClick(child)"
                                class="flex items-center gap-3 p-2 rounded-md hover:bg-gray-700"
                            >
                                <i :class="child.icon" class="pi w-5 h-5"></i>
                                <span>{{ child.label }}</span>
                            </button>
                        </div>
                    </div>
                </nav>
            </div>

            <!-- Main content -->
            <div class="flex-1 bg-gray-100 p-6 overflow-auto no-scrollbar">
                <main>
                    <slot />
                </main>
            </div>
            <!-- Botón para el sidebar derecho -->
            <button
                @click="isRightSidebarOpen = !isRightSidebarOpen"
                class="text-white bg-gray-800 hover:bg-gray-500 w-7"
            >
                <i
                    :class="[
                        'pi text-2xl',
                        isRightSidebarOpen
                            ? 'pi-angle-double-right'
                            : 'pi-angle-double-left',
                    ]"
                ></i>
            </button>
            <!-- Sidebar Derecho -->
            <div
                v-if="isRightSidebarOpen"
                class="fixed flex top-0 right-0 w-96 h-screen bg-gray-800 text-white shadow-lg z-50 transition-transform transform translate-x-0"
            >
                <div
                    @click="isRightSidebarOpen = false"
                    class="flex items-center justify-center block w-7 p-4 border-b border-gray-700 hover:text-white hover:bg-gray-500"
                >
                    <button
                        @click="isRightSidebarOpen = false"
                        class="text-white"
                    >
                        <i class="pi pi-angle-double-right text-2xl"></i>
                    </button>
                </div>
                <!-- <nav class="flex flex-col space-y-2 p-4">
                    <div v-for="item in rightSidebarItems" :key="item.label">
                        <button
                            @click="item.action"
                            class="flex items-center gap-3 p-2 rounded-md hover:bg-gray-700 w-full"
                        >
                            <i :class="item.icon" class="pi w-5 h-5"></i>
                            <span>{{ item.label }}</span>
                        </button>
                    </div>
                </nav> -->
                <div class="text-white overflow-y-auto">
                    <div class="p-2">
                        <Calendario />
                    </div>

                    <div v-if="titulo === 'reportes semanales'">
                        <div>
                            <button
                                @click="() => (isMinutasModal = true)"
                                class="flex items-center gap-3 p-2 rounded-md hover:bg-gray-700 w-full"
                            >
                                <span>Tareas en minutas</span>
                            </button>
                        </div>

                        <div class="p-2">
                            <Comentario
                                :reporte_semanal_id="reporteSemanal.id"
                            />
                        </div>
                    </div>
                </div>
            </div>

            <!-- Fondo de superposición -->
            <div
                v-if="isRightSidebarOpen"
                @click="isRightSidebarOpen = false"
                class="fixed inset-0 bg-black bg-opacity-50 z-40"
            ></div>
        </div>
    </div>
    <!-- Modal de minutas -->
    <Modal
        :show="isMinutasModal"
        @close="isMinutasModal = false"
        class="w-[80%]"
    >
        <template v-slot="{ modalData }">
            <MinutasList @newTarea="tareaCreate" />
        </template>
    </Modal>

    <Modal
        :show="isTareasModal"
        @close="isTareasModal = false"
        class="w-[80%]"
        :modal-data="minuta"
    >
        <template v-slot="{ modalData }">
            <TareasCreate
                class="z-50"
                :minuta="modalData"
                @close="isTareasModal = false"
                @tareaGuardada="actualizarTareas"
            />
        </template>
    </Modal>
</template>

<script setup>
import { onMounted, ref } from "vue";
import Logo from "./Shared/Logo.vue";
import { Link, usePage } from "@inertiajs/vue3";
import Comentario from "@/Components/Comentarios/Comentario.vue";
import Calendario from "@/Components/Calendario.vue";

import Modal from "@/Components/Modal.vue";
import MinutasList from "@/Components/Minutas/MinutasList.vue";
import TareasCreate from "@/Pages/Minutas/Partials/Tareas/TareasCreate.vue";
import axios from "axios";

const props = defineProps({
    titulo: String,
    subTitulo: String,
    reporteSemanal: Object | null,
});

const titulo = ref(props.titulo);
const subTitulo = ref(props.subTitulo);
const isOpen = ref(false);
const profileMenuOpen = ref(false);
const notificationMenuOpen = ref(false);
const openMenus = ref([]);
const userAuth = usePage().props.auth.user.roles;

const isRightSidebarOpen = ref(false); // Sidebar derecho

const isMinutasModal = ref(false);
const isTareasModal = ref(false);
const minuta = ref("");

const rightSidebarItems = ref([
    {
        label: "Elemento 1",
        icon: "pi pi-home",
        action: () => alert("Acción 1"),
    },
    { label: "Elemento 2", icon: "pi pi-cog", action: () => alert("Acción 2") },
    {
        label: "Elemento 3",
        icon: "pi pi-user",
        action: () => alert("Acción 3"),
    },
]);

const menuItems = [
    {
        label: "Alineación",
        route: "dashboard",
        icon: "",
        role: ["admin", "user", "superadmin", "lider_pilar"],
    },
    {
        label: "Identificación",
        icon: "",
        role: ["admin", "superadmin", "user"],
        children: [
            {
                label: "Desperdicios",
                route: "desperdicio.index",
                icon: "",
                role: ["admin", "superadmin", "user"],
            },
            {
                label: "Evaluaciones",
                route: "evaluacion.index",
                icon: "",
                role: ["lider_pilar", "admin", "superadmin", "user"],
            },
            {
                label: "Metas (30 60 90)",
                route: "metas.index",
                icon: "",
                role: ["admin", "superadmin", "user"],
            },
            {
                label: "Mis Metas (30 60 90)",
                route: "Mismetas.index",
                icon: "",
                role: ["admin", "superadmin", "user"],
            },
            {
                label: "Mis Reportes",
                route: "misreporte.index",
                icon: "",
                role: ["admin", "superadmin", "user"],
            },
            {
                label: "Dashboard",
                route: "sysgestion.dashboard",
                icon: "",
                role: ["admin", "superadmin", "user"],
            },
            {
                label: "ScoreCard",
                route: "scoreCard.index",
                icon: "",
                role: ["admin", "superadmin", "user"],
            },
        ],
    },
    {
        label: "Optimización",
        icon: "",
        role: ["admin", "superadmin", "user"],
        children: [
            {
                label: "PDCA",
                route: "sysgestion.index",
                icon: "",
                role: ["admin", "superadmin", "user"],
            },
            {
                label: "Minutas",
                route: "minutas.index",
                icon: "",
                role: ["admin", "superadmin", "user"],
            },
            {
                label: "Reportes",
                route: "reporte.index",
                icon: "",
                role: ["admin", "superadmin", "user"],
            },
        ],
    },
    {
        label: "Networking",
        icon: "",
        role: ["admin", "user", "superadmin"],
        children: [
            {
                label: "Capacitación",
                route: "https://laproductivitycenter.com",
                icon: "",
                role: ["admin", "user", "superadmin", "lider_pilar"],
            },
            {
                label: "Directorio de Proveedores",
                route: "proveedores.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "NotebookLM",
                route: "https://notebooklm.google/",
                icon: "",
                role: ["user", "admin", "superadmin"],
            },
            {
                label: "Favoritos",
                route: "minutas.misminutas",
                icon: "",
                role: ["admin", "superadmin", "user"],
            },
        ],
    },
    {
        label: "Configuraciones",
        icon: "",
        role: ["admin", "superadmin", "user"],
        children: [
            {
                label: "Pilares",
                route: "area.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "Flujos de valor",
                route: "departamento.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "Usuarios",
                route: "user.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "Compañias",
                route: "empresas.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "Líderes de flujo",
                route: "encargadoFlujo.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "Tipos de desperdicios",
                route: "tiposDesperdicios.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "Eventos",
                route: "eventos.index",
                icon: "",
                role: ["superadmin", "eventos"],
            },
            {
                label: "Secciones",
                route: "seccion.index",
                icon: "",
                role: ["superadmin"],
            },
            {
                label: "Challenges",
                route: "challenge.index",
                icon: "",
                role: ["superadmin"],
            },
            {
                label: "Opciones",
                route: "opcion.index",
                icon: "",
                role: ["superadmin"],
            },
            {
                label: "Personalizaciones",
                route: "config.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "Objetivo",
                route: "objetivo.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "Procesos",
                route: "proceso.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "Procedimientos",
                route: "procedimiento.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "Estándares",
                route: "estandar.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "KPIs",
                route: "kpi.index",
                icon: "",
                role: ["admin", "superadmin", "user"],
            },
            {
                label: "Roles",
                route: "roles.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
            {
                label: "Permisos",
                route: "permisos.index",
                icon: "",
                role: ["admin", "superadmin"],
            },
        ],
    },
    {
        label: "Ayuda",
        icon: "",
        role: ["admin", "user", "superadmin"],
        children: [
            {
                label: "Tutorial",
                route: "tutorial.index",
                icon: "",
                role: ["user", "admin", "superadmin"],
            },
            {
                label: "Términos y condiciones",
                route: "terminos.index",
                icon: "",
                role: ["user", "admin", "superadmin"],
            },
        ],
    },
];

const userNotifications = ref([]);
const countNotifications = ref(0);

onMounted(() => {
    getNotifications();
});

async function markAsRead() {
    await axios.get(route("notificaciones.markAsRead"));
}

async function deleteReaded() {
    await axios.get(route("notificaciones.deleteReaded"));
}

function navigate(route) {
    window.open(route, "_blank").focus();
    // Use your router here, e.g., router.push(route)
}

function toggleSubmenu(item) {
    if (openMenus.value.includes(item)) {
        openMenus.value = openMenus.value.filter((i) => i !== item);
    } else {
        openMenus.value.push(item);
    }
}

function toggleProfileMenu() {
    profileMenuOpen.value = !profileMenuOpen.value;
    notificationMenuOpen.value = false;
}

function toggleNotificationMenu() {
    notificationMenuOpen.value = !notificationMenuOpen.value;
    profileMenuOpen.value = false;
}

function logout() {
    console.log("Logging out");
    // Implement logout logic
}

// const hasRole = (role) => roles.includes(role);
// Función para filtrar el menú según roles
const filterMenuByRole = (menu, roles) => {
    return menu
        .filter((item) => item.role.some((role) => roles.includes(role))) // Filtra elementos con roles válidos
        .map((item) => ({
            ...item,
            children: item.children
                ? filterMenuByRole(item.children, roles)
                : undefined, // Filtra hijos recursivamente
        }))
        .filter((item) => !item.children || item.children.length > 0); // Remueve padres sin hijos válidos
};
const filteredMenu = filterMenuByRole(menuItems, userAuth);

const getNotifications = async () => {
    try {
        const response = await axios.get(route("notificaciones.getByUser"));
        userNotifications.value = response.data;
        countNotifications.value = response.data.filter(
            (notification) => notification.readed == 0
        ).length;
    } catch (error) {
        console.error("Error fetching notifications:", error);
    }
};

const tareaCreate = async (minuta_id) => {
    console.log("desde layout", { minuta_id });
    await axios.get(route("minutas.byId", minuta_id)).then((response) => {
        console.log({ minuta: response.data });
        minuta.value = response.data;
    });
    isMinutasModal.value = false;
    isTareasModal.value = true;
};

// TODO: retirar del arreglo "NotebookLM" si se implementa el "embedded"
function handleClick(child) {
    if (["Capacitación", "NotebookLM"].includes(child.label)) {
        // navigate to external URL
        navigate(child.route);
    } else {
        // navigate to route
        window.location.href = route(child.route);
    }
    // add more conditions or logic here
}
</script>

<style>
body {
    @apply antialiased;
}
</style>
