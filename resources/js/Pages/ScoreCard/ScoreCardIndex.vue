<script setup>
import { onMounted, ref, watch } from "vue";
import Layout from '@/Layouts/Layout.vue';
import { Head, Link } from '@inertiajs/vue3';
import axios from 'axios';
import Tabs from 'primevue/tabs';
import TabList from 'primevue/tablist';
import Tab from 'primevue/tab';
import TabPanels from 'primevue/tabpanels';
import TabPanel from 'primevue/tabpanel';
import ContenidoPanel from "./Partials/ContenidoPanel.vue";

const props = defineProps({
});

const title = "ScoreCard";
const areas = ref();


onMounted(() => {
    getAreas();
})

// watch(() => () => {

// });

async function getAreas() {
    await axios
        .get("/api/areas")
        .then((response) => (areas.value = response.data))
        .catch((error) => {
            console.log(error);
        });
}


</script>

<template>
    <Layout :titulo="title">

        <Head title="Assessment" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>ScoreCard</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                <h3>Home -</h3>
                </Link>
                <Link href="#" class="active">
                <h3>ScoreCard</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">
                    <div class="card">
                        <Tabs :value=0>
                            <TabList>
                                <!-- @click="getOneKpi(kpi.id)" -->
                                <Tab v-for="( area, key ) in areas" :key=key :value=key>
                                    {{ area.nombre }}
                                </Tab>
                            </TabList>
                            <TabPanels>
                                <TabPanel v-for="( area, key ) in areas" :key=key :value=key class="overflow-auto">
                                    <ContenidoPanel :area=area />
                                </TabPanel>
                            </TabPanels>
                        </Tabs>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>
