<script setup>
import { Head, Link, useForm } from "@inertiajs/vue3";
import { ref, onMounted, watch } from "vue";
import axios from "axios";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import Layout from "@/Layouts/Layout.vue";
import { confirmDialog, showToast } from "../utils/SweetAlert.service";
import { format } from 'date-fns';
import DataTable from "primevue/datatable";
import Column from "primevue/column";
import InputText from "primevue/inputtext";
import TextInput from "@/Components/TextInput.vue";
import InputLabel from "@/Components/InputLabel.vue";

const props = defineProps({
    authUser: Object,
    area_id: Number,
    departamento_id: Number,
});

const title = "tareas";
const tareas = ref();
const areas = ref();
const departamentos = ref();
const usuarios = ref(props.usuarios);
const authUser = ref(props.authUser);
const area_id = ref(props.area_id);
const departamento_id = ref(props.departamento_id);


//filtro global y paginado
const customFilter = ref(false);
const totalRecords = ref(0);
const rows = ref(10);
const first = ref(0);
const sortField = ref("id");
const sortOrder = ref(1);
const globalFilter = ref("");
const filters = ref({});

const pilar = ref(area_id.value || "");
const flujoValor = ref(departamento_id.value || "");
const responsable = ref("");
const revisor = ref("");
const estatus = ref("");
const desde = ref("");
const hasta = ref("");


const formValidate = useForm({
    validacion: "",
});

onMounted(() => {
    filters.value = {
        area_id: { value: pilar.value, matchMode: "contains" },
        departamento_id: { value: flujoValor.value, matchMode: "contains" },
    };
    getTareas('', '', filters.value, '', '');
    getAreas();
    getDepartamentos();
    getUsuarios();
});

const formatearFecha = (fecha) => {
    return format(new Date(fecha), 'dd/MM/yyyy');
};

const getTareas = async (
    page = 1,
    rowsPerPage = rows.value,
    filter = "",
    sortField = "id",
    sortOrder = 1
) => {
    await axios
        .get(`/api/tareas/`, {
            params: {
                page,
                rows: rowsPerPage,
                filter,
                sortField,
                sortOrder: sortOrder === 1 ? "asc" : "desc",
            },
        })
        .then((response) => {
            tareas.value = response.data.data
            totalRecords.value = response.data.total
            first.value = (response.data.current_page - 1) * rows.value
            console.log('tareas', tareas.value);

        })
        .catch((error) => {
            console.log(error);
        });
}

watch(
    [globalFilter, pilar, flujoValor, responsable, revisor, estatus, desde, hasta],
    ([newGlobalFilter, newPilar, newFlujoValor, newResponsable, newRevisor, newEstatus, newDesde, newHasta]) => {
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
        getTareas(1, rows.value, filters.value, sortField.value, sortOrder.value);
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
    getTareas(
        1,
        rows.value,
        filters.value,
        sortField.value,
        sortOrder.value
    );
};

const deleteTarea = async (id) => {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Ya no podras revertir esto!",
            "warning"
        );
        if (result.isConfirmed) {
            await axios.delete(route("tarea.destroy", id));
            tareas.value = tareas.value.filter((tarea) => tarea.id !== id);
            showToast("El registro ha sido eliminado", "success");

        }
    } catch (error) {
        console.log(error);

    }
}



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

async function getUsuarios() {
    await axios
        .get("/api/usuarios/all/todo")
        .then((response) => (usuarios.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}

const filterTable = async () => {
    await axios
        .get(`/api/tareas`, {
            params: {
                formFilter: formFilter.data(),
            },
        })
        .then((response) => (tareas.value = response.data.data))
        .catch((error) => {
            console.log(error);
        });
};

const openFilter = () => {
    customFilter.value = !customFilter.value

};
const clearFilter = () => {
    pilar.value = '';
    flujoValor.value = '';
    responsable.value = '';
    revisor.value = '';
    estatus.value = '';
    desde.value = '';
    hasta.value = '';
    // customFilter.value = !customFilter.value
    getTareas();
};

const validateTarea = async (tarea, $event) => {
    try {
        if (tarea.revisor.name !== authUser.value.name) {
            await confirmDialog(
                "No autorizado",
                "No eres el cliente de esta tarea!",
                "error"
            );

            return $event.target.checked = false;
        }

        const result = await confirmDialog(
            "Estas seguro?",
            "La tarea se marcara como Terminda y no podras revertir esto!",
            "warning"
        );
        if (result.isConfirmed) {
            await axios.patch(route("tareas.validar", tarea.id), {
                validacion: 1,
                estatus_id: 4
            }).then(() => {
                showToast("El registro ha sido eliminado", "success");
                getTareas();
            });

        } else {
            $event.target.checked = false;
        }
    } catch (error) {
        console.log(error);

    }

};

const sendMail = async () => {
    try {
        const result = await confirmDialog(
            "Notificacion de Tareas?",
            "Se enviaran sus tareas a todos los colaboradores!",
            "warning"
        );
        if (result.isConfirmed) {
            await axios.get(route("mailer.recordatorioTarea"))
                .then(() => {
                    showToast("El correo ha sido enviado", "success");
                });
        }
    } catch (error) {
        console.log(error);
    }
};

console.log({ area_id: area_id.value, departamento_id: departamento_id.value });

</script>

<style scoped>
.mb-3 {
    margin-bottom: 1rem;
}
</style>

<template>
    <Layout :titulo="title">

        <Head title="Tareas" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Tareas</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                <h3>Home -</h3>
                </Link>
                <Link :href="route('tareas.index')" class="active">
                <h3>Tareas</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>
                    <div class="px-4 py-2 flex justify-end bg-white border-b border-gray-200">
                        <PrimaryButton class="pi pi-plus m-4" :href="route('tareas.create')"></PrimaryButton>
                        <!-- <PrimaryButton v-if="$page.props.auth.user.roles.includes('admin')" class="pi pi-envelope m-4"
                            @click="sendMail()"></PrimaryButton> -->
                    </div>
                    <div class=" px-4 py-2 bg-white border-b border-gray-200">
                        <div class="container mx-auto overflow-x-auto gap-4">
                            <div class="flex gap-4">
                                <InputText v-model="globalFilter" placeholder="Buscar..." class="mb-3" />
                                <PrimaryButton class=" mb-4 float-right pi pi-filter" @click="openFilter">
                                </PrimaryButton>
                                <PrimaryButton v-if="customFilter" class=" mb-4 float-right pi pi-times"
                                    @click="clearFilter">
                                </PrimaryButton>
                            </div>


                            <!-- formulario de filtrado de tareas -->
                            <div v-if="customFilter" class="">
                                <form @submit.prevent="filterTable()">
                                    <div class="m-4 border rounded-lg border-gray-200 flex gap-2 grid grid-cols-4">
                                        <div class="m-4">
                                            <InputLabel for="area_id" value="Pilar: " />
                                            <select ref="area_select"
                                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                                v-model="pilar">
                                                <option value="" selected>
                                                    Seleccione una opcion
                                                </option>
                                                <option v-for="area in areas" :key="area.id" :value="area.id">
                                                    {{ area.nombre }}
                                                </option>
                                            </select>
                                        </div>

                                        <div class="m-4">
                                            <InputLabel for="departamento_id" value="Flujo de valor: " />
                                            <select ref="departamento_select"
                                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                                v-model="flujoValor">
                                                <option value="" selected>
                                                    Seleccione una opcion
                                                </option>
                                                <option v-for="departamento in departamentos" :key="departamento.id"
                                                    :value="departamento.id">
                                                    {{ departamento.nombre }}
                                                </option>
                                            </select>
                                        </div>

                                        <div class="m-4">
                                            <InputLabel for="responsable_id" value="Responsable: " />
                                            <select ref="responsable_select"
                                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                                v-model="responsable">
                                                <option value="" selected>
                                                    Seleccione una opcion
                                                </option>
                                                <option v-for="usuario in usuarios" :key="usuario.id"
                                                    :value="usuario.id">{{
                                                        usuario.name }}</option>
                                            </select>
                                        </div>

                                        <div class="m-4">
                                            <InputLabel for="cliente_id" value="Cliente de tarea: " />
                                            <select ref="cliente_select"
                                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                                v-model="revisor">
                                                <option value="" selected>
                                                    Seleccione una opcion
                                                </option>
                                                <option v-for="usuario in usuarios" :key="usuario.id"
                                                    :value="usuario.id">{{
                                                        usuario.name }}</option>
                                            </select>
                                        </div>

                                        <div class="m-4">
                                            <InputLabel for="estatus_id" value="Estatus: " />
                                            <select ref="estatus_select"
                                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                                v-model="estatus">
                                                <option value="" selected>
                                                    Seleccione una opcion </option>
                                                <option value=1>
                                                    Retrasado </option>
                                                <option value=2>
                                                    Iniciado </option>
                                                <option value=3>
                                                    En proceso </option>
                                                <option value=4>
                                                    Terminado </option>
                                            </select>
                                        </div>

                                        <div class="m-4">
                                            <InputLabel for="fecha" value="Fecha de entrega de: " />
                                            <TextInput id="fecha" v-model="desde" type="date" class="mt-1 block w-full"
                                                autocomplete="fecha" />
                                        </div>

                                        <div class="m-4">
                                            <InputLabel for="created_at" value="Fecha de entrega hasta: " />
                                            <TextInput id="fecha" v-model="hasta" type="date" class="mt-1 block w-full"
                                                autocomplete="fecha" />
                                        </div>
                                    </div>
                                </form>
                            </div>


                            <DataTable :value="tareas" paginator :rows="rows" :totalRecords="totalRecords" :lazy="true"
                                :first="first" @page="onPage" @sort="onSort" :rowsPerPageOptions="[5, 10, 20, 50]"
                                tableStyle="min-width: 50rem" :filters="filters" :globalFilterFields="[
                                    'id',
                                    'tarea',
                                    'departamento.nombre',
                                    'responsable.name',
                                    'revisor.name',
                                    'fecha_entrega',
                                    'estatus.titulo',
                                ]" :sortField="sortField" :sortOrder="sortOrder"
                                class="p-datatable-sm p-datatable-striped p-datatable-gridlines">
                                <template #empty> No data found. </template>
                                <Column field="id" header="ID" headerStyle="width:4em;" bodyStyle="text-align:center;"
                                    sortable></Column>
                                <Column field="tarea" header="Titulo" headerStyle="width:4em;" bodyClass="text-center"
                                    sortable></Column>
                                <Column field="estatus.titulo" header="Estatus" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable></Column>
                                <Column field="departamento.nombre" header="Fujo de valor" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable></Column>
                                <Column field="responsable.name" header="Responsable" headerStyle="width:4em;"
                                    bodyClass="text-center" sortable>
                                    <template #body="slotProps">
                                        <div v-if="slotProps.data.responsable">
                                            {{ slotProps.data.responsable.name }}
                                        </div>
                                        <div v-else class="text-center text-red-500">
                                            Sin responsable
                                        </div>
                                    </template>
                                </Column>
                                <Column field="fecha" header="Fecha de entrega" headerStyle="width:4em;"
                                    bodyStyle="text-align:center;" bodyClass="text-center" sortable>
                                    <template #body="slotProps">
                                        {{ formatearFecha(slotProps.data.fecha) }}
                                    </template>
                                </Column>
                                <!-- <Column field="nota" header="Notas" headerStyle="width:4em;" bodyClass="text-center"
                                    sortable>
                                </Column> -->
                                <Column field="revisor.name" header="Cliente de la tarea" headerStyle="width:4em;"
                                    bodyClass="text-center" sortable>
                                    <template #body="slotProps">
                                        <div v-if="slotProps.data.revisor">
                                            {{ slotProps.data.revisor.name }}
                                        </div>
                                        <div v-else>
                                            Sin cliente
                                        </div>
                                    </template>
                                </Column>
                                <Column header="Validacion" headerStyle="width:4em;" bodyClass="justify-center">
                                    <template #body="slotProps">
                                        <input type="checkbox" @change="validateTarea(slotProps.data, $event)"
                                            :disabled="slotProps.data.validacion ? true : false"
                                            :checked="slotProps.data.validacion ? true : false" /> Validar
                                    </template>
                                </Column>
                                <Column header="" headerStyle="width:4em;">
                                    <template #body="slotProps" class="text-center">
                                        <div class="flex justify-center">
                                            <PrimaryButton v-if="slotProps.data.validacion !== 1"
                                                class="m-2 pi pi-pen-to-square"
                                                :href="route('tareas.edit', slotProps.data.id)">
                                            </PrimaryButton>

                                            <PrimaryButton class="pi pi-file-check m-2"
                                                :href="route('tareas.detail', slotProps.data.id)"></PrimaryButton>

                                            <PrimaryButton v-if="slotProps.data.validacion !== 1"
                                                class="m-2 pi pi-trash" @click.prevent="
                                                    deleteTarea(slotProps.data.id)
                                                    ">
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
