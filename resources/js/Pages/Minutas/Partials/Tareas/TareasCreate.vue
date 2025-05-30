<script setup>
import { onMounted, ref } from "vue";
import { useForm } from "@inertiajs/vue3";
import axios from "axios";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import AutoComplete from "primevue/autocomplete";
import Textarea from "primevue/textarea";
import { showToast } from "@/Pages/utils/SweetAlert.service";

const props = defineProps({
    areas: Array,
    departamentos: Array || null,
    minuta: Object,
});

// Define emits
const emit = defineEmits(["close"]);

const areas = ref(props.areas);
const departamentos = ref(props.departamentos);
const minuta = ref(props.minuta);

const usuarios = ref([]);
const filteredUsuarios = ref([]);

const form = useForm({
    area_id: minuta.value.area_id,
    departamento_id: minuta.value.departamento_id,
    minuta_id: minuta.value.id,
    responsable_id: "",
    revisor_id: "",
    tarea: "",
    fecha: "",
    nota: "",
    estatus_id: "2",
});

const onChange = async (event) => {
    await getDepartamentos(event.target.value);
};

const getAreas = async () => {
    try {
        const response = await axios.get("/api/areas");
        areas.value = response.data;
    } catch (error) {
        console.error(error);
    }
};

const getDepartamentos = async (area_id) => {
    try {
        const response = await axios.get(
            route("departamentos.byArea", area_id)
        );
        departamentos.value = response.data.departamentos;
    } catch (error) {
        console.error(error);
    }
};

const getUsuarios = async () => {
    try {
        const response = await axios.get("/api/usuarios/all/todo");
        usuarios.value = response.data;
    } catch (error) {
        console.error(error);
    }
};

const search = (event) => {
    setTimeout(() => {
        if (!event.query.trim().length) {
            filteredUsuarios.value = [...usuarios.value];
        } else {
            filteredUsuarios.value = usuarios.value.filter((usuario) => {
                return usuario.name
                    .toLowerCase()
                    .includes(event.query.toLowerCase());
            });
        }
    }, 250);
};

const submit = async () => {
    try {
        console.log(form.data());

        await form.post(route("tareas.store"), {
            onFinish: () => {
                showToast("El registro ha sido creado", "success");
                emit("tareaGuardada");
                closeModal();
            },
        });
    } catch (error) {
        showToast("Ocurrio un error", "error");
        console.error(error);
    }
};

const closeModal = () => {
    // Emit event to close modal in the parent component
    emit("close");
};

onMounted(() => {
    getAreas();
    getDepartamentos(minuta.value.area_id);
    getUsuarios();
});
</script>

<template>
    <div class="py-2">
        <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
            <div class="px-4 py-2 bg-white border-b border-gray-200">
                <div class="container mx-auto">
                    <h2 class="text-center text-2xl">Nueva Tarea</h2>
                    <form @submit.prevent="submit">
                        <div class="mt-4">
                            <InputLabel for="minuta_id" value="Reunión:" />
                            <TextInput
                                id="minuta_id"
                                type="text"
                                :value="minuta.alias"
                                class="mt-1 block w-full"
                                disabled
                            />
                            <TextInput
                                id="minuta_id"
                                v-model="form.minuta_id"
                                type="text"
                                class="mt-1 block w-full hidden"
                                required
                                disabled
                                autocomplete="minuta_id"
                            />
                        </div>

                        <div class="mt-4">
                            <InputLabel for="area_id" value="Pilar: " />
                            <select
                                ref="area_select"
                                @change="onChange($event)"
                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                v-model="form.area_id"
                                required
                            >
                                <option value="" disabled selected>
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

                        <div class="mt-4">
                            <InputLabel
                                for="departamento_id"
                                value="Flujo de valor: "
                            />
                            <select
                                ref="departamento_select"
                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                v-model="form.departamento_id"
                                required
                            >
                                <option value="" disabled selected>
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

                        <hr class="my-4" />

                        <div class="mt-4">
                            <InputLabel for="tarea" value="Tarea:" />
                            <TextInput
                                id="tarea"
                                v-model="form.tarea"
                                type="text"
                                class="mt-1 block w-full"
                                required
                                autocomplete="tarea"
                            />
                        </div>
                        <div class="mt-4 z-30">
                            <InputLabel
                                for="responsable_id"
                                value="Responsable:"
                            />
                            <select
                                ref="departamento_select"
                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                v-model="form.responsable_id"
                                required
                            >
                                <option value="" disabled selected>
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
                        <div class="mt-4 z-30">
                            <InputLabel
                                for="revisor_id"
                                value="Cliente de la tarea:"
                            />
                            <select
                                ref="departamento_select"
                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                v-model="form.revisor_id"
                                required
                            >
                                <option value="" disabled selected>
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
                            <InputLabel for="estatus" value="Estatus: " />
                            <select
                                ref="departamento_select"
                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                v-model="form.estatus_id"
                                required
                            >
                                <option value="1">Retrasado</option>
                                <option value="2" selected>Iniciado</option>
                                <option value="3">En proceso</option>
                                <option value="4">Terminado</option>
                            </select>
                        </div>
                        <div class="mt-4">
                            <InputLabel for="fecha" value="Fecha de entrega:" />
                            <TextInput
                                id="fecha"
                                v-model="form.fecha"
                                type="date"
                                class="mt-1 block w-full"
                                required
                                autocomplete="responsable_id"
                            />
                        </div>
                        <div class="mt-4">
                            <InputLabel for="nota" value="Notas: " />
                            <Textarea
                                class="mt-1 block w-full"
                                v-model="form.nota"
                                rows="5"
                                cols="30"
                            />
                        </div>

                        <div class="flex items-center justify-end mt-4">
                            <PrimaryButton
                                class="ms-4 pi pi-save"
                                :class="{ 'opacity-25': form.processing }"
                                :disabled="form.processing"
                            >
                            </PrimaryButton>
                            <PrimaryButton
                                @click="emit('close')"
                                class="ms-4 pi pi-times"
                                :class="{ 'opacity-25': form.processing }"
                                :disabled="form.processing"
                            >
                            </PrimaryButton>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>
