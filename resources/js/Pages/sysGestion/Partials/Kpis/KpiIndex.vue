<script setup>
import { onMounted, ref, watch } from "vue";
import { useForm, usePage } from "@inertiajs/vue3";
import axios from "axios";
import Modal from "@/Components/Modal.vue";
import KpiList from "@/Pages/sysGestion/Partials/Kpis/KpiList.vue";
import Tabs from "primevue/tabs";
import TabList from "primevue/tablist";
import Tab from "primevue/tab";
import TabPanels from "primevue/tabpanels";
import TabPanel from "primevue/tabpanel";
import { format } from "date-fns";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import { showToast } from "@/Pages/utils/SweetAlert.service";

const props = defineProps({
    departamento_id: Number,
    kpis: Array,
});

const departamento_id = ref(props.departamento_id);
const kpis = ref([]);
const isEditModalVidible = ref(false);
const isHistoricosVisible = ref(false);
const activeTab = ref();
const editedRegistro = ref();
const formTitle = ref();
const kpi = ref({});
const updateFlag = ref(false);
const userPremissions = usePage().props.auth.user.permissions;
const formEditModal = useForm({
    actual: "",
});

onMounted(() => {
    getKpis();
});

watch(
    () => props.departamento_id,
    (newDepartamento_id) => {
        departamento_id.value = newDepartamento_id;
        getKpis();
    }
);

const getKpis = async () => {
    await axios
        .get(route("kpis.byDepartamento", departamento_id.value))
        .then((response) => {
            kpis.value = response.data;

            if (kpis.value.length > 0) {
                if (!activeTab.value) {
                    activeTab.value = kpis.value[0].id;
                    getOneKpi(activeTab.value);
                }
            } else {
                activeTab.value = "1";
            }
        })
        .catch((error) => {
            console.log(error);
        });
};

const formatearFecha = (dateString) => {
    return format(new Date(dateString), "dd/MM/yyyy");
};

const openEditModal = async (id) => {
    if (!userPremissions.includes("pdca_kpi_editar")) {
        return;
    }
    await axios
        .get(route("registros_kpi.edit", id))
        .then((response) => {
            (formEditModal.actual = response.data.actual),
                (editedRegistro.value = response.data.id),
                (formTitle.value = response.data.kpis.titulo),
                (updateFlag.value = !updateFlag.value);
        })
        .catch((error) => {
            console.log(error);
        });
    isEditModalVidible.value = true;
};

const closeModal = () => {
    isEditModalVidible.value = false;
};

async function submitEditModal() {
    closeModal();
    await axios
        .patch(
            route("registros_kpi.update", editedRegistro.value),
            formEditModal
        )
        .then((response) => {
            getKpis();
            showToast("El registro ha sido creado", "success");
            formEditModal.actual = "";
            updateFlag.value = !updateFlag.value;
        })
        .catch((error) => {
            console.log(error);
        });
}

async function getOneKpi(id) {
    await axios.get(route("kpis.byId", id)).then((response) => {
        kpi.value = response.data;
    });
}
</script>

<template>
    <div class="w-full">
        <KpiList
            class="border-b my-4"
            :kpi="kpi"
            :updateFlag="updateFlag"
            @updateKpi="getKpis"
        />
        <hr />
        <div class="card">
            <Tabs :value="activeTab">
                <TabList>
                    <Tab
                        v-for="kpi in kpis"
                        :key="kpi.titulo"
                        :value="kpi.id"
                        @click="getOneKpi(kpi.id)"
                    >
                        {{ kpi.titulo }}
                    </Tab>
                </TabList>
                <TabPanels>
                    <TabPanel
                        v-for="kpi in kpis"
                        :key="kpi.titulo"
                        :value="kpi.id"
                    >
                        <table class="min-w-full border-collapse mb-4">
                            <thead>
                                <tr>
                                    <th
                                        class="py-2 px-4 border hover:bg-slate-100 cursor-pointer"
                                        colspan="2"
                                        @click="
                                            isHistoricosVisible =
                                                !isHistoricosVisible
                                        "
                                    >
                                        Historico
                                    </th>
                                </tr>
                            </thead>
                            <tbody v-if="isHistoricosVisible === true">
                                <tr>
                                    <td class="py-2 px-4 border">Valor</td>
                                    <td class="py-2 px-4 border">Fecha</td>
                                </tr>
                                <tr
                                    v-for="registro in kpi.registros"
                                    :key="registro.id"
                                    class="hover:bg-slate-50 cursor-pointer"
                                    @click="openEditModal(registro.id)"
                                >
                                    <td class="py-2 px-4 border">
                                        {{ registro.actual }}
                                    </td>
                                    <td class="py-2 px-4 border">
                                        {{
                                            formatearFecha(registro.created_at)
                                        }}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </TabPanel>
                </TabPanels>
            </Tabs>
        </div>
    </div>

    <!-- MODAL to edit value -->
    <Modal :show="isEditModalVidible" maxWidth="lg">
        <template v-slot="">
            <div>
                <div
                    class="px-4 my-4 py-2 flex justify-center bg-white border-b border-gray-200"
                >
                    <p class="text-lg font-medium text-gray-900">
                        {{ formTitle }}
                    </p>
                </div>
                <div class="px-4 py-2 bg-white border-b border-gray-200">
                    <div class="container mx-auto">
                        <form @submit.prevent="submitEditModal">
                            <div
                                class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-4"
                            >
                                <div class="my-4">
                                    <InputLabel
                                        for="Nuevo Valor"
                                        value="Nuevo Valor "
                                    />
                                    <TextInput
                                        id="objetivo"
                                        v-model="formEditModal.actual"
                                        type="number"
                                        step="any"
                                        class="mt-1 block w-full"
                                        required
                                        autocomplete="new-challenge"
                                    />
                                </div>
                            </div>

                            <div class="flex justify-between">
                                <PrimaryButton
                                    @click.prevent="closeModal"
                                    class="bg-red-500 ms-4 pi pi-times"
                                    :class="{
                                        'opacity-25': formEditModal.abort,
                                    }"
                                    :disabled="formEditModal.abort"
                                >
                                </PrimaryButton>

                                <PrimaryButton
                                    class="ms-4 pi pi-save"
                                    :class="{
                                        'opacity-25': formEditModal.processing,
                                    }"
                                    :disabled="formEditModal.processing"
                                >
                                </PrimaryButton>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </template>
    </Modal>
</template>
