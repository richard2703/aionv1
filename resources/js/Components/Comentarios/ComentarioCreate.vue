<script setup>
import { onMounted, ref } from "vue";
import { useForm } from "@inertiajs/vue3";
import axios from "axios";
import Textarea from "primevue/textarea";
import InputLabel from "@/Components/InputLabel.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { showToast } from "@/Pages/utils/SweetAlert.service";

const props = defineProps({
    reporte_semanal_id: Number,
});
const reporte_semanal_id = props.reporte_semanal_id;
const emit = defineEmits(["list"]);

const form = useForm({
    texto: "",
    reporte_semanal_id: "",
    menciones: [], // IDs de usuarios mencionados
});

const users = ref([]); // Lista de usuarios disponibles
const filteredUsers = ref([]); // Usuarios filtrados
const showSuggestions = ref(false); // Mostrar sugerencias de autocompletado

onMounted(() => {
    getUsuarios();
});

const onInput = (event) => {
    const cursorPosition = event.target.selectionStart;
    const textBeforeCursor = form.texto.slice(0, cursorPosition);
    const match = textBeforeCursor.match(/@(\w*)$/); // Detecta si se escribió @ seguido de texto
    if (match) {
        const searchText = match[1];
        filteredUsers.value = users.value.filter((user) =>
            user.name.toLowerCase().includes(searchText.toLowerCase())
        );
        showSuggestions.value = true;
    } else {
        showSuggestions.value = false;
    }
};

const selectUser = (user) => {
    const textarea = document.querySelector("textarea");
    const cursorPosition = textarea.selectionStart;
    const textBeforeCursor = form.texto.slice(0, cursorPosition);
    const textAfterCursor = form.texto.slice(cursorPosition);
    form.texto =
        textBeforeCursor.replace(/@\w*$/, `@${user.name} `) + textAfterCursor;

    // Agrega el ID del usuario mencionado si aún no está en el array
    if (!form.menciones.includes(user.id)) {
        form.menciones.push(user.id);
    }

    showSuggestions.value = false;
};

const submit = async () => {
    await axios
        .post(route("comentario.store"), {
            texto: form.texto,
            reporte_semanal_id: reporte_semanal_id,
            menciones: form.menciones, // Enviar IDs de usuarios mencionados
        })
        .then(() => {
            showToast("Comentario creado correctamente", "success");
            form.reset();
            form.menciones = []; // Limpia las menciones
            emit("list");
        })
        .catch((error) => {
            console.log(error);
        });
};

const getUsuarios = async () => {
    try {
        const response = await axios.get("/api/usuarios/all/todo");
        users.value = response.data;
    } catch (error) {
        console.error(error);
    }
};
</script>

<template>
    <form @submit.prevent="submit()">
        <div class="mt-4 relative">
            <InputLabel for="texto" value="Deja tu observación o anotación:" />
            <Textarea
                class="p-3 w-full"
                v-model="form.texto"
                @input="onInput"
                rows="5"
                cols="30"
            />
            <!-- Lista de sugerencias -->
            <ul
                v-if="showSuggestions"
                class="relative bg-white border border-gray-300 shadow-md z-10 max-h-40 overflow-auto w-full mt-1"
            >
                <li
                    v-for="user in filteredUsers"
                    :key="user.id"
                    @click="selectUser(user)"
                    class="p-2 hover:bg-gray-100 cursor-pointer text-black"
                >
                    {{ user.name }}
                </li>
            </ul>
        </div>

        <div class="flex items-center justify-end mt-4">
            <PrimaryButton
                class="ms-4 pi pi-save"
                :class="{ 'opacity-25': form.processing }"
                :disabled="form.processing"
            >
                <span
                    class="p-1"
                    :style="{
                        fontSize: '10px',
                    }"
                >
                    Guardar</span
                >
            </PrimaryButton>
        </div>
    </form>
</template>

<style scoped>
ul {
    list-style: none;
    padding: 0;
    margin: 0;
}
</style>
