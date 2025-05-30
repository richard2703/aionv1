<script setup>
import { Head, Link, useForm, usePage } from "@inertiajs/vue3";
import { ref, onMounted, watch } from "vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import axios from "axios";
import Layout from "@/Layouts/Layout.vue";
import Tabs from "primevue/tabs";
import TabList from "primevue/tablist";
import Tab from "primevue/tab";
import TabPanels from "primevue/tabpanels";
import TabPanel from "primevue/tabpanel";
import ContenidoPanel from "./Partials/TabPanel/ContenidoPanel.vue";

const props = defineProps({
    area_id: Number,
    departamento_id: Number,
});
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
</script>

<style scoped>
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

<template>
    <Layout :titulo="title">

        <Head title="Minutas" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Minutas</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                <h3>Home -</h3>
                </Link>
                <Link :href="route('minutas.index')" class="active">
                <h3>Minutas</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>
                    <div class="px-4 py-2 flex justify-end bg-white border-b border-gray-200">
                        <div v-if="userPermissions.includes('minutas_crear')">
                            <PrimaryButton class="m-4 pi pi-plus" :href="route('minutas.create')"></PrimaryButton>
                        </div>
                    </div>
                    <div class="px-4 py-2 bg-white border-b border-gray-200">
                        <div class="container mx-auto overflow-x-auto">
                            <div class="card">
                                <Tabs :value="area_id ? area_id : 0">
                                    <TabList>
                                        <Tab v-for="(area, key) in areas" :key="key" :value="key">
                                            {{ area.nombre }}
                                        </Tab>
                                    </TabList>
                                    <TabPanels>
                                        <TabPanel v-for="(area, key) in areas" :key="key" :value="key"
                                            class="overflow-auto">
                                            <ContenidoPanel :area="area" :departamento_id="departamento_id
                                                " />
                                        </TabPanel>
                                    </TabPanels>
                                </Tabs>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>
