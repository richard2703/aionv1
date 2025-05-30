<script setup>
import { onMounted, ref } from "vue";
import { useForm } from "@inertiajs/vue3";
import axios from "axios";
import Message from "primevue/message";
import ComentarioCreate from "./ComentarioCreate.vue";
import ComentarioUpdate from "./ComentarioUpdate.vue";
import { confirmDialog, showToast } from "@/Pages/utils/SweetAlert.service";

const props = defineProps({
    reporte_semanal_id: Number,
});

const reporte_semanal_id = props.reporte_semanal_id;
const comentarios = ref([]);
const menciones = ref([]);
const comentario = ref();
const editar = ref(false);

const form = useForm({
    texto: "",
    reporte_semanal_id: "",
});

onMounted(() => {
    getComentarios();
});
const getComentarios = async () => {
    const response = await axios.get(
        route("comentario.getComentarios", reporte_semanal_id)
    );
    comentarios.value = response.data.comentarios;
    menciones.value = response.data.menciones;
    console.log({ response: menciones.value });
};

const getComentario = async (comentario_id) => {
    const response = await axios.get(route("comentario.edit", comentario_id));
    comentario.value = response.data;
    form.texto = response.data.texto;
    editar.value = true;
};

const deleteComentario = async (comentario_id) => {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Ya no podras revertir esto!",
            "warning"
        );
        if (result.isConfirmed) {
            const response = await axios
                .delete(route("comentario.destroy", comentario_id))
                .then(() => {
                    getComentarios();
                    showToast("El registro ha sido eliminado", "success");
                });
        }
    } catch (error) {
        console.error(error);
    }
};
</script>

<template>
    <div class="py-2">
        <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
            <div class="p-3 bg-white border-b border-gray-200">
                <div class="my-4">
                    <Message class="w-full text-center" closable severity="secondary">
                        ¡Esta observación no se comparte con nadie!
                    </Message>
                </div>
                <ComentarioCreate v-if="!editar" :reporte_semanal_id="reporte_semanal_id" @list="getComentarios" />
                <ComentarioUpdate v-if="editar" :comentario="comentario" :reporte_semanal_id="reporte_semanal_id"
                    @list="getComentarios" @close="editar = false" />
                <div v-if="comentarios" class="my-4 h-60 overflow-y-auto">
                    <div>
                        <h3 class="text-bold text-black">Observaciones</h3>
                        <ul v-for="comentario in comentarios" :key="comentario.id" class="list-disc list-inside">
                            <div class="flex justify-between">
                                <li class="text-sm text-gray-600 text-justify cursor-pointer hover:text-gray-300"
                                    @click.stop="getComentario(comentario.id)">
                                    {{ comentario.texto }}
                                </li>
                                <button
                                    class="float-right mx-4 pi pi-trash text-red-500 cursor-pointer hover:text-red-300"
                                    @click.stop="
                                        deleteComentario(comentario.id)
                                        "></button>
                            </div>
                        </ul>
                    </div>
                </div>
                <div v-if="menciones" class="my-4 h-42 overflow-y-auto">
                    <div class="text-bold text-black">
                        <h3>Menciones</h3>
                        <ul v-for="mencion in menciones" :key="mencion.id" class="list-disc list-inside">
                            <div class="flex justify-between">
                                <li class="text-sm text-gray-600 text-justify cursor-pointer hover:text-gray-300">
                                    {{ mencion.comentario.texto }}
                                </li>
                            </div>
                        </ul>
                    </div>
                </div>
                <!-- <ComentarioCreate
                    v-if="!editar"
                    :reporte_semanal_id="reporte_semanal_id"
                    @list="getComentarios"
                />
                <ComentarioUpdate
                    v-if="editar"
                    :comentario="comentario"
                    :reporte_semanal_id="reporte_semanal_id"
                    @list="getComentarios"
                    @close="editar = false"
                /> -->
            </div>
        </div>
    </div>
</template>

<style></style>
