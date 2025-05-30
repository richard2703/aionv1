<script setup>
import { ref, onMounted, computed } from "vue";
import { Head, Link, usePage } from "@inertiajs/vue3";
import Layout from "@/Layouts/Layout.vue";
import axios from "axios";
import ColorPicker from "primevue/colorpicker";
import { confirmDialog, showToast } from "../utils/SweetAlert.service";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { format } from "date-fns";

const props = defineProps({
    eventos: Array,
});

// Calendar state
const currentYear = ref(new Date().getFullYear());
const currentMonth = ref(new Date().getMonth());
const daysInMonth = computed(() =>
    new Date(currentYear.value, currentMonth.value + 1, 0).getDate()
);
const firstDayOfMonth = computed(() =>
    new Date(currentYear.value, currentMonth.value, 1).getDay()
);
// const monthNames = [
//     "January",
//     "February",
//     "March",
//     "April",
//     "May",
//     "June",
//     "July",
//     "August",
//     "September",
//     "October",
//     "November",
//     "December",
// ];
const monthNames = [
    "Enero",
    "Febrero",
    "Marzo",
    "Abril",
    "Mayo",
    "Junio",
    "Julio",
    "Agosto",
    "Septiembre",
    "Octubre",
    "Noviembre",
    "Diciembre",
];

// Event data
const events = ref({}); // Events organized by date
// Modals
const modal = ref({
    show: false,
    type: "create",
    day: null,
    event: {
        id: null,
        titulo: "",
        descripcion: "",
        fecha_inicio: "",
        fecha_final: "",
        area_id: "",
    },
});
const viewModal = ref({ show: false, event: null });
const areas = ref([]);
const filteredColors = ref("");
const userPermissions = usePage().props.auth.user.permissions;
const item = ref([]);
const eventosTitulo = ref("");

// formatear fecha
const formatDate = (year, month, day) => {
    const paddedMonth = String(month).padStart(2, "0");
    const paddedDay = String(day).padStart(2, "0");
    return `${year}-${paddedMonth}-${paddedDay}`;
};

// formatear fecha por comodidad
const formatearFecha = (fecha) => {
    return format(new Date(fecha), "dd/MM/yyyy");
};

const getEventos = async () => {
    try {
        const { data } = await axios.get(route("eventos.findAll"), {
            params: {
                year: currentYear.value,
                month: currentMonth.value + 1,
            },
        });

        // Organize events by date
        const organizedEvents = {};
        data.forEach((event) => {
            const dateKey = event.fecha_inicio;
            if (!organizedEvents[dateKey]) {
                organizedEvents[dateKey] = [];
            }
            organizedEvents[dateKey].push(event);
        });
        events.value = organizedEvents;
    } catch (error) {
        console.error("Error fetching events:", error);
    }
};

// cerrar modales
const closeModal = () => {
    modal.value.show = false;
};
const closeviewModal = () => {
    viewModal.value.show = false;
};

const submit = async () => {
    try {
        const formattedDate = formatDate(
            currentYear.value,
            currentMonth.value + 1,
            modal.value.day
        );

        if (modal.value.type === "create") {
            const { data } = await axios.post(route("eventos.store"), {
                titulo: modal.value.event.titulo,
                descripcion: modal.value.event.descripcion,
                fecha_inicio: formattedDate,
                fecha_final: modal.value.event.fecha_final,
                area_id: modal.value.event.area_id,

                recurrencia: modal.value.event.recurrencia,
                dia_semana: modal.value.event.dia_semana,
                dia_mes: modal.value.event.dia_mes,
                num_repeticiones: modal.value.event.num_repeticiones,
                ubicacion: modal.value.event.ubicacion,
                link: modal.value.event.link
            });

            if (!events.value[formattedDate]) {
                events.value[formattedDate] = [];
            }
            events.value[formattedDate].push(data);
            await getEventos();
        } else {
            await axios.patch(
                route("eventos.update", modal.value.event.id),
                modal.value.event
            );
            await getEventos(); // Refresh events
        }
        closeModal();
    } catch (error) {
        console.error("Error saving event:", error);
    }
};

const deleteEvento = async (event) => {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Ya no podras revertir esto!",
            "warning"
        );
        if (result.isConfirmed) {
            await axios.delete(route("eventos.destroy", event.id));
            showToast("El registro ha sido eliminado", "success");
            closeviewModal();
            await getEventos();
        }
    } catch (error) {
        console.error(error);
    }
};

// Mostrar modales
const showCreateModal = (day) => {
    if (!userPermissions.includes("eventos_crear")) {
        return;
    }
    const formattedDate = formatDate(
        currentYear.value,
        currentMonth.value + 1,
        day
    );
    modal.value = {
        show: true,
        type: "create",
        day,
        event: {
            id: null,
            titulo: "",
            descripcion: "",
            fecha_inicio: formattedDate,
            fecha_final: "",
            area_id: "",

            recurrencia: "none",
            dia_semana: null,
            dia_mes: "",
            num_repeticiones: 1,
            ubicacion: "",
            link: "",
        },
    };
};

// const areas = ref([
//     { id: 1, nombre: "Recursos Humanos" },
//     { id: 2, nombre: "Finanzas" },
//     { id: 3, nombre: "TI" },
// ]);

const diasSemana = [
    "Domingo", "Lunes", "Martes", "Miércoles", "Jueves", "Viernes", "Sábado"
];

const showEditModal = (event) => {
    if (!userPermissions.includes("eventos_editar")) {
        return;
    }
    modal.value = {
        show: true,
        type: "edit",
        event,
    };
    closeviewModal();
};
const showEvent = (event) => {
    viewModal.value = { show: true, event };
};

onMounted(() => {
    getAreas();
    getEventos();
    getItem();
});

// Navegacion entre meses
const changeMonth = (delta) => {
    currentMonth.value += delta;
    if (currentMonth.value < 0) {
        currentMonth.value = 11;
        currentYear.value -= 1;
    } else if (currentMonth.value > 11) {
        currentMonth.value = 0;
        currentYear.value += 1;
    }
    getEventos();
};

const getAreas = async () => {
    await axios
        .get(route("areas.findAll"))
        .then((response) => {
            areas.value = response.data;
        })
        .catch((error) => {
            console.log(error);
        });
};

const getItem = () => {
    axios
        .get("/api/config-dashboard")
        .then((response) => {
            item.value = response.data;
            eventosTitulo.value = item.value[0].titulo_evento;
        })
        .catch((error) => {
            console.error("Error fetching item:", error);
        });
};
</script>

<template>
    <Layout>

        <Head title="Eventos" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Eventos</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                <h3>Home -</h3>
                </Link>
                <Link href="#" class="active">
                <h3>Calendario</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="max-w-4xl mx-auto py-10">
                <h1 class="text-2xl font-bold text-center mb-6">
                    {{ eventosTitulo || "Calendario de eventos" }}
                </h1>

                <!-- Month and Year Selector -->
                <div class="flex items-center justify-between mb-4">
                    <button @click="changeMonth(-1)" class="px-4 py-2 bg-gray-200 rounded shadow hover:bg-gray-300">
                        &lt; anterior
                    </button>
                    <div class="text-lg font-semibold">
                        {{ monthNames[currentMonth] }} {{ currentYear }}
                    </div>
                    <button @click="changeMonth(1)" class="px-4 py-2 bg-gray-200 rounded shadow hover:bg-gray-300">
                        siguiente &gt;
                    </button>
                </div>

                <!-- Calendar Grid -->
                <div class="grid grid-cols-7 gap-2">
                    <div class="font-semibold text-center">Do</div>
                    <div class="font-semibold text-center">Lu</div>
                    <div class="font-semibold text-center">Ma</div>
                    <div class="font-semibold text-center">Mi</div>
                    <div class="font-semibold text-center">Ju</div>
                    <div class="font-semibold text-center">Vi</div>
                    <div class="font-semibold text-center">Sa</div>

                    <!-- Empty Days for Offset -->
                    <div v-for="n in firstDayOfMonth" :key="'empty-' + n" class="border p-4 rounded-lg bg-gray-100">
                    </div>

                    <!-- Days of the Month -->
                    <div v-for="day in daysInMonth" :key="'day-' + day"
                        class="border p-4 rounded-lg text-center relative hover:bg-gray-50">
                        <div>{{ day }}</div>
                        <div v-if="userPermissions.includes('eventos_crear')">
                            <button class="absolute top-2 right-2 bg-slate-600 text-white text-xs px-2 py-1 rounded"
                                @click="showCreateModal(day)">
                                +
                            </button>
                        </div>
                        <ul class="mt-2 text-sm">
                            <li v-for="event in events[
                                formatDate(
                                    currentYear,
                                    currentMonth + 1,
                                    day
                                )
                            ] || []" :key="event.id" class="rounded mb-1 cursor-pointer hover:bg-gray-200 flex"
                                @click="showEvent(event)">
                                <div :for="color" :style="{
                                    backgroundColor: event.area.color,
                                    color: event.area.color,
                                    width: '20px',
                                    height: '20px',
                                }"
                                    class="rounded-full cursor-pointer border-2 border-transparent peer-checked:border-gray-4 00 transition">
                                </div>
                                {{ event.titulo }}
                            </li>
                        </ul>
                    </div>
                </div>

                <!-- Modals -->
                <!-- <div v-if="modal.show" class="fixed inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center">
                    <div class="bg-white p-6 rounded-lg shadow-lg max-w-md w-full">
                        <h2 class="text-xl font-semibold mb-4">
                            {{
                                modal.type === "create"
                                    ? "Crear nuevo Evento"
                                    : "Actualizar Evento"
                            }}
                        </h2>
                        <form @submit.prevent="submit">
                            <div class="mb-4">
                                <label class="block text-sm font-medium mb-1">Titulo</label>
                                <input v-model="modal.event.titulo" type="text" class="w-full border rounded p-2"
                                    required />
                            </div>
                            <div class="mb-4">
                                <label class="block text-sm font-medium mb-1">Descripción</label>
                                <textarea v-model="modal.event.descripcion" class="w-full border rounded p-2"
                                    rows="3"></textarea>
                            </div>
                            <div class="mb-4">
                                <label class="block text-sm font-medium mb-1">Fecha</label>
                                <input v-model="modal.event.fecha_inicio" type="date" class="w-full border rounded p-2"
                                    disabled required />
                            </div>

                            <div class="mb-4">
                                <select name="pilar" v-model="modal.event.area_id" id="pilar">
                                    <option value="" selected disabled>
                                        Seleccione una opcion
                                    </option>
                                    <option v-for="area in areas" :key="area.id" :value="area.id">
                                        {{ area.nombre }}
                                    </option>
                                </select>
                            </div>
                            <div class="flex justify-end space-x-2">
                                <button type="button" class="px-4 py-2 bg-slate-800 text-white rounded pi pi-times"
                                    @click="closeModal"></button>
                                <button type="submit"
                                    class="px-4 py-2 bg-[#BEA34B] text-white rounded pi pi-save"></button>
                            </div>
                        </form>
                    </div>
                </div> -->

                <div v-if="modal.show"
                    class="absolute inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center">
                    <div class="bg-white p-6 rounded-lg shadow-lg max-w-md w-full">
                        <h2 class="text-xl font-semibold mb-4">
                            {{ modal.type === "create" ? "Crear nuevo Evento" : "Actualizar Evento" }}
                        </h2>
                        <form @submit.prevent="submit">
                            <!-- Título -->
                            <div class="mb-4">
                                <label class="block text-sm font-medium mb-1">Título</label>
                                <input v-model="modal.event.titulo" type="text" class="w-full border rounded p-2"
                                    required />
                            </div>

                            <!-- Descripción -->
                            <div class="mb-4">
                                <label class="block text-sm font-medium mb-1">Descripción</label>
                                <textarea v-model="modal.event.descripcion" class="w-full border rounded p-2"
                                    rows="3"></textarea>
                            </div>

                            <!-- Fecha Inicio -->
                            <div class="mb-4">
                                <label class="block text-sm font-medium mb-1">Fecha de Inicio</label>
                                <input v-model="modal.event.fecha_inicio" type="date" class="w-full border rounded p-2"
                                    required />
                            </div>

                            <!-- Área -->
                            <div class="mb-4">
                                <label class="block text-sm font-medium mb-1">Área</label>
                                <select v-model="modal.event.area_id" class="w-full border rounded p-2">
                                    <option value="" disabled>Seleccione una opción</option>
                                    <option v-for="area in areas" :key="area.id" :value="area.id">{{ area.nombre }}
                                    </option>
                                </select>
                            </div>

                            <!-- ubicacion -->
                            <div class="mb-4">
                                <label class="block text-sm font-medium mb-1">Ubicacion</label>
                                <input v-model="modal.event.ubicacion" type="text" class="w-full border rounded p-2"
                                    required />
                            </div>

                            <!-- link -->
                            <div class="mb-4">
                                <label class="block text-sm font-medium mb-1">Link de referencia</label>
                                <input v-model="modal.event.link" type="text" class="w-full border rounded p-2" />
                            </div>

                            <!-- Recurrencia -->
                            <div class="mb-4">
                                <label class="block text-sm font-medium mb-1">Recurrencia</label>
                                <select v-model="modal.event.recurrencia" class="w-full border rounded p-2">
                                    <option value="none">Ninguna</option>
                                    <option value="daily">Diaria</option>
                                    <option value="weekly">Semanal</option>
                                    <option value="monthly">Mensual</option>
                                </select>
                            </div>

                            <!-- Día de la Semana (Si es Semanal) -->
                            <div class="mb-4" v-if="modal.event.recurrencia === 'weekly'">
                                <label class="block text-sm font-medium mb-1">Día de la Semana</label>
                                <select v-model="modal.event.dia_semana" class="w-full border rounded p-2">
                                    <option v-for="(day, index) in diasSemana" :key="index" :value="index">
                                        {{ day }}
                                    </option>
                                </select>
                            </div>

                            <!-- Día del Mes (Si es Mensual) -->
                            <div class="mb-4" v-if="modal.event.recurrencia === 'monthly'">
                                <label class="block text-sm font-medium mb-1">Día del Mes</label>
                                <input v-model="modal.event.dia_mes" type="text" class="w-full border rounded p-2"
                                    placeholder="Ejemplo: 1, 15, first_monday, last_friday" />
                            </div>

                            <!-- Número de Repeticiones -->
                            <div class="mb-4" v-if="modal.event.recurrencia !== 'none'">
                                <label class="block text-sm font-medium mb-1">Número de Repeticiones</label>
                                <input v-model="modal.event.num_repeticiones" type="number" min="1"
                                    class="w-full border rounded p-2" placeholder="Ejemplo: 5, 10, 15" />
                            </div>

                            <!-- Botones -->
                            <div class="flex justify-end space-x-2">
                                <button type="button" class="px-4 py-2 bg-slate-800 text-white rounded"
                                    @click="closeModal">
                                    Cancelar
                                </button>
                                <button type="submit" class="px-4 py-2 bg-[#BEA34B] text-white rounded">
                                    Guardar
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
                <div v-if="viewModal.show"
                    class="absolute inset-0 bg-gray-800 bg-opacity-50 flex justify-center items-center">
                    <div class="bg-white p-6 rounded-lg shadow-lg max-w-md w-full">
                        <!--
                        <h2 class="text-xl font-semibold mb-4">
                            {{ viewModal.event.titulo }}
                        </h2>
                        <p class="text-sm text-gray-600 mb-4">
                            Descripción: {{ viewModal.event.descripcion }}
                        </p>
                        <p class="text-sm text-gray-600 mb-4">
                            Fecha: {{ viewModal.event.fecha_inicio }}
                        </p>
                        <p class="text-sm text-gray-600 mb-4">
                            {{ viewModal.event.fecha_final }}
                        </p>

                        <div
                            :for="color"
                            :style="{
                                backgroundColor: viewModal.event.area.color,
                                color: viewModal.event.area.color,
                                width: '60px',
                                height: '20px',
                            }"
                            class="rounded-full cursor-pointer border-2 border-transparent peer-checked:border-gray-4 00 transition"
                        ></div>-->
                        <div class="flex flex-col w-full md:flex-row">
                            <div class="p-4 font-normal text-gray-800 w-full">
                                <h1 class="mb-4 text-4xl font-bold leading-none tracking-tight text-gray-800">
                                    {{ viewModal.event.titulo }}
                                </h1>
                                <h2 class="mb-4 text-xl font-bold leading-none tracking-tight text-gray-800 text-right">
                                    {{ viewModal.event.fecha_inicio }}
                                </h2>
                                <p class="leading-normal">
                                    {{ viewModal.event.descripcion }}
                                </p>
                                <div class="flex flex-row items-center mt-4 text-gray-700">
                                    <div class="w-1/2">
                                        {{ viewModal.event.area.nombre }}
                                        <div :style="{
                                            backgroundColor:
                                                viewModal.event.area.color,
                                        }" class="w-full h-2"></div>
                                    </div>
                                    <div class="w-1/2 flex justify-end">
                                        <img src="../../../img/logos/logoAionBusiness_color.png" alt="" class="w-14" />
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="flex justify-end space-x-2">
                            <div v-if="
                                userPermissions.includes('eventos_editar')
                            ">
                                <button class="px-4 py-2 bg-[#BEA34B] text-white rounded pi pi-pencil"
                                    @click="showEditModal(viewModal.event)"></button>
                            </div>
                            <div v-if="
                                userPermissions.includes('eventos_eliminar')
                            ">
                                <button class="px-4 py-2 bg-red-500 text-white rounded pi pi-trash"
                                    @click="deleteEvento(viewModal.event)"></button>
                            </div>
                            <button class="px-4 py-2 bg-slate-800 text-white rounded pi pi-times"
                                @click="closeviewModal"></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>

<style></style>
