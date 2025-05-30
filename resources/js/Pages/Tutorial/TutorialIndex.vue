<script setup>
import { onMounted, computed } from "vue";
import { Head, Link } from "@inertiajs/vue3";
import Layout from "@/Layouts/Layout.vue";
import PdfViewer from "@/Components/PdfViewer.vue";

const props = defineProps({
    filename: String,
});

onMounted(() => {});

const pdfUrl = "/pdfs/manual_aion.pdf";
</script>

<template>
    <Layout :titulo="title">
        <Head title="Tutorial" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Tutorial</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link class="active">
                    <h3>Tutorial</h3>
                </Link>
            </div>
        </div>

        <div class="flex overflow-auto">
            <PdfViewer :pdf-url="pdfUrl" />
        </div>
    </Layout>
</template>

<style></style>
