<script setup>
import { Head, Link, usePage } from "@inertiajs/vue3";
import { ref, onMounted, watch } from "vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import axios from "axios";
import Layout from "@/Layouts/Layout.vue";
import { confirmDialog, showToast } from "../utils/SweetAlert.service";
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import InputText from "primevue/inputtext";

const props = defineProps({
    usuarios: Object,
});

const title = "usuarios";
const usuarios = ref([]);
const totalRecords = ref(0);
const rows = ref(10);
const first = ref(0);
const globalFilter = ref("");
const filters = ref({});
const sortField = ref("id");
const sortOrder = ref(1);
const userPremissions = usePage().props.auth.user.permissions;

async function getUsuarios(
    page = 1,
    rowsPerPage = rows.value,
    filter = "",
    sortField = "id",
    sortOrder = 1
) {
    try {
        const response = await axios.get("/api/usuarios", {
            params: {
                page,
                rows: rowsPerPage,
                filter,
                sortField,
                sortOrder: sortOrder === 1 ? "asc" : "desc",
            },
        });
        usuarios.value = response.data.data;
        totalRecords.value = response.data.total;
        first.value = (response.data.current_page - 1) * rows.value;
    } catch (error) {
        console.error(error);
    }
}

async function deleteUser(id) {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Ya no podras revertir esto!",
            "warning"
        );
        if (result.isConfirmed) {
            await axios
                .delete(route("user.destroy", id))
                .then((response) => (usuarios.value = response.data.usuarios))
                .catch((error) => {
                    console.log(error);
                });
            showToast("El registro ha sido eliminado", "success");
        }
    } catch (error) {
        console.error(error);
        showToast("Ocurrio un error", "error");
    }
}

const onPage = (event) => {
    const page = event.page + 1;
    rows.value = event.rows; // Actualizar filas por página
    getUsuarios(
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
    getUsuarios(
        1,
        rows.value,
        globalFilter.value,
        sortField.value,
        sortOrder.value
    );
};

onMounted(() => {
    getUsuarios();
});

watch(globalFilter, (newValue) => {
    filters.value = {
        global: { value: newValue, matchMode: "contains" },
    };
    getUsuarios(1, rows.value, newValue, sortField.value, sortOrder.value);
});
</script>

<style scoped>
.mb-3 {
    margin-bottom: 1rem;
}
</style>

<template>
    <Layout :titulo="title" :subTitulo="subTitle">
        <Head title="Usuarios" />

        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Usuarios</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link class="active">
                    <h3>Usuarios</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>
                    <div
                        class="px-4 py-2 flex justify-end bg-white border-b border-gray-200"
                    >
                        <div v-if="userPremissions.includes('usuarios_crear')">
                            <PrimaryButton
                                :href="route('user.create')"
                                class="m-4 pi pi-plus"
                            ></PrimaryButton>
                        </div>
                    </div>
                    <div class="px-4 py-2 bg-white border-b border-gray-200">
                        <div class="container mx-auto overflow-x-auto">
                            <InputText
                                v-model="globalFilter"
                                placeholder="Buscar..."
                                class="mb-3"
                            />
                            <DataTable
                                :value="usuarios"
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
                                    'name',
                                    'email',
                                    'area.nombre',
                                    'departamento.nombre',
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
                                    field="name"
                                    header="Nombre"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    sortable
                                ></Column>
                                <Column
                                    field="email"
                                    header="Correo electrónico"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    sortable
                                ></Column>
                                <Column
                                    field="area.nombre"
                                    header="Pilar"
                                    headerStyle="width:4em;"
                                    bodyClass="text-center"
                                    sortable
                                ></Column>
                                <Column
                                    field="departamento.nombre"
                                    header="Flujo de valor"
                                    headerStyle="width:4em;"
                                    bodyClass="text-center"
                                    sortable
                                >
                                </Column>

                                <Column header="" headerStyle="width:4em;">
                                    <template
                                        #body="slotProps"
                                        class="text-center"
                                    >
                                        <div class="flex justify-evenly">
                                            <div
                                                v-if="
                                                    userPremissions.includes(
                                                        'usuarios_editar'
                                                    )
                                                "
                                                class="inline"
                                            >
                                                <PrimaryButton
                                                    class="m-2 pi pi-file-edit"
                                                    :href="
                                                        route(
                                                            'user.edit',
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
                                                        Editar</span
                                                    >
                                                </PrimaryButton>
                                            </div>
                                            <div
                                                v-if="
                                                    userPremissions.includes(
                                                        'usuarios_eliminar'
                                                    )
                                                "
                                                class="inline"
                                            >
                                                <PrimaryButton
                                                    class="m-2 pi pi-trash"
                                                    @click.prevent="
                                                        deleteUser(
                                                            slotProps.data.id
                                                        )
                                                    "
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
