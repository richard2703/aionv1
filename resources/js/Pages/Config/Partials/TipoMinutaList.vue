<script setup>
import { ref, onMounted } from "vue";
import { Head, Link, useForm } from "@inertiajs/vue3";
import { usePage } from '@inertiajs/vue3';
import axios from "axios";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import { confirmDialog, showToast } from "@/Pages/utils/SweetAlert.service";


const tiposMinutas = ref([]);

// Define emits
const emit = defineEmits(['edit']);


onMounted(() => {
    getTiposMinuta();
}
);

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

const editTipo = (id) => {
    emit('edit', id)
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
            tiposMinutas.value = tiposMinutas.value.filter((tipo) => tipo.id !== id);
            showToast("El registro ha sido eliminado", "success");

        }
    } catch (error) {

    }
};
</script>

<template>
    <div class="py-2">
        <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
            <div class="px-4 py-2 bg-white border-b border-gray-200">
                <div class="container mx-auto">

                    <div class="mt-5 py-2">

                        <ul class="m-4">
                            <li class="border-b my-2" v-for="tipoMinuta in tiposMinutas">
                                {{ tipoMinuta.titulo }}
                                <div class="float-right">
                                    <button class="pi pi-pencil text-red-500 mx-2"
                                        @click="editTipo(tipoMinuta.id)"></button>
                                    <button class="pi pi-times text-red-500 mx-2"
                                        @click="deleteTipo(tipoMinuta.id)"></button>
                                </div>
                            </li>

                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </div>
</template>
