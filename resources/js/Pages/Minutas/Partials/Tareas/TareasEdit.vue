<script setup>
import { onMounted, ref } from "vue";
import { useForm } from "@inertiajs/vue3";
import axios from "axios";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import Textarea from "primevue/textarea";
import { showToast } from "@/Pages/utils/SweetAlert.service";
import Image from "primevue/image";

const props = defineProps({
    areas: Array,
    departamentos: Array || null,
    minuta: Object,
    task: Object,
});

// Define emits
const emit = defineEmits(["close"]);

const task = ref(props.task);
const tarea = ref({});
const areas = ref(props.areas);
const departamentos = ref(props.departamentos);
const minuta = ref(props.minuta);

const usuarios = ref([]);
const filteredUsuarios = ref([]);
const evidencias = ref({});

const form = useForm({
    area_id: minuta.value.area_id,
    departamento_id: minuta.value.departamento_id,
    minuta_id: minuta.value.id,
    responsable_id: task.value.responsable_id,
    revisor_id: task.value.revisor_id,
    tarea: task.value.tarea,
    fecha: task.value.fecha,
    nota: task.value.nota,
    estatus_id: task.value.estatus ? task.value.estatus.id : 1,
});

const evidenciaForm = useForm({
    tarea_id: task.value.id,
    img_ref: null,
});

onMounted(() => {
    getAreas();
    getDepartamentos(minuta.value.area_id);
    getUsuarios();
    getEvidencias();
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
        console.log("departamentos.value", departamentos.value);
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
        await form.patch(route("tareas.update", task.value.id), {
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

const onFileChange = (key, event) => {
    console.log("onFileChange", event.target.files[0]);

    evidenciaForm[key] = event.target.files[0];
};

const uploadFile = async () => {
    try {
        const formData = new FormData();
        formData.append("tarea_id", evidenciaForm.tarea_id);
        formData.append("img_ref", evidenciaForm.img_ref);

        const response = await axios
            .post(route("tareas.evidencia.store"), formData, {
                headers: {
                    "Content-Type": "multipart/form-data",
                },
            })
            .then((response) => {
                showToast("La evidencia ha sido subida", "success");
                getEvidencias();
            });
    } catch (error) {
        showToast("Ocurrio un error", "error");
        console.error(error);
    }
};

const getEvidencias = async () => {
    try {
        console.log({ tarea_id: task.value.id });
        const response = await axios.get(
            route("tareaEvidencia.getByTarea", task.value.id)
        );
        evidencias.value = response.data;
        console.log({ evidencias: evidencias.value });
    } catch (error) {
        console.error(error);
    }
};

const deleteEvidencia = async (id) => {
    await axios
        .delete(route("tareas.evidencia.destroy", id))
        .then((response) => {
            showToast("La evidencia ha sido eliminada", "success");
            getEvidencias();
        })
        .catch((error) => {
            showToast("Ocurrio un error", "error");
            console.error(error);
        });
};
</script>

<template>
    <div class="py-2">
        <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
            <div class="px-4 py-2 bg-white border-b border-gray-200">
                <div class="container mx-auto">
                    <h2 class="text-center text-2xl">Editar Tarea</h2>
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
                                <option value="2">Iniciado</option>
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
                <div class="contaier mx-auto">
                    <form
                        @submit.prevent="uploadFile"
                        enctype="multipart/form-data"
                    >
                        <div class="grid grid-cols-1 gap-4">
                            <div>
                                <InputLabel
                                    for="img_ref"
                                    value="Muestra del trabajo realizado: "
                                />
                                <input
                                    id="img_ref"
                                    type="file"
                                    @change="onFileChange('img_ref', $event)"
                                    class="mt-1 block w-full"
                                    autocomplete="img_ref"
                                />
                            </div>

                            <div
                                class="col-span-full flex items-center justify-end mt-4"
                            >
                                <PrimaryButton
                                    class="ms-4 pi pi-upload"
                                    :class="{
                                        'opacity-25': form.processing,
                                    }"
                                    :disabled="form.processing"
                                >
                                </PrimaryButton>
                            </div>
                            <div class="grid grid-cols-1">
                                <div
                                    v-for="(evidencia, index) in evidencias"
                                    :key="index"
                                    class="card flex justify-evenly hover:bg-slate-100"
                                >
                                    <a
                                        :href="evidencia.img_ref"
                                        download
                                        class="cursor-pointer text-blue-500 text-xl"
                                    >
                                        referencia a documento
                                        {{ Number(index) + 1 }}</a
                                    >
                                    <!-- <img :src="evidencia" alt="" srcset=""> -->
                                    <a
                                        class="pi pi-trash text-red-500 cursor-pointer hover:text-red-700 text-2xl"
                                        @click="deleteEvidencia(evidencia.id)"
                                    ></a>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>
