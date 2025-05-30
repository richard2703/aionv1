<script setup>
import { onMounted, ref, watch } from "vue";
import { usePage } from "@inertiajs/vue3";
import InputLabel from "@/Components/InputLabel.vue";
import { confirmDialog, showToast } from "@/Pages/utils/SweetAlert.service";

const props = defineProps({
    area: Object,
});

const area = ref(props.area);
const procesos = ref("");
const selectedProceso = ref("");
const proveedores = ref("");
const userPermissions = usePage().props.auth.user.permissions;

onMounted(() => {
    getProcesos();
    getProveedores();
});

watch(selectedProceso, () => {
    getProveedores();
});

const getProcesos = async () => {
    try {
        const response = await axios.get(
            route("procesos.byArea", area.value.id)
        );

        procesos.value = response.data;
    } catch (error) {}
};

const getProveedores = async () => {
    try {
        const response = await axios.get(
            route("proveedores.findAll", area.value.id),
            {
                params: {
                    proceso_id: selectedProceso.value,
                },
            }
        );
        proveedores.value = response.data;
    } catch (error) {
        console.log(error);
    }
};

const deleteProveedor = async (id) => {
    try {
        const result = await confirmDialog(
            "Estas seguro?",
            "Ya no podras revertir esto!",
            "warning"
        );
        if (result.isConfirmed) {
            await axios.delete(route("proveedores.destroy", id));
            showToast("El registro ha sido eliminado", "success");
            getProveedores();

        }
    } catch (error) {
        console.log(error);
    }
}
</script>

<template>
    <div class="m-4">
        <InputLabel for="proceso_id" value="Procesos: " />
        <select
            ref="proceso_select"
            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
            v-model="selectedProceso"
        >
            <option value="" selected>Ver todos</option>
            <option
                v-for="proceso in procesos"
                :key="proceso.id"
                :value="proceso.id"
            >
                {{ proceso.nombre }}
            </option>
        </select>
    </div>

    <div class="m-4">
        <div v-for="(procesos, key) in proveedores" :key="key">
            <h2 class="text-lg font-medium leading-6 text-gray-900">
                {{ key }}
            </h2>
            <div v-for="proveedor in procesos" :key="proveedor.id" class="m-2">
                <div class="flex flex-col w-full md:flex-row">
                    <div class="p-4 font-normal text-gray-800 w-full">
                        <h3
                            class="mb-4 text-2xl font-bold leading-none tracking-tight text-gray-800"
                        >
                            <span>Proveedor: </span> {{ proveedor.nombre }}
                        </h3>
                        <div class="grid grid-cols-2">
                            <div>
                            <p class="leading-normal">
                                <span>Servicio: </span> {{ proveedor.servicio }}
                            </p>
                            <p class="leading-normal">
                                <span>No. Telefono: </span>
                                <a class="hover:underline text-blue-500 cursor-pointer" :href="'tel:' + proveedor.telefono">{{ proveedor.telefono }}</a>
                            </p>
                            <p class="leading-normal">
                                <span>Correo Electronico: </span>
                                {{ proveedor.correo }}
                            </p>
                            <p class="leading-normal">
                                <span>Sitio Web: </span>
                                <a class="hover:underline text-blue-500 cursor-pointer" :href="proveedor.pagina_web" target="_blank">{{
                                    proveedor.pagina_web
                                }}</a>
                            </p>
                            <p class="leading-normal">
                                <a class="hover:underline text-blue-500 cursor-pointer" :href="proveedor.link_orden" target="_blank">
                                    <span>Hacer orden de compra </span>
                                </a>
                            </p>
                            <p class="leading-normal">
                                <span>Informacion Adicional: </span>
                                <br />
                                <div class="h-20 overflow-y-auto">{{ proveedor.info }}</div>
                            </p>
                        </div>
                            <div>
                                <video controls>
                                    <source :src="proveedor.video" type="video/mp4">
                                    Tu navegador no soporta la etiqueta de video.
                                </video>
                            </div>
                        <div
                            class="flex flex-row items-center mt-4 text-gray-700"
                        >
                            <div class="w-1/2"></div>
                            <div class="w-1/2 flex justify-end">
                                <img
                                    src="../../../../../img/logos/logoAionBusiness_color.png"
                                    alt=""
                                    class="w-20"
                                />
                            </div>
                        </div>
                    </div>
                </div>

                <div class="flex justify-end space-x-2">
                    <div v-if="userPermissions.includes('directorio_editar')">
                        <button
                            class="px-4 py-2 text-[#BEA34B] rounded pi pi-pencil"
                            @click="
                                $inertia.visit(
                                    route('proveedores.edit', proveedor.id)
                                )
                            "
                        ></button>
                    </div>

                    <div v-if="userPermissions.includes('directorio_eliminar')">
                        <button
                            class="px-4 py-2 text-red-500 rounded pi pi-trash"
                            @click="deleteProveedor(proveedor.id)"
                        ></button>
                    </div>
                </div>
                <hr class="my-4">
                </div>
            </div>
        </div>
    </div>
</template>

<style></style>
