<script setup>
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import { ref, onMounted, watch } from "vue";
import axios from "axios";
import Layout from "@/Layouts/Layout.vue";
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import InputText from "primevue/inputtext";
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import { format } from "date-fns";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { confirmDialog, showToast } from "@/Pages/utils/SweetAlert.service";

const props = defineProps({});
const title = "minutero";
const minutas = ref([]);
const area = ref(1);
const areas = ref([]);
const departamentos = ref([]);
const procesos = ref([]);
const usuarios = ref([]);

const totalRecords = ref(0);
const rows = ref(10);
const first = ref(0);
const globalFilter = ref("");
const sortField = ref("id");
const sortOrder = ref(-1);
const filters = ref({});
const customFilter = ref(false);
const departamento_id = ref(props.departamento_id);
const flujoValor = ref(departamento_id.value || "");
const lider = ref("");
const tipo = ref("");
const proceso = ref("");
const desde = ref("");
const hasta = ref("");
const tier = ref("");
const tiposMinutas = ref([]);
const userLogin = usePage().props.auth.user.user.id;

const formFilter = useForm({
    area_id: "",
    departamento_id: "",
    lider_id: "",
    tipo: "",
    proceso_id: "",
    fecha_from: "",
    fecha_to: "",
    tier: "",
});

const userPermissions = usePage().props.auth.user.permissions;

onMounted(() => {
    filters.value = {
        departamento_id: { value: flujoValor.value, matchMode: "contains" },
    };
    getMinutas(1, rows.value, filters.value, sortField.value, sortOrder.value);
    getAreas();
    getProcesos();
    getUsuarios();
    getTiposMinuta();
    getDepartamentos();
});

watch(
    [globalFilter, flujoValor, lider, tipo, proceso, desde, hasta, tier],
    ([
        newglobalFilter,
        newflujoValor,
        newlider,
        newtipo,
        newproceso,
        newdesde,
        newhasta,
        newtier,
    ]) => {
        filters.value = {
            global: { value: newglobalFilter, matchMode: "contains" },
            departamento_id: { value: newflujoValor, matchMode: "contains" },
            lider_id: { value: newlider, matchMode: "contains" },
            tipo: { value: newtipo, matchMode: "contains" },
            proceso: { value: newproceso, matchMode: "contains" },
            desde: { value: newdesde, matchMode: "contains" },
            hasta: { value: newhasta, matchMode: "contains" },
            tier: { value: newtier, matchMode: "contains" },
        };
        getMinutas(
            1,
            rows.value,
            filters.value,
            sortField.value,
            sortOrder.value
        );
    }
);

async function getMinutas(
    page = 1,
    rowsPerPage = rows.value,
    filter = "",
    sortField = "id",
    sortOrder = -1
) {
    try {
        const response = await axios.get(route("minutas.findAll"), {
            params: {
                page,
                rows: rowsPerPage,
                filter,
                sortField,
                sortOrder: sortOrder === 1 ? "asc" : "desc",
                user_id: userLogin,
                bookmark: true,
            },
        });
        minutas.value = response.data.data;
        totalRecords.value = response.data.total;
        first.value = (response.data.current_page - 1) * rows.value;
    } catch (error) {
        console.error(error);
    }
}

const getAreas = async () => {
    try {
        const response = await axios.get("/api/areas");
        areas.value = response.data;
    } catch (error) {
        console.error(error);
    }
};

const getDepartamentos = async () => {
    try {
        const response = await axios.get(
            route("departamentos.byArea", area.value)
        );
        departamentos.value = response.data.departamentos;
    } catch (error) {
        console.error(error);
    }
};

async function getProcesos() {
    await axios
        .get("/api/procesos")
        .then((response) => (procesos.value = response.data.data))
        .catch((error) => {
            console.log(error);
        });
}

async function getUsuarios() {
    await axios
        .get("/api/usuarios/all/todo")
        .then((response) => (usuarios.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}

const formatearFecha = (dateString) => {
    return format(new Date(dateString), "dd/MM/yyyy");
};

const deleteMinuta = async (id) => {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Ya no podras revertir esto!",
            "warning"
        );
        if (result.isConfirmed) {
            await axios.delete(route("minutas.destroy", id));
            items.value = items.value.filter((item) => item.id !== id);
            showToast("El registro ha sido eliminado", "success");
        }
    } catch (error) {
        console.log(error);
    }
};

const onPage = (event) => {
    const page = event.page + 1;
    rows.value = event.rows;
    getMinutas(
        page,
        rows.value,
        filters.value,
        sortField.value,
        sortOrder.value
    );
};

const onSort = (event) => {
    sortField.value = event.sortField;
    sortOrder.value = event.sortOrder;
    getMinutas(1, rows.value, filters.value, sortField.value, sortOrder.value);
};

const openFilter = () => {
    customFilter.value = !customFilter.value;
};

const filterTable = async () => {
    await axios
        .get(`/api/minutas`, {
            params: {
                formFilter: formFilter.data(),
            },
        })
        .then((response) => (items.value = response.data.data))
        .catch((error) => {
            console.log(error);
        });
};

const clearFilter = () => {
    flujoValor.value = "";
    lider.value = "";
    tipo.value = "";
    proceso.value = "";
    desde.value = "";
    hasta.value = "";
    tier.value = "";
    getMinutas();
};

const getTiposMinuta = async () => {
    try {
        await axios
            .get(route("tipo-minuta.index"))
            .then((response) => {
                tiposMinutas.value = response.data;
            })
            .catch((error) => {
                console.log(error);
            });
    } catch (error) {
        console.error(error);
    }
};
</script>

<style scoped>
.breadcrumbs {
    display: flex;
    gap: 8px;
    align-items: center;
}

.breadcrumbsTitulo h3 {
    font-size: 24px;
    font-weight: bold;
}

.breadcrumbs h3 {
    font-size: 20px;
}

.breadcrumbs a {
    color: #000;
    text-decoration: none;
}

.breadcrumbs .active h3 {
    font-weight: bold;
}
</style>

<template>
    <Layout :titulo="title">
        <Head title="Minutas" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Minutas</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link :href="route('minutas.misminutas')" class="active">
                    <h3>Minutas Favoritas</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>
                    <div class="px-4 py-2 bg-white border-b border-gray-200">
                        <div class="container mx-auto overflow-x-auto">
                            <div class="flex gap-4">
                                <InputText
                                    v-model="globalFilter"
                                    placeholder="Buscar..."
                                    class="mb-3"
                                />
                                <PrimaryButton
                                    class="mb-4 float-right pi pi-filter"
                                    @click="openFilter"
                                >
                                </PrimaryButton>
                                <PrimaryButton
                                    v-if="customFilter"
                                    class="mb-4 float-right pi pi-times"
                                    @click="clearFilter"
                                >
                                </PrimaryButton>
                            </div>

                            <!-- formulario de filtrado de tareas -->
                            <div v-if="customFilter" class="">
                                <form @submit.prevent="filterTable()">
                                    <div
                                        class="m-4 border rounded-lg border-gray-200 flex gap-2 grid grid-cols-4"
                                    >
                                        <div class="m-4">
                                            <InputLabel
                                                for="departamento_id"
                                                value="Flujo de valor: "
                                            />
                                            <select
                                                ref="departamento_select"
                                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                                v-model="flujoValor"
                                            >
                                                <option value="" selected>
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

                                        <div class="m-4">
                                            <InputLabel
                                                for="lider_id"
                                                value="Lider: "
                                            />
                                            <select
                                                ref="lider_select"
                                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                                v-model="lider"
                                            >
                                                <option value="" selected>
                                                    Seleccione una opcion
                                                </option>
                                                <option
                                                    v-for="usuario in usuarios"
                                                    :key="usuario.id"
                                                    :value="usuario.id"
                                                >
                                                    {{ usuario.name }}
                                                </option>
                                            </select>
                                        </div>

                                        <div class="mt-4">
                                            <InputLabel
                                                for="tipo"
                                                value="Tipo: "
                                            />

                                            <select
                                                ref="tipo_select"
                                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                                v-model="tipo"
                                                required
                                            >
                                                <option
                                                    value=""
                                                    disabled
                                                    selected
                                                >
                                                    Seleccione una opcion
                                                </option>
                                                <option
                                                    v-for="tipoMinuta in tiposMinutas"
                                                    :key="tipoMinuta.id"
                                                    :value="tipoMinuta.id"
                                                >
                                                    {{ tipoMinuta.titulo }}
                                                </option>
                                            </select>
                                        </div>

                                        <div class="m-4">
                                            <InputLabel
                                                for="proceso_id"
                                                value="Proceso: "
                                            />
                                            <select
                                                ref="departamento_select"
                                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                                v-model="proceso"
                                            >
                                                <option value="" selected>
                                                    Seleccione una opcion
                                                </option>
                                                <option
                                                    v-for="proceso in procesos"
                                                    :key="proceso.id"
                                                    :value="proceso.id"
                                                >
                                                    {{ proceso.nombre }}
                                                </option>
                                            </select>
                                        </div>

                                        <div class="m-4">
                                            <InputLabel
                                                for="fecha"
                                                value="Fecha de entrega de: "
                                            />
                                            <TextInput
                                                id="fecha"
                                                v-model="desde"
                                                type="date"
                                                class="mt-1 block w-full"
                                                autocomplete="fecha"
                                            />
                                        </div>

                                        <div class="m-4">
                                            <InputLabel
                                                for="created_at"
                                                value="Fecha de entrega hasta: "
                                            />
                                            <TextInput
                                                id="fecha"
                                                v-model="hasta"
                                                type="date"
                                                class="mt-1 block w-full"
                                                autocomplete="fecha"
                                            />
                                        </div>
                                        <div class="m-4">
                                            <InputLabel
                                                for="created_at"
                                                value="Nivel de minuta: "
                                            />
                                            <select
                                                ref="departamento_select"
                                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                                v-model="tier"
                                            >
                                                <option value="" selected>
                                                    Seleccione una opcion
                                                </option>
                                                <option value="3">
                                                    3 Líderes flujo de valor -
                                                    Equipo
                                                </option>
                                                <option value="2">
                                                    2 Gerentes de pilar -
                                                    líderes flujo de valor
                                                </option>
                                                <option value="1">
                                                    1 staff directivo
                                                </option>
                                                <option value="0">
                                                    0 Consejo de Admin
                                                </option>
                                                <!-- <option value="3" selected>3</option>
                            <option value="2" selected>2</option>
                            <option value="1" selected>1</option>
                            <option value="0" selected>0</option> -->
                                            </select>
                                        </div>
                                    </div>
                                </form>
                            </div>

                            <DataTable
                                :value="minutas"
                                paginator
                                :rows="rows"
                                :totalRecords="totalRecords"
                                :lazy="true"
                                :first="first"
                                @page="onPage"
                                @sort="onSort"
                                :rowsPerPageOptions="[5, 10, 20, 50]"
                                tableStyle="min-width: 50rem"
                                :filters="filters"
                                :globalFilterFields="[
                                    'id',
                                    'departamento.nombre',
                                    'alias',
                                    'proceso.nombre',
                                    'lider.name',
                                    'notas',
                                    'created_at',
                                ]"
                                :sortField="sortField"
                                :sortOrder="sortOrder"
                                class="p-datatable-sm p-datatable-striped p-datatable-gridlines"
                            >
                                <template #empty> Sin registros </template>
                                <Column
                                    field="id"
                                    header="ID"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    sortable
                                ></Column>
                                <!-- <Column field="departamento?.nombre" header="Fujo de valor" headerStyle="width:4em;"
                bodyStyle="text-align:center;" bodyClass="text-center" :body="flujoBody" sortable></Column> -->
                                <Column
                                    field="departamento?.nombre"
                                    header="Flujo de valor"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    sortable
                                >
                                    <template #body="slotProps">
                                        {{
                                            slotProps.data.departamento
                                                ?.nombre || "Todos los flujos"
                                        }}
                                    </template>
                                </Column>
                                <Column
                                    field="tipo_minuta.titulo"
                                    header="Tipo"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    sortable
                                ></Column>
                                <Column
                                    field="alias"
                                    header="Alias"
                                    headerStyle="width:4em;"
                                    bodyClass="text-center"
                                    sortable
                                ></Column>
                                <Column
                                    field="proceso.nombre"
                                    header="Proceso"
                                    headerStyle="width:4em;"
                                    bodyClass="text-center"
                                    sortable
                                >
                                </Column>
                                <Column
                                    field="lider.name"
                                    header="Lider"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    sortable
                                ></Column>
                                <Column
                                    header="fecha"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    sortable
                                >
                                    <template #body="slotProps">
                                        {{
                                            formatearFecha(
                                                slotProps.data.created_at
                                            )
                                        }}
                                    </template>
                                </Column>
                                <Column
                                    header="Tareas"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    sortable
                                >
                                    <template #body="slotProps">
                                        <span
                                            v-if="
                                                slotProps.data
                                                    .tareas_completadas !==
                                                    undefined &&
                                                slotProps.data.tareas_total !==
                                                    undefined
                                            "
                                        >
                                            {{
                                                "(" +
                                                slotProps.data
                                                    .tareas_completadas +
                                                " / " +
                                                slotProps.data.tareas_total +
                                                ")"
                                            }}
                                        </span>
                                        <span v-else> Loading... </span>
                                    </template>
                                </Column>
                                <Column header="" headerStyle="width:4em;">
                                    <template
                                        #body="slotProps"
                                        class="text-center"
                                    >
                                        <div class="flex justify-center">
                                            <PrimaryButton
                                                class="pi pi-list m-2"
                                                :href="
                                                    route(
                                                        'minutas.show',
                                                        slotProps.data.id
                                                    )
                                                "
                                            >
                                                <span
                                                    class="p-1"
                                                    :style="{
                                                        fontSize: '10px',
                                                    }"
                                                    >Tareas</span
                                                >
                                            </PrimaryButton>
                                        </div>
                                    </template>
                                </Column>
                            </DataTable>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>
