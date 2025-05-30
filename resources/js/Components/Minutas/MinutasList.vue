<script setup>
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import { ref, onMounted, watch } from "vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import axios from "axios";
import Tabs from "primevue/tabs";
import TabList from "primevue/tablist";
import Tab from "primevue/tab";
import TabPanels from "primevue/tabpanels";
import TabPanel from "primevue/tabpanel";
import ContenidoPanel from "./TabPanel/ContenidoPanel.vue";

const props = defineProps({});
const emit = defineEmits(["newTarea", "close"]);

const title = "minutero";
const areas = ref([]);
const area_id = props.area_id ? ref(props.area_id - 1) : ref(0);
const departamento_id = ref(props.departamento_id);
const userPermissions = usePage().props.auth.user.permissions;

onMounted(() => {
    getAreas();
});

const getAreas = async () => {
    try {
        const response = await axios.get("/api/areas");
        areas.value = response.data;
    } catch (error) {
        console.error(error);
    }
};

const newTarea = (minuta_id) => {
    console.log("en listado", minuta_id);

    emit("newTarea", minuta_id);
};
</script>

<template>
    <div class="px-4 py-2 bg-white border-b border-gray-200">
        <div class="container mx-auto overflow-x-auto">
            <div class="card">
                <Tabs :value="area_id ? area_id : 0">
                    <TabList>
                        <Tab
                            v-for="(area, key) in areas"
                            :key="key"
                            :value="key"
                        >
                            {{ area.nombre }}
                        </Tab>
                    </TabList>
                    <TabPanels>
                        <TabPanel
                            v-for="(area, key) in areas"
                            :key="key"
                            :value="key"
                            class="overflow-auto"
                        >
                            <ContenidoPanel
                                @close="$emit('close')"
                                @tarea="newTarea"
                                :area="area"
                                :departamento_id="departamento_id"
                            />
                        </TabPanel>
                    </TabPanels>
                </Tabs>
            </div>
        </div>
    </div>
</template>

<style>
.breadcrumbs {
    display: flex;
    gap: 8px;
    align-items: center;
}

.breadcrumbsTitulo h3 {
    font-size: 24px;
    font-weight: bold;
}

.breadcrumbs h3 {
    font-size: 20px;
}

.breadcrumbs a {
    color: #000;
    text-decoration: none;
}

.breadcrumbs .active h3 {
    font-weight: bold;
}
</style>
