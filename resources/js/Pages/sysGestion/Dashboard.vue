<script setup>
import Layout from "@/Layouts/Layout.vue";
import { Head, Link } from "@inertiajs/vue3";


const props = defineProps({

});

const title = "sysGestion"; // Aquí asegúrate de que esto coincida con el valor que esperas en MainMenu
const subTitle = "dashboard"; // Este segundo es por siu viene de un menu desplegable en MainMenu

</script>

<template>
    <Layout :titulo="title" :subTitulo="subTitle">

        <Head title="Dashboard" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Sistema de Gestion</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                <h3>Home -</h3>
                </Link>
                <Link class="active" :href="route('sysgestion.dashboard')">
                <h3>Dashboard</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <!-- <iframe title="KPI AION" width="100%" height="700"
                src="https://app.powerbi.com/view?r=eyJrIjoiNWYxNThlMDktMTRlYy00NzYyLTgwZGUtYzAxYTVjMWNkNWU0IiwidCI6IjIyOWQ1ZTc5LTE0YjgtNDU1MS04MmExLTQ2ZGVkNTk3YzRhYSJ9"
                frameborder="0" allowFullScreen="true"></iframe> -->
            <iframe title="KPI AION" width="100%" height="700"
                src="https://app.powerbi.com/view?r=eyJrIjoiMTYwOWYwNjQtNDUxMy00ZDZiLWIwNjMtOGZiMzA3NDM2OWU2IiwidCI6IjIyOWQ1ZTc5LTE0YjgtNDU1MS04MmExLTQ2ZGVkNTk3YzRhYSJ9"
                frameborder="0" allowFullScreen="true"></iframe>
        </div>
    </Layout>
</template>
