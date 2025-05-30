<script setup>
import { onMounted, ref } from "vue";
import { useForm } from "@inertiajs/vue3";
import axios from "axios";

import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { showToast } from "@/Pages/utils/SweetAlert.service";
import AutoComplete from 'primevue/autocomplete';

const props = defineProps({
    tipo: String,
    procesos: Array,
    area_id: Number,
    departamento_id: Number,
});

const emit = defineEmits(['list']);

const procesos = ref(props.procesos);
const area_id = ref(props.area_id);
const departamento_id = ref(props.departamento_id);
const tipo = ref(props.tipo);
const usuarios = ref([]);
const filteredUsuarios = ref();

const form = useForm({
    tipo_id: "",
    proceso_id: "",
    area_id: area_id.value,
    departamento_id: departamento_id.value,
    responsable_id: "",
    estatus_id: "",
    titulo: "",
    link: "",
});

onMounted(() => {
    getUsuarios();
    getProcesos();
});

const getUsuarios = async () => {
    try {
        const response = await axios.get("/api/usuarios/all/todo");
        usuarios.value = response.data;
    } catch (error) {
        console.error(error);
    }
};

const getProcesos = async () => {
    await axios.get(route("procesos.byDepartamento", departamento_id.value))
        .then((response) => (procesos.value = response.data.procesos))
        .catch((error) => {
            console.log(error);
        });
}

const search = (event) => {
    console.log("buscando");
    setTimeout(() => {
        if (!event.query.trim().length) {
            console.log(filteredUsuarios.value);
            filteredUsuarios.value = [...usuarios.value];
        } else {
            filteredUsuarios.value = usuarios.value.filter((usuario) => {
                return usuario.name.toLowerCase().includes(event.query.toLowerCase());
            });
        }
    }, 250);
}

const submit = async () => {
    try {
        switch (tipo.value) {
            case 'correctiva':
                form.tipo_id = 1;
                break;

            case 'preventiva':
                form.tipo_id = 2;
                break;

            case 'mejora':
                form.tipo_id = 3;
                break;

            default:
                form.tipo_id = 1;
                break;
        }
        await axios.post(route("acciones.store"), form.data())
            .then(() => {
                showToast("El registro ha sido creado", "success");
                form.reset();
                emit('list');
            })
    } catch (error) {
        showToast("Ocurrio un error", "error");
        console.error(error);
    }
};

</script>

<template>
    <div class="w-full">
        <h2 class="text-center text-xl">Nueva acción</h2>
        <form @submit.prevent="submit" class="w-full ">
            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-4">
                <div class="mt-4">
                    <InputLabel for="nombre" value="Nombre:" />
                    <TextInput id="nombre" v-model="form.titulo" type="text" class="mt-1 block w-full" required
                        autocomplete="nombre" />
                </div>
                <div class="mt-4">
                    <InputLabel for="proceso" value="Proceso:" />
                    <select ref="proceso_select"
                        class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                        v-model="form.proceso_id" required>
                        <option value="" disabled selected>
                            Seleccione una opcion
                        </option>
                        <option v-for="proceso in procesos" :key="proceso.id" :value="proceso.id">
                            {{ proceso.nombre }}
                        </option>
                    </select>
                </div>
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-4">
                <div class="mt-4">
                    <InputLabel for="responsable_id" value="Responsable:" />
                    <AutoComplete v-model="form.responsable_id" optionLabel="name" :suggestions="filteredUsuarios"
                        forceSelection @complete="search" placeholder="" />
                </div>
                <div class="mt-4">
                    <InputLabel for="estatus" value="Estatus: " />
                    <select ref="departamento_select"
                        class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                        v-model="form.estatus_id" required>
                        <option value="" selected disabled>
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
            </div>

            <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-4">
                <div class="mt-4">
                    <InputLabel for="link" value="Link:" />
                    <TextInput id="link" v-model="form.link" type="text" class="mt-1 block w-full" required
                        autocomplete="link" />
                </div>
            </div>
            <div class="m-4 py-2">
                <PrimaryButton class="ms-4 pi pi-save float-right" :class="{ 'opacity-25': form.processing }"
                    :disabled="form.processing">

                </PrimaryButton>
            </div>
        </form>
    </div>
</template>
