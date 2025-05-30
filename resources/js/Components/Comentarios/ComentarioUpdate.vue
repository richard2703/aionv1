<script setup>
import { onMounted, ref, watch } from "vue";
import { useForm } from "@inertiajs/vue3";
import axios from "axios";
import Textarea from "primevue/textarea";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { showToast } from "@/Pages/utils/SweetAlert.service";

const props = defineProps({
    reporte_semanal_id: Number,
    comentario: Object,
});
const reporte_semanal_id = props.reporte_semanal_id;
const comentario = props.comentario;
const emit = defineEmits(["list", "close"]);

const form = useForm({
    texto: comentario.texto,
});

watch(
    () => props.comentario,
    (newComentario) => {
        form.texto = newComentario.texto;
    }
);
const submit = async () => {
    await axios
        .patch(route("comentario.update", comentario.id), {
            texto: form.texto,
            reporte_semanal_id: reporte_semanal_id,
        })
        .then(() => {
            showToast("Comentario creado correctamente", "success");
            form.reset();
            emit("list");
            emit("close");
        })
        .catch((error) => {
            console.log(error);
        });
};
</script>

<template>
    <form @submit.prevent="submit()">
        <div class="mt-4">
            <InputLabel for="texto" value="Actualiza tu anotación:" />
            <Textarea
                class="p-3 w-full"
                v-model="form.texto"
                rows="5"
                cols="30"
            />
        </div>

        <div class="flex items-center justify-end mt-4 gap-1">
            <PrimaryButton
                class="pi pi-save"
                :class="{ 'opacity-25': form.processing }"
                :disabled="form.processing"
            >
                <span
                    class="p-1"
                    :style="{
                        fontSize: '10px',
                    }"
                >
                    Actualizar</span
                >
            </PrimaryButton>
            <PrimaryButton
                @click="emit('close')"
                class="pi pi-times"
                :class="{ 'opacity-25': form.processing }"
                :disabled="form.processing"
            >
                <span
                    class="p-1"
                    :style="{
                        fontSize: '10px',
                    }"
                >
                    Cancelar</span
                >
            </PrimaryButton>
        </div>
    </form>
</template>

<style></style>
