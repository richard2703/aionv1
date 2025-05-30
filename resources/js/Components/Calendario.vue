<script setup>
import { onMounted, ref } from "vue";
import Modal from "@/Components/Modal.vue";
import axios from "axios";

const props = defineProps({
    eventos: Array,
});

/**
 * prop color suport 10 colors
 * color: gray, red, orange, yellow, green, teal, blue, indigo, purple, pink
 */
const today = ref(new Date());
const attrs = ref([]);

const eventos = ref([]);
const eventosByDate = ref([]);
const selectedDate = ref(null);
const isDateModalOpen = ref(false);
const item = ref([]);
const eventosTitulo = ref("");

onMounted(() => {
    getEventos();
    getItem();
});

const getEventos = async () => {
    try {
        const { data } = await axios.get(route("eventos.findAll"));
        eventos.value = data;

        eventos.value.forEach((evento) => {
            // Crear la fecha base
            const fechaInicio = new Date(evento.fecha_inicio);
            // Sumar un día
            fechaInicio.setDate(fechaInicio.getDate() + 1);

            attrs.value.push({
                highlight: {
                    color: evento.area.color,
                    fillMode: "light",
                },
                dot: true,
                dates: fechaInicio,
            });
        });
    } catch (error) {
        console.error("Error fetching events:", error);
    }
};

const handleDateClick = async ({ date }) => {
    selectedDate.value = date;

    const formattedDate = selectedDate.value.toISOString().split("T")[0];

    console.log(formattedDate);

    await axios.get(route("eventos.byDate", formattedDate)).then((response) => {
        eventosByDate.value = response.data;
    });
    console.log({ eventosByDate: eventosByDate.value });

    isDateModalOpen.value = true;
};

const closeDateModal = () => {
    selectedDate.value = null;
    isDateModalOpen.value = false;
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
    <div class="flex justify-center py-4">
        <div class="justify-center text-center">
            <h1>{{ eventosTitulo || "Calendario de eventos" }}</h1>
            <!-- <VDatePicker v-model="date" /> -->
            <v-date-picker
                @dayclick="handleDateClick"
                :attributes="attrs"
                :masks="masks"
            />
        </div>
    </div>

    <!-- Modal -->
    <Modal :show="isDateModalOpen" :modalData="evento" maxWidth="lg">
        <template v-slot="{ modalData }">
            <div class="flex flex-col w-full">
                <div
                    v-for="eventoByDate in eventosByDate"
                    :key="index"
                    class="p-4 font-normal text-gray-800 w-full mb-4"
                >
                    <h1
                        class="mb-4 text-4xl font-bold leading-none tracking-tight text-gray-800"
                    >
                        {{ eventoByDate.titulo }}
                    </h1>
                    <h2
                        class="mb-4 text-xl font-bold leading-none tracking-tight text-gray-800 text-right"
                    >
                        {{ eventoByDate.fecha_inicio }}
                    </h2>
                    <p class="leading-normal">
                        {{ eventoByDate.descripcion }}
                    </p>
                    <div class="flex flex-row items-center mt-4 text-gray-700">
                        <div class="w-1/2">
                            {{ eventoByDate.area.nombre }}
                        </div>
                    </div>
                </div>
                <div class="pr-4 flex justify-end">
                    <img
                        src="../../img/logos/logoAionBusiness_color.png"
                        alt=""
                        class="w-14"
                    />
                </div>
            </div>

            <div class="flex justify-end space-x-2 p-4">
                <button
                    class="px-4 py-2 bg-slate-800 text-white rounded pi pi-times"
                    @click="closeDateModal"
                ></button>
            </div>
        </template>
    </Modal>
</template>

<style></style>
