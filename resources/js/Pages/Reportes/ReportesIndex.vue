<script setup>
import { Head, Link, usePage } from "@inertiajs/vue3";
import { ref, onMounted, watch } from "vue";
import axios from "axios";
import Layout from "@/Layouts/Layout.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { confirmDialog, showToast } from "../utils/SweetAlert.service";
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import InputText from "primevue/inputtext";

// Definir propiedades
const props = defineProps({
    reporteSemanal: Array,
    areasAPI: Array,
});

const totalRecords = ref(0);
const rows = ref(10);
const first = ref(0);
const reporteSemanal = ref([]);
const globalFilter = ref("");
const filters = ref({});
const sortField = ref("id"); // Valor predeterminado
const sortOrder = ref(1);
const title = "reportes";
const userPremissions = usePage().props.auth.user.permissions;

// Función para obtener áreas
async function getreporteSemanal(
    page = 1,
    rowsPerPage = rows.value,
    filter = "",
    sortField = "id",
    sortOrder = 1
) {
    try {
        const response = await axios.get("/api/getReporteSemanal", {
            params: {
                page,
                rows: rowsPerPage,
                filter,
                sortField,
                sortOrder: sortOrder === 1 ? "asc" : "desc",
            },
        });
        reporteSemanal.value = response.data;
        console.log("reporteSemanal", reporteSemanal.value);

        totalRecords.value = response.data.total;
        first.value = (response.data.current_page - 1) * rows.value;
    } catch (error) {
        console.error(error);
    }
}

// Manejar paginación
const onPage = (event) => {
    const page = event.page + 1;
    rows.value = event.rows; // Actualizar filas por página
    getreporteSemanal(
        page,
        rows.value,
        globalFilter.value,
        sortField.value,
        sortOrder.value
    );
};

// Manejar ordenación
const onSort = (event) => {
    sortField.value = event.sortField || "id";
    sortOrder.value = event.sortOrder;
    getreporteSemanal(
        1,
        rows.value,
        globalFilter.value,
        sortField.value,
        sortOrder.value
    );
};

// Obtener áreas al montar el componente
onMounted(() => {
    getreporteSemanal();
});

// Eliminar área
// const deleteArea = async (id) => {
//     try {
//         const result = await confirmDialog(
//             "Estas seguro?",
//             "Ya no podras revertir esto!",
//             "warning"
//         );
//         if (result.isConfirmed) {
//             const response = await axios.delete(route("area.destroy", id));
//             areas.value = areas.value.filter((area) => area.id !== id);
//             showToast("El registro ha sido eliminado", "success");
//         }
//     } catch (error) {
//         console.error(error);
//     }
// };

// Actualizar filtro global
watch(globalFilter, (newValue) => {
    filters.value = {
        global: { value: newValue, matchMode: "contains" },
    };
    getAreas(1, rows.value, newValue, sortField.value, sortOrder.value);
});

const isLoading = ref(false);
function handleClick(id) {
    isLoading.value = true;
    // El redireccionamiento ocurre después de cambiar el estado.
    window.location.href = route("reporte.pdf", id);
}
</script>

<style scoped>
.mb-3 {
    margin-bottom: 1rem;
}
</style>

<template>
    <Layout :titulo="title">
        <Head title="semanales" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Reportes</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link class="active">
                    <h3>Reportes</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>
                    <div
                        class="px-4 py-2 flex justify-end bg-white border-b border-gray-200"
                    >
                        <div v-if="userPremissions.includes('reporte_crear')">
                            <PrimaryButton
                                :href="route('reporte.create')"
                                class="m-4 pi pi-plus"
                            >
                                <span
                                    class="p-1"
                                    :style="{
                                        fontSize: '10px',
                                    }"
                                >
                                    Nuevo reporte</span
                                >
                            </PrimaryButton>
                        </div>
                    </div>
                    <div class="px-4 py-2 bg-white border-b border-gray-200">
                        <div class="container mx-auto">
                            <InputText
                                v-model="globalFilter"
                                placeholder="Buscar..."
                                class="mb-3"
                            />

                            <DataTable
                                :value="reporteSemanal"
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
                                    'nombre',
                                    'descripcion',
                                ]"
                                :sortField="sortField"
                                :sortOrder="sortOrder"
                                class="p-datatable-sm p-datatable-striped p-datatable-gridlines"
                            >
                                <template #empty> No data found. </template>
                                <Column
                                    field="id"
                                    header="ID"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    sortable
                                ></Column>
                                <Column
                                    field="numeroSemana"
                                    header="Numero de la Semana"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    sortable
                                ></Column>
                                <Column
                                    header="Periodo"
                                    headerStyle="width:4em;"
                                >
                                    <template
                                        #body="slotProps"
                                        class="text-center"
                                    >
                                        Del {{ slotProps.data.inicio }} <br />
                                        Al {{ slotProps.data.fin }}
                                    </template>
                                </Column>
                                <!-- <Column field="reportes" header="Reportes Hechos " headerStyle="width:4em;"
                                    bodyClass="text-center" sortable></Column> -->

                                <Column header="" headerStyle="width:4em;">
                                    <template #body="slotProps">
                                        <div class="flex justify-evenly">
                                            <div
                                                v-if="
                                                    userPremissions.includes(
                                                        'reporte_ver_web'
                                                    )
                                                "
                                                class="inline"
                                            >
                                                <PrimaryButton
                                                    class="pi pi-eye me-2"
                                                    :href="
                                                        route(
                                                            'reporte.show',
                                                            slotProps.data.id
                                                        )
                                                    "
                                                >
                                                    <span
                                                        class="p-1"
                                                        :style="{
                                                            fontSize: '10px',
                                                        }"
                                                    >
                                                        Ver</span
                                                    >
                                                </PrimaryButton>
                                            </div>

                                            <!-- <PrimaryButton class="pi pi-eye me-2" @click="handleClick(slotProps.data.id)"
                                        :disabled="isLoading">
                                            <span v-if="!isLoading">Ver Reporte</span>
                                            <span v-else>
                                                <i class="pi pi-spinner pi-spin"></i> Cargando...
                                            </span>
                                        </PrimaryButton> -->
                                            <div
                                                v-if="
                                                    userPremissions.includes(
                                                        'reporte_descargar'
                                                    )
                                                "
                                                class="inline"
                                            >
                                                <PrimaryButton
                                                    class="pi pi-download me-2"
                                                    :href="
                                                        route(
                                                            'reporte.pdf',
                                                            slotProps.data.id
                                                        )
                                                    "
                                                    target="_blank"
                                                >
                                                    <span
                                                        class="p-1"
                                                        :style="{
                                                            fontSize: '10px',
                                                        }"
                                                    >
                                                        Descargar</span
                                                    >
                                                </PrimaryButton>
                                            </div>
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
