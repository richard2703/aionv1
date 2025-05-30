<template>
    <div>
        <ul class="space-y-2">
            <!-- Dashboard Menu Item -->
            <li>
                <div class="mb-4">
                    <Link class="group flex items-center py-3" href="/">
                        <div
                            :class="
                                title === 'dashboard'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            <i class="pi pi-home mr-2 w-4 h-4"></i>
                            Home
                        </div>
                    </Link>
                </div>
            </li>

            <li>
                <div class="mb-4">
                    <Link
                        class="group flex items-center py-3"
                        :href="route('minutas.index')"
                    >
                        <div
                            :class="
                                title === 'minutero'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            <i class="pi pi-briefcase mr-2 w-4 h-4"></i>
                            Minutero
                        </div>
                    </Link>
                </div>
            </li>

            <!-- <li>
                <div class="mb-4">
                    <Link class="group flex items-center py-3" :href="route('tareas.index')">
                    <div :class="title === 'tareas'
                        ? 'activo flex'
                        : 'inactivo flex'
                        ">
                        <i class="pi pi-list mr-2 w-4 h-4"></i>
                        Tareas
                    </div>
                    </Link>
                </div>
            </li> -->

            <li>
                <a
                    class="group flex items-center py-3 cursor-pointer"
                    @click="toggleMenu('sysGestion')"
                >
                    <i
                        class="pi pi-building mr-2 w-4 h-4"
                        :class="
                            title === 'sysGestion'
                                ? 'activo flex'
                                : 'inactivo flex'
                        "
                    ></i>
                    <div
                        :class="
                            title === 'sysGestion'
                                ? 'activo flex'
                                : 'inactivo flex'
                        "
                    >
                        Sistema de Gestion
                    </div>
                    <icon
                        name="cheveron-down"
                        class="ml-auto w-4 h-4"
                        :class="
                            (isOpen('sysGestion') ? 'rotate-180' : '',
                            title === 'sysGestion'
                                ? 'activo flex'
                                : 'inactivo flex')
                        "
                    />
                </a>
                <ul v-show="isOpen('sysGestion')" class="pl-6 space-y-2">
                    <li>
                        <Link
                            class="group flex items-center py-2"
                            :href="route('sysgestion.dashboard')"
                            :class="
                                subTitle === 'dashboard'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            <icon name="circle" class="mr-2 w-3 h-3" />
                            <div>Dashboard</div>
                        </Link>
                    </li>
                    <li>
                        <Link
                            class="group flex items-center py-2"
                            :href="route('sysgestion.index')"
                            :class="
                                subTitle === 'pdca'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            <icon name="circle" class="mr-2 w-3 h-3" />
                            <div>PDCA</div>
                        </Link>
                    </li>
                </ul>
            </li>
            <!-- //reportes -->
            <li>
                <a
                    class="group flex items-center py-3 cursor-pointer"
                    @click="toggleMenu('reportes')"
                >
                    <i
                        class="pi pi-building mr-2 w-4 h-4"
                        :class="
                            title === 'reportes'
                                ? 'activo flex'
                                : 'inactivo flex'
                        "
                    ></i>
                    <div
                        :class="
                            title === 'reportes'
                                ? 'activo flex'
                                : 'inactivo flex'
                        "
                    >
                        Reportes
                    </div>
                    <icon
                        name="cheveron-down"
                        class="ml-auto w-4 h-4"
                        :class="
                            (isOpen('reportes') ? 'rotate-180' : '',
                            title === 'reportes'
                                ? 'activo flex'
                                : 'inactivo flex')
                        "
                    />
                </a>
                <ul v-show="isOpen('reportes')" class="pl-6 space-y-2">
                    <li>
                        <Link
                            class="group flex items-center py-2"
                            :href="route('reporte.index')"
                            :class="
                                subTitle === 'semanales'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            <icon name="circle" class="mr-2 w-3 h-3" />
                            <div>Reportes</div>
                        </Link>
                    </li>
                    <li>
                        <Link
                            class="group flex items-center py-2"
                            :href="route('misreporte.index')"
                            :class="
                                subTitle === 'pdca'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            <icon name="circle" class="mr-2 w-3 h-3" />
                            <div>Mis Reportes</div>
                        </Link>
                    </li>
                    <li>
                        <Link
                            class="group flex items-center py-2"
                            :href="route('metas.index')"
                            :class="
                                subTitle === 'pdca'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            <icon name="circle" class="mr-2 w-3 h-3" />
                            <div>Metas (30 60 90)</div>
                        </Link>
                    </li>
                    <li>
                        <Link
                            class="group flex items-center py-2"
                            :href="route('Mismetas.index')"
                            :class="
                                subTitle === 'pdca'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            <icon name="circle" class="mr-2 w-3 h-3" />
                            <div>Mis Metas (30 60 90)</div>
                        </Link>
                    </li>
                </ul>
            </li>

            <!-- //reportes -->
            <li>
                <a
                    class="group flex items-center py-3 cursor-pointer"
                    @click="toggleMenu('assessment')"
                >
                    <i
                        class="pi pi-file-check mr-2 w-4 h-4"
                        :class="
                            title === 'assessment'
                                ? 'activo flex'
                                : 'inactivo flex'
                        "
                    ></i>
                    <div
                        :class="
                            title === 'assessment'
                                ? 'activo flex'
                                : 'inactivo flex'
                        "
                    >
                        Assessment
                    </div>
                    <icon
                        name="cheveron-down"
                        class="ml-auto w-4 h-4"
                        :class="
                            (isOpen('assessment') ? 'rotate-180' : '',
                            title === 'assessment'
                                ? 'activo flex'
                                : 'inactivo flex')
                        "
                    />
                </a>
                <ul v-show="isOpen('assessment')" class="pl-6 space-y-2">
                    <li>
                        <Link
                            class="group flex items-center py-2"
                            :href="route('evaluacion.index')"
                            :class="
                                subTitle === 'evaluaciones'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            <icon name="circle" class="mr-2 w-3 h-3" />
                            <div>Evaluaciones</div>
                        </Link>
                    </li>
                </ul>
            </li>

            <!-- //Desperdicios -->
            <li>
                <div class="mb-4">
                    <Link
                        class="group flex items-center py-3"
                        :href="route('desperdicio.index')"
                    >
                        <div
                            :class="
                                title === 'Desperdicios'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            <i class="pi pi-list mr-2 w-4 h-4"></i>
                            Desperdicios
                        </div>
                    </Link>
                </div>
            </li>
            <!-- Scorecard -->
            <li>
                <div class="mb-4">
                    <Link
                        class="group flex items-center py-3"
                        :href="route('scoreCard.index')"
                    >
                        <div
                            :class="
                                title === 'ScoreCard'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            <i class="pi pi-chart-bar mr-2 w-4 h-4"></i>
                            ScoreCard
                        </div>
                    </Link>
                </div>
            </li>

            <!-- CApacitacion -->
            <li>
                <div class="mb-4">
                    <a
                        class="group flex items-center py-3"
                        href="https://laproductivitycenter.com"
                        target="_blank"
                    >
                        <div
                            :class="
                                title === 'Capacitacion'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            <i class="pi pi-chart-bar mr-2 w-4 h-4"></i>
                            Capacitacion
                        </div>
                    </a>
                </div>
            </li>

            <!-- Eventos -->
            <div v-if="$page.props.auth.user.roles.includes('superadmin')">
                <li>
                    <div class="mb-4">
                        <a
                            class="group flex items-center py-3"
                            :href="route('eventos.index')"
                        >
                            <div
                                :class="
                                    title === 'Eventos'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <i class="pi pi-calendar mr-2 w-4 h-4"></i>
                                Eventos
                            </div>
                        </a>
                    </div>
                </li>
            </div>
            <!-- Usuarios Menu Item with Submenus -->
            <!-- <li>
                <a class="group flex items-center py-3 cursor-pointer" @click="toggleMenu('usuarios')">
                    <icon name="users" class="mr-2 w-4 h-4"
                        :class="title === 'usuarios' ? 'fill-white' : 'fill-indigo-400 group-hover:fill-white'" />
                    <div :class="title === 'usuarios' ? 'text-white' : 'text-indigo-300 group-hover:text-white'">
                        Usuarios
                    </div>
                    <icon name="cheveron-down" class="ml-auto w-4 h-4"
                        :class="isOpen('usuarios') ? 'rotate-180' : '', title === 'usuarios' ? 'fill-white' : 'fill-indigo-400 group-hover:fill-white'" />
                </a>
                <ul v-show="isOpen('usuarios')" class="pl-6 space-y-2">
                    <li>
                        <Link class="group flex items-center py-2" href="/users"
                            :class="subTitle === 'index' ? 'text-white' : 'text-indigo-300 group-hover:text-white'">
                        <icon name="circle" class="mr-2 w-3 h-3" />
                        <div>Index</div>
                        </Link>
                    </li>
                    <li>
                        <Link class="group flex items-center py-2" href="/users/create"
                            :class="subTitle === 'create' ? 'text-white' : 'text-indigo-300 group-hover:text-white'">
                        <icon name="circle" class="mr-2 w-3 h-3" />
                        <div>Crear</div>
                        </Link>
                    </li>
                </ul>
            </li> -->

            <!-- Other Menu Items -->
            <div
                v-if="
                    $page.props.auth.user.roles.includes('admin') ||
                    $page.props.auth.user.roles.includes('superadmin')
                "
            >
                <li>
                    <div class="mb-4 administrador">
                        <div>Administracion</div>
                    </div>
                </li>
                <li>
                    <div class="mb-4">
                        <Link
                            class="group flex items-center py-3"
                            href="/areas"
                        >
                            <div
                                :class="
                                    title === 'Pilares'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <i
                                    class="pi pi-building-columns mr-2 w-4 h-4"
                                ></i>
                                Pilares
                            </div>
                        </Link>
                    </div>
                </li>
                <li>
                    <div class="mb-4">
                        <Link
                            class="group flex items-center py-3"
                            href="/departamentos"
                        >
                            <div
                                :class="
                                    title === 'Flujos de valor'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <i class="pi pi-building mr-2 w-4 h-4"></i>
                                Flujos de valor
                            </div>
                        </Link>
                    </div>
                </li>
                <li>
                    <div class="mb-4">
                        <Link
                            class="group flex items-center py-3"
                            :href="route('user.index')"
                        >
                            <div
                                :class="
                                    title === 'usuarios'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <i class="pi pi-users mr-2 w-4 h-4"></i>
                                Usuarios
                            </div>
                        </Link>
                    </div>
                </li>
                <li>
                    <div class="mb-4">
                        <Link
                            class="group flex items-center py-3"
                            :href="route('encargadoFlujo.index')"
                        >
                            <div
                                :class="
                                    title === 'Lideres_flujo'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <i class="pi pi-users mr-2 w-4 h-4"></i>
                                Líderes de flujo
                            </div>
                        </Link>
                    </div>
                </li>
                <!-- //Tipos de Desperdicios -->
                <li>
                    <div class="mb-4">
                        <Link
                            class="group flex items-center py-3"
                            :href="route('tiposDesperdicios.index')"
                        >
                            <div
                                :class="
                                    title === 'tiposDesperdicios'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <i class="pi pi-trash mr-2 w-4 h-4"></i>
                                Tipos de Desperdicios
                            </div>
                        </Link>
                    </div>
                </li>
                <div v-if="$page.props.auth.user.roles.includes('superadmin')">
                    <li>
                        <div class="mb-4">
                            <Link
                                class="group flex items-center py-3"
                                :href="route('seccion.index')"
                            >
                                <div
                                    :class="
                                        title === 'Secciones'
                                            ? 'activo flex'
                                            : 'inactivo flex'
                                    "
                                >
                                    <i class="pi pi-list mr-2 w-4 h-4"></i>
                                    Secciones
                                </div>
                            </Link>
                        </div>
                    </li>

                    <li>
                        <div class="mb-4">
                            <Link
                                class="group flex items-center py-3"
                                :href="route('challenge.index')"
                            >
                                <div
                                    :class="
                                        title === 'Challenges'
                                            ? 'activo flex'
                                            : 'inactivo flex'
                                    "
                                >
                                    <i class="pi pi-verified mr-2 w-4 h-4"></i>
                                    Challenges
                                </div>
                            </Link>
                        </div>
                    </li>

                    <li>
                        <div class="mb-4">
                            <Link
                                class="group flex items-center py-3"
                                :href="route('opcion.index')"
                            >
                                <div
                                    :class="
                                        title === 'Opciones'
                                            ? 'activo flex'
                                            : 'inactivo flex'
                                    "
                                >
                                    <i class="pi pi-question mr-2 w-4 h-4"></i>
                                    Opciones
                                </div>
                            </Link>
                        </div>
                    </li>
                </div>
                <li>
                    <div class="mb-4">
                        <Link
                            class="group flex items-center py-3"
                            :href="route('config.index')"
                        >
                            <div
                                :class="
                                    title === 'Configuraciones'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <i class="pi pi-wrench mr-2 w-4 h-4"></i>
                                Configuraciones
                            </div>
                        </Link>
                    </div>
                </li>
                <li>
                    <div class="mb-4">
                        <Link
                            class="group flex items-center py-3"
                            :href="route('objetivo.index')"
                        >
                            <div
                                :class="
                                    title === 'Objetivos'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <i class="pi pi-flag mr-2 w-4 h-4"></i>
                                Objetivo
                            </div>
                        </Link>
                    </div>
                </li>

                <li>
                    <div class="mb-4">
                        <Link
                            class="group flex items-center py-3"
                            :href="route('proceso.index')"
                        >
                            <div
                                :class="
                                    title === 'Procesos'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <i class="pi pi-list-check mr-2 w-4 h-4"></i>
                                Procesos
                            </div>
                        </Link>
                    </div>
                </li>

                <li>
                    <div class="mb-4">
                        <Link
                            class="group flex items-center py-3"
                            :href="route('procedimiento.index')"
                        >
                            <div
                                :class="
                                    title === 'Procedimientos'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <i class="pi pi-check-square mr-2 w-4 h-4"></i>
                                Procedimientos
                            </div>
                        </Link>
                    </div>
                </li>

                <li>
                    <div class="mb-4">
                        <Link
                            class="group flex items-center py-3"
                            :href="route('estandar.index')"
                        >
                            <div
                                :class="
                                    title === 'Estandares'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <i class="pi pi-file mr-2 w-4 h-4"></i>
                                Estandares
                            </div>
                        </Link>
                    </div>
                </li>

                <li>
                    <div class="mb-4">
                        <Link
                            class="group flex items-center py-3"
                            :href="route('kpi.index')"
                        >
                            <div
                                :class="
                                    title === 'KPI'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <i class="pi pi-chart-line mr-2 w-4 h-4"></i>
                                KPI's
                            </div>
                        </Link>
                    </div>
                </li>
                <li
                    v-if="
                        $page.props.auth.user.roles.includes('admin') ||
                        $page.props.auth.user.roles.includes('superadmin')
                    "
                >
                    <a
                        class="group flex items-center py-3 cursor-pointer"
                        @click="toggleMenu('rolesypermisos')"
                    >
                        <i
                            class="pi pi-lock mr-2 w-4 h-4"
                            :class="
                                title === 'rolesypermisos'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        ></i>
                        <div
                            :class="
                                title === 'rolesypermisos'
                                    ? 'activo flex'
                                    : 'inactivo flex'
                            "
                        >
                            Roles y permisos
                        </div>
                        <icon
                            name="cheveron-down"
                            class="ml-auto w-4 h-4"
                            :class="
                                (isOpen('rolesypermisos') ? 'rotate-180' : '',
                                title === 'rolesypermisos'
                                    ? 'activo flex'
                                    : 'inactivo flex')
                            "
                        />
                    </a>
                    <ul
                        v-show="isOpen('rolesypermisos')"
                        class="pl-6 space-y-2"
                    >
                        <li>
                            <Link
                                class="group flex items-center py-2"
                                :href="route('roles.index')"
                                :class="
                                    subTitle === 'roles'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <icon name="circle" class="mr-2 w-3 h-3" />
                                <div>Roles</div>
                            </Link>
                        </li>
                        <li>
                            <Link
                                class="group flex items-center py-2"
                                :href="route('permisos.index')"
                                :class="
                                    subTitle === 'permisos'
                                        ? 'activo flex'
                                        : 'inactivo flex'
                                "
                            >
                                <icon name="circle" class="mr-2 w-3 h-3" />
                                <div>Permisoscalis</div>
                            </Link>
                        </li>
                    </ul>
                </li>
            </div>
        </ul>
    </div>
</template>

<script>
import { ref } from "vue";
import { Link } from "@inertiajs/vue3";
import Icon from "@/Layouts/Shared/Icon.vue";

export default {
    components: {
        Icon,
        Link,
    },
    props: {
        title: String,
        subTitle: String,
    },
    setup() {
        const openMenu = ref(null);

        const toggleMenu = (menu) => {
            openMenu.value = openMenu.value === menu ? null : menu;
        };

        const isOpen = (menu) => {
            return openMenu.value === menu;
        };

        return {
            toggleMenu,
            isOpen,
        };
    },
};
</script>

<style scoped>
.rotate-180 {
    transform: rotate(180deg);
}
</style>
