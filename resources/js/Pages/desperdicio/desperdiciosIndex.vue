<script setup>
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import { ref, onMounted, watch } from "vue";
import axios from "axios";
import Layout from "@/Layouts/Layout.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { confirmDialog, showToast } from "../utils/SweetAlert.service";
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import InputText from "primevue/inputtext";
import { format } from "date-fns";
import Modal from "@/Components/Modal.vue";
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";

const formatDate = (rowData) => {
    if (rowData.created_at) {
        return format(new Date(rowData.created_at), "dd/MM/yy");
    }
    return "";
};

const props = defineProps({
    tipos: Array,
});

const form = useForm({
    from: "",
    to: "",
});

const title = "Desperdicios";
const tipos = ref([]);
const encargados = ref([]);
const totalRecords = ref(0);
const rows = ref(10);
const first = ref(0);
const globalFilter = ref("");
const filters = ref({});
const sortField = ref("id");
const sortOrder = ref(1);
const isModal = ref(false);
const userPremissions = usePage().props.auth.user.permissions;

async function getdesperdicios(
    page = 1,
    rowsPerPage = rows.value,
    filter = "",
    sortField = "id",
    sortOrder = 1
) {
    try {
        const response = await axios.get("/api/Desperdicio/findAll", {
            params: {
                page,
                rows: rowsPerPage,
                filter,
                sortField,
                sortOrder: sortOrder === 1 ? "asc" : "desc",
            },
        });
        tipos.value = response.data.data;
        totalRecords.value = response.data.total;
        first.value = (response.data.current_page - 1) * rows.value;
    } catch (error) {
        console.error(error);
    }
}

const deleteItem = async (id) => {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Ya no podras revertir esto!",
            "warning"
        );
        if (result.isConfirmed) {
            await axios.delete(route("desperdicio.destroy", id));

            tipos.value = tipos.value.filter((tipos) => tipos.id !== id);
            showToast("El registro ha sido eliminado", "success");
        }
    } catch (error) {
        console.error(error);
    }
};

const onPage = (event) => {
    const page = event.page + 1;
    rows.value = event.rows; // Actualizar filas por página
    getdesperdicios(
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
    getdesperdicios(
        1,
        rows.value,
        globalFilter.value,
        sortField.value,
        sortOrder.value
    );
};

onMounted(() => {
    // getDepartamentos();
    getdesperdicios();
});

watch(globalFilter, (newValue) => {
    filters.value = {
        global: { value: newValue, matchMode: "contains" },
    };
    getdesperdicios(1, rows.value, newValue, sortField.value, sortOrder.value);
});
const formatearFecha = (dateString) => {
    return format(new Date(dateString), "dd/MM/yyyy");
};

//////////////////////////
const openEditModal = async () => {
    isModal.value = true;
};

const closeModal = () => {
    isModal.value = false;
};

// TODO: crear funcion para exportar a excel "submitModal"

const submitModal = async () => {
    try {
        window.location.href = route("excel.desperdicios", {
            from: form.from,
            to: form.to,
        });
        form.reset();
        closeModal();
    } catch (error) {
        console.log("error");
    }
};
</script>

<style scoped>
.mb-3 {
    margin-bottom: 1rem;
}
</style>

<template>
    <Layout :titulo="title">
        <Head title="Desperdicios" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Desperdicio</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link class="active">
                    <h3>mis desperdicios</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>
                    <div
                        class="px-4 py-2 flex justify-end bg-white border-b border-gray-200"
                    >
                        <div
                            v-if="
                                userPremissions.includes('desperdicios_excel')
                            "
                        >
                            <PrimaryButton
                                @click="openEditModal()"
                                class="m-4 pi text-sm"
                            >
                                Excel
                            </PrimaryButton>
                        </div>

                        <div
                            v-if="
                                userPremissions.includes('desperdicios_crear')
                            "
                        >
                            <PrimaryButton
                                :href="route('desperdicio.create')"
                                class="m-4 pi pi-plus"
                                ><span
                                    class="p-1"
                                    :style="{
                                        fontSize: '10px',
                                    }"
                                >
                                    Nuevo desperdicio</span
                                ></PrimaryButton
                            >
                        </div>
                    </div>
                    <div class="px-4 py-2 bg-white border-b border-gray-200">
                        <div class="container mx-auto overflow-x-auto">
                            <!-- <InputText v-model="globalFilter" placeholder="Buscar..." class="mb-3" /> -->

                            <DataTable
                                :value="tipos"
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
                                    'area.nombre',
                                    'descripcion',
                                ]"
                                :sortField="sortField"
                                :sortOrder="sortOrder"
                                class="p-datatable-sm p-datatable-striped p-datatable-gridlines"
                            >
                                <template #empty> Sin registros. </template>
                                <!-- <Column field="id" header="ID" headerStyle="width:4em;" bodyStyle="text-align:center;"
                                    sortable></Column> -->
                                <Column
                                    field="created_at"
                                    header="Fecha"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    :body="formatDate"
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
                                <!-- <Column field="area.nombre" header="Pilar" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable></Column>
                                <Column field="departamento.nombre" header="Flujo de valor" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable></Column> -->
                                <Column
                                    field="tipo.tipo"
                                    header="Tipo"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    sortable
                                ></Column>
                                <Column
                                    field="tipo.nombre"
                                    header="Nombre"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    sortable
                                ></Column>
                                <Column
                                    field="monto"
                                    header="Monto"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    sortable
                                ></Column>
                                <Column
                                    field="usuario.name"
                                    header="Usuario"
                                    headerStyle="width:4em;"
                                    bodyStyle="text-align:center;"
                                    bodyClass="text-center"
                                    sortable
                                ></Column>
                                <!-- <Column field="descripcion" header="Descripcion" headerStyle="width:4em;"
                                    bodyClass="text-center" sortable></Column> -->

                                <Column header="" headerStyle="width:4em;">
                                    <template #body="slotProps">
                                        <div class="flex justify-center">
                                            <div
                                                v-if="
                                                    userPremissions.includes(
                                                        'desperdicios_editar'
                                                    )
                                                "
                                            >
                                                <PrimaryButton
                                                    class="me-2 pi pi-file-edit"
                                                    :href="
                                                        route(
                                                            'desperdicio.edit',
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
                                                        editar</span
                                                    >
                                                </PrimaryButton>
                                            </div>

                                            <div
                                                v-if="
                                                    userPremissions.includes(
                                                        'desperdicios_eliminar'
                                                    )
                                                "
                                            >
                                                <PrimaryButton
                                                    class="me-2 pi pi-trash"
                                                    @click.prevent="
                                                        deleteItem(
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

    <!-- Modals -->
    <Modal :show="isModal" maxWidth="lg">
        <template v-slot="">
            <div>
                <div
                    class="px-4 my-4 py-2 flex justify-center bg-white border-b border-gray-200"
                >
                    <p class="text-lg font-medium text-gray-900">
                        Seleccionar el rango de fecha.
                    </p>
                </div>
                <div class="px-4 py-2 bg-white border-b border-gray-200">
                    <p>
                        Seleccionar el rango de fecha para generar el reporte.
                    </p>
                    <div class="container mx-auto">
                        <form @submit.prevent="submitModal">
                            <div class="w-full">
                                <div class="my-4 w-full">
                                    <InputLabel
                                        class="w-full"
                                        for="Desde"
                                        value="Desde: "
                                    />
                                    <TextInput
                                        id="objetivo"
                                        v-model="form.from"
                                        type="date"
                                        step="any"
                                        class="mt-1 block w-full"
                                        required
                                        autocomplete="new-challenge"
                                    />
                                </div>
                            </div>
                            <div class="w-full">
                                <div class="my-4 w-full">
                                    <InputLabel
                                        class="w-full"
                                        for="Hasta"
                                        value="Hasta: "
                                    />
                                    <TextInput
                                        id="objetivo"
                                        v-model="form.to"
                                        type="date"
                                        step="any"
                                        class="mt-1 block w-full"
                                        required
                                        autocomplete="new-challenge"
                                    />
                                </div>
                            </div>

                            <div class="flex justify-between">
                                <PrimaryButton
                                    @click.prevent="closeModal"
                                    class="bg-red-500 ms-4 pi pi-times"
                                    :class="{
                                        'opacity-25': form.abort,
                                    }"
                                    :disabled="form.abort"
                                >
                                </PrimaryButton>

                                <PrimaryButton
                                    class="ms-4 pi pi-file-export"
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
                                        Exportar</span
                                    >
                                </PrimaryButton>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </template>
    </Modal>
</template>
