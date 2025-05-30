<script setup>
import Layout from "@/Layouts/Layout.vue";
import { Head, Link } from "@inertiajs/vue3";

const props = defineProps({});

const title = "notebook"; // Aquí asegúrate de que esto coincida con el valor que esperas en MainMenu
</script>

<template>
    <Layout :titulo="title" :subTitulo="subTitle">
        <Head title="Notebook" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Notebook</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link class="active" :href="route('sysgestion.dashboard')">
                    <h3>Notebook</h3>
                </Link>
            </div>
        </div>
        <!-- TODO: Esta seccion es para alojar el notebook en un iframe en caso que sea posible -->
        <div class="py-2"></div>
    </Layout>
</template>
