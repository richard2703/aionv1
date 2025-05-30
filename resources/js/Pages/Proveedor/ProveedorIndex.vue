<script setup>
import { Head, Link, usePage } from "@inertiajs/vue3";
import { ref, onMounted } from "vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";
import axios from "axios";
import Layout from "@/Layouts/Layout.vue";
import Tabs from "primevue/tabs";
import TabList from "primevue/tablist";
import Tab from "primevue/tab";
import TabPanels from "primevue/tabpanels";
import TabPanel from "primevue/tabpanel";
import ContenidoPanel from "./Partials/TabPanel/ContenidoPanel.vue";

const props = defineProps({});
const areas = ref([]);
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

<template>
    <Layout>
        <Head title="Proveedor" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Proveedores</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link class="active" href="#">
                    <h3>Proveedores</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div
                    class="px-4 py-2 flex justify-end bg-white border-b border-gray-200"
                >
                    <div v-if="userPermissions.includes('directorio_crear')">
                        <PrimaryButton
                            class="m-4 pi pi-plus"
                            :href="route('proveedores.create')"
                        >
                            <span
                                class="p-1"
                                :style="{
                                    fontSize: '10px',
                                }"
                            >
                                Nuevo proveedor</span
                            >
                        </PrimaryButton>
                    </div>
                </div>
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
                                        <ContenidoPanel :area="area" />
                                    </TabPanel>
                                </TabPanels>
                            </Tabs>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
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
