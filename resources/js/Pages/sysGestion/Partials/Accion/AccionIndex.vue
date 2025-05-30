<script setup>
import { ref, onMounted } from "vue";
// import { Head, Link, useForm } from "@inertiajs/vue3";
import { usePage } from "@inertiajs/vue3";
import axios from "axios";
// import PrimaryButton from "@/Components/PrimaryButton.vue";
import { confirmDialog, showToast } from "@/Pages/utils/SweetAlert.service";
import AccionList from "@/Pages/sysGestion/Partials/Accion/AccionList.vue";
import AccionCreate from "@/Pages/sysGestion/Partials/Accion/AccionCreate.vue";
import AccionEdit from "@/Pages/sysGestion/Partials/Accion/AccionEdit.vue";

const props = defineProps({
    tipo: String,
    procesos: Array,
    area_id: Number,
    departamento_id: Number,
});

console.log({
    procesosIndex: props.procesos,
    tipo: props.tipo,
    area_id: props.area_id,
});
// Define emits TODO: difinir emits
const emit = defineEmits([]);

const triger = ref("list");
const accion = ref({});
const procesos = ref(props.procesos);
const tipo = ref(props.tipo);
const userPermissions = usePage().props.auth.user.permissions;

onMounted(() => {
    // getTiposMinuta();
});

console.log({ procesosEnAcciones: procesos });

const editAccion = (id) => {
    axios
        .get(route("acciones.edit", id))
        .then((response) => {
            accion.value = response.data;
            triger.value = "edit";
        })
        .catch((error) => {
            console.log(error);
        });
};

const deleteTipo = async (id) => {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Ya no podras revertir esto!",
            "warning"
        );
        if (result.isConfirmed) {
            await axios.delete(route("tipo-minuta.destroy", id));
            tiposMinutas.value = tiposMinutas.value.filter(
                (tipo) => tipo.id !== id
            );
            showToast("El registro ha sido eliminado", "success");
        }
    } catch (error) {}
};
</script>

<template>
    <div class="py-2">
        <div class="bg-white sm:rounded-lg">
            <div class="px-4">
                <div class="py-2">
                    <div class="flex justify-end">
                        <div
                            v-if="
                                userPermissions.includes('pdca_acciones_crear')
                            "
                        >
                            <button
                                v-if="triger === 'list'"
                                class="pi pi-plus"
                                @click="triger = 'create'"
                            ></button>
                        </div>
                        <div>
                            <button
                                v-if="triger !== 'list'"
                                class="pi pi-minus"
                                @click="triger = 'list'"
                            ></button>
                        </div>
                    </div>
                    <br />
                    <!-- componente -->
                    <div class="flex">
                        <AccionList
                            class="overflow-y-auto"
                            v-if="triger === 'list'"
                            :area_id="area_id"
                            :departamento_id="departamento_id"
                            :tipo="tipo"
                            @edit="(id) => editAccion(id)"
                        />
                        <AccionCreate
                            v-if="triger === 'create'"
                            :area_id="area_id"
                            :departamento_id="departamento_id"
                            :tipo="tipo"
                            :procesos="procesos"
                            @list="triger = 'list'"
                        />
                        <AccionEdit
                            v-if="triger === 'edit'"
                            :area_id="area_id"
                            :departamento_id="departamento_id"
                            :procesos="procesos"
                            :accion="accion"
                            @list="triger = 'list'"
                        />
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
