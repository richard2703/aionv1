<script setup>
import { onMounted, ref, computed } from "vue";
import Layout from "@/Layouts/Layout.vue";
import { Head, Link, useForm } from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TextInput from "@/Components/TextInput.vue";
import { showToast } from "../utils/SweetAlert.service";
import Textarea from 'primevue/textarea';
import AutoComplete from 'primevue/autocomplete';
import Select from 'primevue/select';


const props = defineProps({
    minuta: Object,
    areas: Array,
    departamentos: Array || null,
    procesos: Array,
    usuarios: Array,
});

const minuta = ref(props.minuta);
const areas = ref(props.areas);
const departamentos = ref(props.departamentos);
const procesos = ref(props.procesos);
const usuarios = ref(props.usuarios);
const filteredUsuarios = ref();
const responsable_id = ref();
const tiposMinutas = ref([]);

const title = "minutero";


async function getAreas() {
    await axios
        .get("/api/areas")
        .then((response) => (areas.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}

async function getDepartamentos(area_id) {
    await axios
        .get(route("departamentos.byArea", area_id))
        .then((response) => (departamentos.value = response.data.departamentos))
        .catch((error) => {
            console.log(error);
        });
}

async function getProcesos() {
    await axios
        .get("/api/procesos")
        .then((response) => (procesos.value = response.data.data))
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

const getTiposMinuta = async () => {
    try {
        await axios.get(route("tipo-minuta.index"))
            .then((response) => {
                tiposMinutas.value = response.data;
            })
            .catch((error) => {
                console.log(error);
            });
        console.log(tiposMinutas);
    } catch (error) {
        console.error(error);
    }
};

console.log({ lider: minuta });
const form = useForm({
    area_id: minuta.value.area_id,
    departamento_id: minuta.value.departamento_id,
    proceso_id: minuta.value.proceso?.nombre,
    lider_id: minuta.value.lider.name,
    tipo: minuta.value.tipo,
    alias: minuta.value.alias,
    notas: minuta.value.notas,
    estatus: minuta.value.estatus,
    privada: minuta.value.privada,
    oculto: minuta.value.oculto
});


const onChange = async (event) => {
    const taget_id = event.target.value;
    await axios
        .get(route("departamentos.byArea", taget_id))
        .then((response) => (departamentos.value = response.data.departamentos))
        .catch((error) => {
            console.log(error);
        });

};

const submit = () => {
    try {
        form.patch(route("minutas.update", minuta.value.id), {
            onFinish: () => {
                showToast("El registro ha sido creado", "success");
                form.reset();
            },
        });

    } catch (error) {
        showToast("Ocurrio un error", "error");
        console.error(error);
    }
};

onMounted(() => {
    getAreas();
    getDepartamentos(minuta.value.area_id);
    getUsuarios();
    getProcesos();
    getTiposMinuta();
})
console.log({ procesos: procesos });
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

const isPrivadaChecked = computed({
    get() {
        return form.privada === 1;
    },
    set(value) {
        form.privada = value ? 1 : 0;
    },
});

const isHidden = computed({
    get() {
        return form.oculto === 1;
    },
    set(value) {
        form.oculto = value ? 1 : 0;
    },
});

</script>

<template>
    <Layout :titulo="title">

        <Head title="Minutas" />

        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Editar Minuta</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                <h3>Home -</h3>
                </Link>
                <Link :href="route('minutas.index')" class="px-1">
                <h3>Minutas -</h3>
                </Link>
                <Link :href="route('minutas.edit', minuta.id)" class="active">
                <h3>Editar</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>
                    <div class="px-4 my-4 py-2 flex justify-end bg-white border-b border-gray-200"></div>
                    <div class="px-4 py-2 bg-white border-b border-gray-200">
                        <div class="container mx-auto">
                            <form @submit.prevent="submit">

                                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-4">
                                    <div class="mt-4">
                                        <InputLabel for="area_id" value="Pilar: " />
                                        <select ref="area_select" @change="onChange($event)"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.area_id" required>
                                            <option value="" disabled selected>
                                                Seleccione una opcion
                                            </option>
                                            <option v-for="area in areas" :key="area.id" :value="area.id">
                                                {{ area.nombre }}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="mt-4">
                                        <InputLabel for="departamento_id" value="Flujo de valor: " />

                                        <select ref="departamento_select"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.departamento_id">
                                            <option value="" selected>
                                                Todos los flujos
                                            </option>
                                            <option v-for="departamento in departamentos" :key="departamento.id"
                                                :value="departamento.id">
                                                {{ departamento.nombre }}
                                            </option>
                                        </select>
                                    </div>
                                    <div class="mt-4">
                                        <InputLabel for="tipo" value="Tipo: " />

                                        <select ref="tipo_select"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.tipo" required>
                                            <option value="" disabled selected>
                                                Seleccione una opcion
                                            </option>
                                            <option v-for="tipoMinuta in tiposMinutas" :key="tipoMinuta.id"
                                                :value="tipoMinuta.id">
                                                {{ tipoMinuta.titulo }}
                                            </option>
                                        </select>
                                    </div>
                                </div>

                                <div class="mt-4">
                                    <InputLabel for="proceso_id" value="Proceso: " />
                                    <Select v-model="form.proceso_id" editable
                                        :virtualScrollerOptions="{ itemSize: 38 }" :options="procesos"
                                        optionLabel="nombre" placeholder="Seleccione una opcion"
                                        class="w-full md:w-56" />
                                </div>

                                <div class="mt-4">
                                    <InputLabel for="lider" value="Lider: " />
                                    <AutoComplete v-model="form.lider_id" optionLabel="name"
                                        :suggestions="filteredUsuarios" forceSelection @complete="search"
                                        placeholder="" />
                                </div>

                                <div class="mt-4">
                                    <InputLabel for="alias" value="Alias: " />
                                    <TextInput id="alias" v-model="form.alias" type="text" class="mt-1 block w-full"
                                        required autocomplete="new-challenge" />
                                </div>

                                <!-- <div class="mt-4">
                                        <InputLabel for="estatus" value="Estatus: " />

                                        <select ref="departamento_select"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.estatus" required>
                                            <option value="0" selected>
                                                Retrasado </option>
                                            <option value="1" selected>
                                                Iniciado </option>
                                            <option value="2" selected>
                                                En proceso </option>
                                            <option value="3" selected>
                                                Terminado </option>
                                        </select>
                                    </div> -->

                                <div class=" mt-4">
                                    <InputLabel for="notas" value="Notas: " />
                                    <Textarea v-model="form.notas" rows="3" style="width: 100%; " />
                                </div>
                                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-4">
                                    <div class=" mt-4">
                                        <!-- <InputLabel for="Privada" value="¿Exclusivo para lideres de pilar? " /> -->
                                        <!-- <input type="checkbox" @change="validateTarea(slotProps.data, $event)"
                                                :disabled="slotProps.data.validacion ? true : false"
                                                :checked="slotProps.data.validacion ? true : false" /> Validar -->
                                        <!-- <input type="checkbox" v-model="isPrivadaChecked" />
                                        Exclusivo -->

                                        <div class=" mt-4">
                                            <!-- <InputLabel for="Privada" value="Exclusivo para lideres de pilar?: " /> -->
                                            <!-- <input type="checkbox" @change="validateTarea(slotProps.data, $event)"
                                                :disabled="slotProps.data.validacion ? true : false"
                                                :checked="slotProps.data.validacion ? true : false" /> Validar -->
                                            <!-- <input type="checkbox" v-model="form.privada" /> Exclusivo -->
                                            <InputLabel for="Privada" value="Nivel de la minuta: " />
                                            <select ref="departamento_select"
                                                class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                                v-model="form.privada" required>
                                                <option value=3 selected>
                                                    3 Líderes flujo de valor - Equipo </option>
                                                <option value=2 selected>
                                                    2 Gerentes de pilar - líderes flujo de valor</option>
                                                <option value=1 selected>
                                                    1 staff directivo</option>
                                                <option value=0 selected>
                                                    0 Consejo de Admin</option>
                                            </select>
                                        </div>
                                    </div>

                                    <div class=" mt-4">
                                        <InputLabel for="oculto" value="¿Ocultar la minuta?" />
                                        <!-- <input type="checkbox" @change="validateTarea(slotProps.data, $event)"
                                                :disabled="slotProps.data.validacion ? true : false"
                                                :checked="slotProps.data.validacion ? true : false" /> Validar -->
                                        <input type="checkbox" v-model="isHidden" />
                                        Ocultar
                                    </div>
                                </div>

                                <div class="px-4 my-4 pt-2 flex justify-end bg-white border-t border-gray-200">
                                    <PrimaryButton class="ms-4 pi pi-save" :class="{ 'opacity-25': form.processing, }"
                                        :disabled="form.processing">

                                    </PrimaryButton>
                                </div>

                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>
