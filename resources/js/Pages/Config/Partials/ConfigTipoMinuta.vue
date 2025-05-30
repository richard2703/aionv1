<script setup>
import { ref, onMounted, watch } from "vue";
import { Head, Link, useForm } from "@inertiajs/vue3";
import { usePage } from "@inertiajs/vue3";
import axios from "axios";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import TipoMinutaList from "@/Pages/Config/Partials/TipoMinutaList.vue";
import TipoMinutaCreate from "@/Pages/Config/Partials/TipoMinutaCreate.vue";
import TipoMinutaEdit from "@/Pages/Config/Partials/TipoMinutaEdit.vue";
const accion = ref("list");
const tipoMinuta = ref();

const acciones = (opcion) => {
    if (opcion === "create") {
        accion.value = "create";
    }
    if (opcion === "list") {
        accion.value = "list";
    }
};

const editTipo = (id) => {
    axios
        .get(route("tipo-minuta.edit", id))
        .then((response) => {
            tipoMinuta.value = response.data;
            accion.value = "edit";
        })
        .catch((error) => {
            console.log(error);
        });
};
</script>

<template>
    <div class="py-2">
        <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
            <div class="px-4 py-2 bg-white border-b border-gray-200">
                <div class="container mx-auto">
                    <h2 class="text-center text-2xl">Tipo de minuta</h2>
                    <PrimaryButton
                        v-if="accion === 'list'"
                        class="my-4 float-right pi pi-plus"
                        @click="acciones('create')"
                    >
                        <span
                            class="p-1"
                            :style="{
                                fontSize: '10px',
                            }"
                        >
                            Nuevo tipo de minuta</span
                        >
                    </PrimaryButton>
                    <PrimaryButton
                        v-if="accion !== 'list'"
                        class="my-4 float-right pi pi-arrow-left"
                        @click="acciones('list')"
                    >
                    </PrimaryButton>
                    <div class="flex flex-col w-full"></div>
                    <!-- <PrimaryButton v-if="accion === 'edit'" class=" mb-4 float-right pi pi-plus" @click="">
                    </PrimaryButton>-->

                    <div class="mt-5 py-2">
                        <div v-if="accion === 'list'">
                            <TipoMinutaList @edit="(id) => editTipo(id)" />
                        </div>
                        <div v-if="accion === 'create'">
                            <TipoMinutaCreate @list="accion = 'list'" />
                        </div>
                        <div v-if="accion === 'edit'">
                            <TipoMinutaEdit
                                :tipoMinuta="tipoMinuta"
                                @list="accion = 'list'"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>
