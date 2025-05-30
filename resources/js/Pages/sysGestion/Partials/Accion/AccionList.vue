<script setup>
import { ref, onMounted, watch } from "vue";
import { usePage } from "@inertiajs/vue3";
import axios from "axios";
import { confirmDialog, showToast } from "@/Pages/utils/SweetAlert.service";

const props = defineProps({
    area_id: Number,
    departamento_id: Number,
    tipo: String,
});

// Define emits
const emit = defineEmits(["edit"]);

const area_id = ref(props.area_id);
const departamento_id = ref(props.departamento_id);
const tipo = ref(props.tipo);
const accionesCorrectivas = ref([]);
const userPermissions = usePage().props.auth.user.permissions;

console.log({ area_id: area_id.value, tipo: tipo.value });
onMounted(() => {
    getAcciones();
});

watch(
    () => props.departamento_id,
    (newDepartamento_id) => {
        departamento_id.value = newDepartamento_id;
        getAcciones();
    }
);

const getAcciones = async () => {
    try {
        await axios
            .get(
                route("acciones.byDepartamento", {
                    departamento_id: departamento_id.value,
                    tipo: tipo.value,
                })
            )
            .then((response) => {
                accionesCorrectivas.value = response.data;
                console.log({ acciones: accionesCorrectivas.value });
            })
            .catch((error) => {
                console.log(error);
            });
        console.log(accionesCorrectivas);
    } catch (error) {
        console.error(error);
    }
};

const editAccion = (id) => {
    emit("edit", id);
};

const deleteAccion = async (id) => {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Ya no podras revertir esto!",
            "warning"
        );
        if (result.isConfirmed) {
            await axios.delete(route("acciones.destroy", id));
            accionesCorrectivas.value = accionesCorrectivas.value.filter(
                (accion) => accion.id !== id
            );
            showToast("El registro ha sido eliminado", "success");
        }
    } catch (error) {}
};
</script>

<template>
    <div class="max-h-40 w-full overflow-y-auto no-scrollbar">
        <ul>
            <li
                v-for="accionCorrectiva in accionesCorrectivas"
                class="border-b border-gray-200 grid grid-cols-[85%_15%]"
            >
                <div>
                    <a
                        class="hover:underline text-blue-500"
                        target="blank"
                        :href="accionCorrectiva.link"
                    >
                        {{ accionCorrectiva.titulo }}
                    </a>
                </div>
                <div class="text-right">
                    <div
                        v-if="userPermissions.includes('pdca_acciones_editar')"
                    >
                        <button
                            class="pi pi-pencil text-red-500 mx-2 justify-end"
                            @click="editAccion(accionCorrectiva.id)"
                        ></button>
                    </div>

                    <div
                        v-if="
                            userPermissions.includes('pdca_acciones_eliminar')
                        "
                    >
                        <button
                            class="pi pi-times text-red-500 mx-2"
                            @click="deleteAccion(accionCorrectiva.id)"
                        ></button>
                    </div>
                </div>
            </li>
            <div class="text-center" v-if="accionesCorrectivas.length < 1">
                <span>No hay acciones</span>
            </div>
        </ul>
    </div>
</template>
