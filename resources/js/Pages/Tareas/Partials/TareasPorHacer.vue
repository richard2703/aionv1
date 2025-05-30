<script setup>
import { useForm } from "@inertiajs/vue3";
import { ref, onMounted, watch } from "vue";
import axios from "axios";
import { confirmDialog, showToast } from "@/Pages/utils/SweetAlert.service";
import { format } from "date-fns";
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import InputText from "primevue/inputtext";
import TextInput from "@/Components/TextInput.vue";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";

const props = defineProps({
    authUser: Object,
});

const tipo = ref(props.tipo);
const tareas = ref();
const areas = ref();
const departamentos = ref();
const usuarios = ref(props.usuarios);
const authUser = ref(props.authUser);

//filtro global y paginado
const customFilter = ref(false);
const totalRecords = ref(0);
const rows = ref(10);
const first = ref(0);
const globalFilter = ref("");
const filters = ref({});
const sortField = ref("id");
const sortOrder = ref(1);

const pilar = ref("");
const flujoValor = ref("");
const responsable = ref("");
const revisor = ref("");
const estatus = ref("");
const desde = ref("");
const hasta = ref("");

// const userLogin = usePage().props.auth.user.user.id;

const formValidate = useForm({
    validacion: "",
});

onMounted(() => {
    filters.value = {
        area_id: { value: pilar.value, matchMode: "contains" },
        departamento_id: { value: flujoValor.value, matchMode: "contains" },
    };
    getTareas("", "", filters.value, "", "");
    getAreas();
    getDepartamentos();
    getUsuarios();
    // console.log('Hola k aze!!!', authUser.id);
});

const getTareas = async (
    page = 1,
    rowsPerPage = rows.value,
    filter = "",
    sortField = "id",
    sortOrder = 1
) => {
    await axios
        .get(route("tareas.byUser"), {
            params: {
                page,
                rows: rowsPerPage,
                filter,
                sortField,
                sortOrder: sortOrder === 1 ? "asc" : "desc",
                user_id: authUser.value.id,
            },
        })
        .then((response) => {
            tareas.value = response.data.data;
            totalRecords.value = response.data.total;
            first.value = (response.data.current_page - 1) * rows.value;
        })
        .catch((error) => {
            console.log(error);
        });
};

async function getAreas() {
    await axios
        .get("/api/areas")
        .then((response) => {
            areas.value = response.data;
            formFilter.reset();
        })
        .catch((error) => {
            console.log(error);
        });
}

async function getDepartamentos() {
    await axios
        .get(route("departamentos.findAll"))
        .then((response) => (departamentos.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}

watch(
    [
        globalFilter,
        pilar,
        flujoValor,
        responsable,
        revisor,
        estatus,
        desde,
        hasta,
    ],
    ([
        newGlobalFilter,
        newPilar,
        newFlujoValor,
        newResponsable,
        newRevisor,
        newEstatus,
        newDesde,
        newHasta,
    ]) => {
        filters.value = {
            global: { value: newGlobalFilter, matchMode: "contains" },
            area_id: { value: newPilar, matchMode: "contains" },
            departamento_id: { value: newFlujoValor, matchMode: "contains" },
            responsable_id: { value: newResponsable, matchMode: "contains" },
            revisor_id: { value: newRevisor, matchMode: "contains" },
            estatus_id: { value: newEstatus, matchMode: "contains" },
            desde: { value: newDesde, matchMode: "contains" },
            hasta: { value: newHasta, matchMode: "contains" },
        };
        getTareas(
            1,
            rows.value,
            filters.value,
            sortField.value,
            sortOrder.value
        );
    }
);

const onPage = (event) => {
    const page = event.page + 1;
    rows.value = event.rows;
    getTareas(
        page,
        rows.value,
        filters.value,
        sortField.value,
        sortOrder.value
    );
};

const onSort = (event) => {
    sortField.value = event.sortField || "id";
    sortOrder.value = event.sortOrder;
    getTareas(1, rows.value, filters.value, sortField.value, sortOrder.value);
};

async function getUsuarios() {
    await axios
        .get("/api/usuarios/all/todo")
        .then((response) => (usuarios.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}

const formatearFecha = (fecha) => {
    return format(new Date(fecha), "dd/MM/yyyy");
};

const openFilter = () => {
    customFilter.value = !customFilter.value;
};

const clearFilter = () => {
    pilar.value = "";
    flujoValor.value = "";
    responsable.value = "";
    revisor.value = "";
    estatus.value = "";
    desde.value = "";
    hasta.value = "";

    getTareas();
};
</script>

<template>
    <div class="px-4 py-2 bg-white border-b border-gray-200">
        <div class="container mx-auto overflow-x-auto gap-4">
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
                            <InputLabel for="area_id" value="Pilar: " />
                            <select
                                ref="area_select"
                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                v-model="pilar"
                            >
                                <option value="" selected>
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

                        <!-- <div class="m-4">
                            <InputLabel for="responsable_id" value="Responsable: " />
                            <select ref="responsable_select"
                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                v-model="responsable">
                                <option value="" selected>
                                    Seleccione una opcion
                                </option>
                                <option v-for="usuario in usuarios" :key="usuario.id" :value="usuario.id">{{
                                    usuario.name }}</option>
                            </select>
                        </div> -->

                        <div class="m-4">
                            <InputLabel
                                for="cliente_id"
                                value="Cliente de tarea: "
                            />
                            <select
                                ref="cliente_select"
                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                v-model="revisor"
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

                        <div class="m-4">
                            <InputLabel for="estatus_id" value="Estatus: " />
                            <select
                                ref="estatus_select"
                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                v-model="estatus"
                            >
                                <option value="" selected>
                                    Seleccione una opcion
                                </option>
                                <option value="1">Retrasado</option>
                                <option value="2">Iniciado</option>
                                <option value="3">En proceso</option>
                                <option value="4">Terminado</option>
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
                    </div>
                </form>
            </div>

            <DataTable
                :value="tareas"
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
                    'tarea',
                    'departamento.nombre',
                    'responsable.name',
                    'fecha_entrega',
                    'estatus.titulo',
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
                >
                </Column>
                <Column
                    field="tarea"
                    header="Titulo"
                    headerStyle="width:4em;"
                    bodyClass="text-center"
                    sortable
                >
                </Column>
                <Column
                    field="estatus.titulo"
                    header="Estatus"
                    headerStyle="width:4em;"
                    bodyStyle="text-align:center;"
                    bodyClass="text-center"
                    sortable
                ></Column>
                <Column
                    field="departamento.nombre"
                    header="Fujo de valor"
                    headerStyle="width:4em;"
                    bodyStyle="text-align:center;"
                    bodyClass="text-center"
                    sortable
                ></Column>
                <Column
                    field="responsable.name"
                    header="Responsable"
                    headerStyle="width:4em;"
                    bodyClass="text-center"
                    sortable
                >
                </Column>
                <Column
                    field="fecha"
                    header="Fecha de entrega"
                    headerStyle="width:4em;"
                    bodyStyle="text-align:center;"
                    bodyClass="text-center"
                    sortable
                >
                    <template #body="slotProps">
                        {{ formatearFecha(slotProps.data.fecha) }}
                    </template>
                </Column>
                <Column
                    field="revisor.name"
                    header="Cliente de la tarea"
                    headerStyle="width:4em;"
                    bodyClass="text-center"
                    sortable
                >
                </Column>
                <!-- <Column header="Validacion" headerStyle="width:4em;" bodyClass="justify-center">
                    <template #body="slotProps">
                        <input type="checkbox" @change="validateTarea(slotProps.data, $event)"
                            :disabled="slotProps.data.validacion ? true : false"
                            :checked="slotProps.data.validacion ? true : false" /> Validar
                    </template>
                </Column> -->
                <Column header="" headerStyle="width:4em;">
                    <template #body="slotProps" class="text-center">
                        <div class="flex justify-center">
                            <PrimaryButton
                                v-if="slotProps.data.validacion !== 1"
                                class="m-2 pi pi-pen-to-square"
                                :href="route('tareas.edit', slotProps.data.id)"
                            >
                            </PrimaryButton>

                            <PrimaryButton
                                class="pi pi-file-check m-2"
                                :href="
                                    route('tareas.detail', slotProps.data.id)
                                "
                            ></PrimaryButton>

                            <PrimaryButton
                                class="m-2"
                                :href="
                                    route(
                                        'minutas.show',
                                        slotProps.data.minuta_id
                                    )
                                "
                            >
                                Ir a la minuta
                            </PrimaryButton>
                        </div>
                    </template>
                </Column>
            </DataTable>
        </div>
    </div>
</template>
