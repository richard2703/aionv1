<script setup>
import { ref, onMounted, watch } from "vue";
import axios from "axios";
import InputText from "primevue/inputtext";
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import InputLabel from "@/Components/InputLabel.vue";


const props = defineProps({
    pilar: String,
});

const departamentos = ref([]);
const departamento = ref({});
const procesos = ref([]);
const proceso = ref({});
const procedimientos = ref([]);
const procedimiento = ref({});
const estandares = ref([]);
const totalRecords = ref(0);
const rows = ref(10);
const first = ref(0);
const globalFilter = ref("");
const globalFilterProcesos = ref("");
const globalFilterProcedimientos = ref("");
const globalFilterEstandares = ref("");
const filters = ref({});
const filtersProcesos = ref({});

const sortField = ref("id");
const sortOrder = ref(1);

const selectedDepartamento = ref(null);
const selectedProceso = ref(null);
const selectedProcedimiento = ref(null);
const selectedEstandar = ref(null);

const getDepartamentos = async (
    page = 1,
    rowsPerPage = rows.value,
    filter = "",
    sortField = "id",
    sortOrder = 1
) => {
    try {
        procesos.value = [];
        proceso.value = {};
        procedimientos.value = [];
        procedimiento.value = {};
        estandares.value = [];
        const response = await axios.get("/api/getDepartamentos", {
            params: {
                page,
                rows: rowsPerPage,
                filter,
                sortField,
                sortOrder: sortOrder === 1 ? "asc" : "desc",
                pilar: props.pilar,
            },
        });
        departamentos.value = response.data.data;
        // console.log(departamentos.value);
        totalRecords.value = response.data.total;
        first.value = (response.data.current_page - 1) * rows.value;
    } catch (error) {
        console.error(error);
    }
};

const getProcesos = async (
    departamento,
    page = 1,
    rowsPerPage = rows.value,
    filter = "",
    sortField = "id",
    sortOrder = 1,

) => {
    try {
        procesos.value = [];
        proceso.value = {};
        procedimientos.value = [];
        procedimiento.value = {};
        estandares.value = [];
        const response = await axios.get("/api/getProcesos", {
            params: {
                page,
                rows: rowsPerPage,
                filter,
                sortField,
                sortOrder: sortOrder === 1 ? "asc" : "desc",
                departamento,
            },
        });
        procesos.value = response.data.data;
        totalRecords.value = response.data.total;
        first.value = (response.data.current_page - 1) * rows.value;
    } catch (error) {
        console.error(error);
    }
    selectedDepartamento.value = departamento;

};

const getProcedimientos = async (
    proceso,
    page = 1,
    rowsPerPage = rows.value,
    filter = "",
    sortField = "id",
    sortOrder = 1
) => {
    try {
        procedimientos.value = [];
        procedimiento.value = {};
        estandares.value = [];
        const response = await axios.get("/api/getProcedimientos", {
            params: {
                page,
                rows: rowsPerPage,
                filter,
                sortField,
                sortOrder: sortOrder === 1 ? "asc" : "desc",
                proceso,
            },
        });
        procedimientos.value = response.data.data;
        totalRecords.value = response.data.total;
        first.value = (response.data.current_page - 1) * rows.value;
    } catch (error) {
        console.error(error);
    }
    selectedProceso.value = proceso;

};

const getEstandares = async (
    procedimiento,
    page = 1,
    rowsPerPage = rows.value,
    filter = "",
    sortField = "id",
    sortOrder = 1

) => {
    try {

        estandares.value = [];
        const response = await axios.get("/api/getEstandares", {
            params: {
                page,
                rows: rowsPerPage,
                filter,
                sortField,
                sortOrder: sortOrder === 1 ? "asc" : "desc",
                procedimiento,
            },
        });
        // console.log(response.data);
        estandares.value = response.data.data;
        totalRecords.value = response.data.total;
        first.value = (response.data.current_page - 1) * rows.value;
    } catch (error) {
        console.error(error);
    }

    selectedProcedimiento.value = procedimiento;
};

const onPage = (event) => {
    const page = event.page + 1;
    rows.value = event.rows; // Actualizar filas por página
    getDepartamentos(
        page,
        rows.value,
        globalFilter.value,
        sortField.value,
        sortOrder.value
    );
};

const onSort = (event) => {
    sortField.value = event.sortField || "id";
    sortOrder.value = event.sortOrder;
    getDepartamentos(
        1,
        rows.value,
        globalFilter.value,
        sortField.value,
        sortOrder.value
    );
};

onMounted(() => {
    getDepartamentos();
});

watch(globalFilter, (newValue) => {
    filters.value = {
        global: { value: newValue, matchMode: "contains" },
    };
    getDepartamentos(1, rows.value, newValue, sortField.value, sortOrder.value);

});

watch(globalFilterProcesos, (newValue) => {
    filters.value = {
        global: { value: newValue, matchMode: "contains" },
    };
    getProcesos(departamento.value, 1, rows.value, newValue, sortField.value, sortOrder.value);
});

watch(globalFilterProcedimientos, (newValue) => {
    filters.value = {
        global: { value: newValue, matchMode: "contains" },
    };
    getProcedimientos(proceso.value, 1, rows.value, newValue, sortField.value, sortOrder.value);
});

watch(globalFilterEstandares, (newValue) => {
    filters.value = {
        global: { value: newValue, matchMode: "contains" },
    };
    getEstandares(procedimiento.value, 1, rows.value, newValue, sortField.value, sortOrder.value);
});

watch(() => props.pilar, (newPilar) => {
    getDepartamentos();
});
</script>

<style scoped>
.mb-3 {
    margin-bottom: 1rem;
}

.selected {
    background-color: #d3d3d3;
    /* Cambia este color según tus preferencias */
}
</style>

<template>
    <div class="py-2">
        <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
            <div>
                <div class="px-4 py-2 bg-white border-b border-gray-200">
                    <div
                        class="container mx-auto overflow-x-auto grid grid-cols-1 sm:grid-cols-3 lg:grid-cols-3 gap-4 mb-3">
                        <div class="sm:col-span-1 lg:col-span-1">
                            <InputText v-model="globalFilter" placeholder="Buscar..." class="mb-3" />
                            <DataTable :value="departamentos" paginator :rows="rows" :totalRecords="totalRecords"
                                :lazy="true" :first="first" @page="onPage" @sort="onSort"
                                :rowsPerPageOptions="[5, 10, 20, 50]" :filters="filters" :globalFilterFields="[
                                    'nombre',
                                ]" :sortField="sortField" :sortOrder="sortOrder"
                                class="p-datatable-sm p-datatable-striped p-datatable-gridlines">
                                <template #empty> Sin Registros. </template>
                                <Column field="nombre" header="Flujo de valor" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable>
                                    <template #body="slotProps">
                                        <button
                                            v-bind:class="[selectedDepartamento == slotProps.data.id ? 'selected' : '']"
                                            @click=" getProcesos(departamento.value = slotProps.data.id, 1, rows,
                                                newValue, sortField, sortOrder)">
                                            {{ slotProps.data.nombre }}
                                        </button>
                                        <!-- <button :class="{ 'selected': selectedDepartamento.value === slotProps.data.id }"
                                            @click="selectDepartamento(slotProps.data.id)">
                                            {{ slotProps.data.nombre }}
                                        </button> -->
                                    </template>
                                </Column>
                                <!-- <tr v-for="(procesoItem, index) in departamento.departamento.procesos"
                                                :key="index">
                                                <td class="py-2 px-4 border">
                                                    <Link :href="route('proceso.edit', procesoItem.id)"
                                                        class="text-blue-500 hover:underline">
                                                    {{ procesoItem.nombre }}
                                                    </Link>
                                                </td>
                                            </tr> -->
                                <Column field="kpis" header="KPIs" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable>
                                    <template #body="slotProps">
                                        <div v-if="slotProps.data.kpis && slotProps.data.kpis.length">
                                            <ul>
                                                <li v-for="(kpi, index) in slotProps.data.kpis" :key="index">
                                                    {{ kpi.titulo }}
                                                </li>
                                            </ul>
                                        </div>
                                        <div v-else>
                                            Sin KPIs
                                        </div>
                                    </template>
                                </Column>
                            </DataTable>
                        </div>
                        <div class="sm:col-span-2 lg:col-span-2">
                            <InputText v-model="globalFilterProcesos" placeholder="Buscar..." class="mb-3" />
                            <DataTable :value="procesos" paginator :rows="rows" :totalRecords="totalRecords"
                                :lazy="true" :first="first" @page="onPage" @sort="onSort"
                                :rowsPerPageOptions="[5, 10, 20, 50]" :filters="filters" :globalFilterFields="[
                                    'nombre',
                                ]" :sortField="sortField" :sortOrder="sortOrder"
                                class="p-datatable-sm p-datatable-striped p-datatable-gridlines">
                                <template #empty> Sin Registros. </template>
                                <Column field="nombre" header="Procesos" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable>
                                    <template #body="slotProps">
                                        <button v-bind:class="[selectedProceso == slotProps.data.id ? 'selected' : '']"
                                            @click="getProcedimientos(proceso.value = slotProps.data.id, 1, rows, newValue, sortField, sortOrder)">
                                            {{ slotProps.data.nombre }}
                                        </button>
                                    </template>
                                </Column>
                                <Column field="link_externo" header="Link" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable>
                                    <template #body="slotProps">
                                        <a :href="slotProps.data.link_externo" target="_blank"
                                            rel="noopener noreferrer">
                                            {{ slotProps.data.link_externo }}
                                        </a>
                                    </template>
                                </Column>
                            </DataTable>
                        </div>
                    </div>
                    <div class="container mx-auto overflow-x-auto grid  grid-cols-1 sm:grid-cols-2 lg:grid-cols-2">
                        <div>
                            <InputText v-model="globalFilterProcedimientos" placeholder="Buscar..." class="mb-3" />
                            <DataTable :value="procedimientos" paginator :rows="rows" :totalRecords="totalRecords"
                                :lazy="true" :first="first" @page="onPage" @sort="onSort"
                                :rowsPerPageOptions="[5, 10, 20, 50]" :filters="filters" :globalFilterFields="[
                                    'nombre',
                                ]" :sortField="sortField" :sortOrder="sortOrder"
                                class="p-datatable-sm p-datatable-striped p-datatable-gridlines">
                                <template #empty> Sin Registros. </template>
                                <Column field="nombre" header="Procedmientos" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable>
                                    <template #body="slotProps">
                                        <button
                                            v-bind:class="[selectedProcedimiento == slotProps.data.id ? 'selected' : '']"
                                            @click="getEstandares(procedimiento.value = slotProps.data.id, 1, rows, newValue, sortField, sortOrder)">
                                            {{ slotProps.data.nombre }}
                                        </button>
                                    </template>
                                </Column>
                                <Column field="link_externo" header="Ejecución" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable>
                                    <template #body="slotProps">
                                        <a :href="slotProps.data.link_herramienta" target="_blank"
                                            rel="noopener noreferrer">
                                            {{ slotProps.data.link_herramienta }}
                                        </a>
                                    </template>
                                </Column>
                                <Column field="link_externo" header="Documentación" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable>
                                    <template #body="slotProps">
                                        <a :href="slotProps.data.link_externo" target="_blank"
                                            rel="noopener noreferrer">
                                            {{ slotProps.data.link_externo }}
                                        </a>
                                    </template>
                                </Column>
                            </DataTable>
                        </div>
                        <div>
                            <InputText v-model="globalFilterEstandares" placeholder="Buscar..." class="mb-3" />
                            <DataTable :value="estandares" paginator :rows="rows" :totalRecords="totalRecords"
                                :lazy="true" :first="first" @page="onPage" @sort="onSort"
                                :rowsPerPageOptions="[5, 10, 20, 50]" :filters="filters" :globalFilterFields="[
                                    'nombre',
                                ]" :sortField="sortField" :sortOrder="sortOrder"
                                class="p-datatable-sm p-datatable-striped p-datatable-gridlines">
                                <template #empty> Sin Registros. </template>
                                <Column field="nombre" header="Estandares" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable>
                                    <!-- <template #body="slotProps">
                                        <button @click="getEstandares(slotProps.data.id)">
                                            {{ slotProps.data.nombre }}
                                        </button>s
                                    </template> -->
                                </Column>
                                <Column field="link_externo" header="Documentación" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable>
                                    <template #body="slotProps">
                                        <a :href="slotProps.data.link_externo" target="_blank"
                                            rel="noopener noreferrer">
                                            {{ slotProps.data.link_externo }}
                                        </a>
                                    </template>
                                </Column>
                            </DataTable>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
