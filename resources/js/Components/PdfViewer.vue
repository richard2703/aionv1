<script setup>
import { ref, onMounted, watch } from "vue";

const props = defineProps({
    pdfUrl: String,
});

const containerRef = ref(null);
const isLoading = ref(false);
const hasError = ref(false);
const errorMessage = ref("");

function loadPdf() {
    if (!props.pdfUrl) {
        hasError.value = true;
        errorMessage.value = "No se proporcionó URL del PDF";
        return;
    }

    try {
        isLoading.value = true;
        hasError.value = false;

        // Clear previous content
        if (containerRef.value) {
            containerRef.value.innerHTML = "";

            // Create iframe with special parameters to hide toolbar
            const iframe = document.createElement("iframe");

            // The key part: Use a URL with parameters to hide controls
            const modifiedUrl = props.pdfUrl.includes("?")
                ? `${props.pdfUrl}&#toolbar=0&navpanes=0&scrollbar=0&statusbar=0&messages=0&scrollbar=0`
                : `${props.pdfUrl}?#toolbar=0&navpanes=0&scrollbar=0&statusbar=0&messages=0&scrollbar=0`;

            iframe.src = modifiedUrl;
            iframe.width = "100%";
            iframe.height = "500px";
            iframe.style.border = "none";

            containerRef.value.appendChild(iframe);
        }

        setTimeout(() => {
            isLoading.value = false;
        }, 1000);
    } catch (error) {
        console.error("Error al cargar el PDF:", error);
        hasError.value = true;
        errorMessage.value = "Error al cargar el PDF: " + error.message;
        isLoading.value = false;
    }
}

// Custom navigation controls
const currentPage = ref(1);
const totalPages = ref(1);

function prevPage() {
    // This function would need to interact with the PDF through the iframe
    // which is challenging without direct PDF.js integration
    alert("Función de navegación no disponible en este modo");
}

function nextPage() {
    // Similarly this would need integration with the PDF viewer
    alert("Función de navegación no disponible en este modo");
}

onMounted(loadPdf);
watch(() => props.pdfUrl, loadPdf);
</script>

<template>
    <div class="pdf-viewer">
        <div v-if="isLoading" class="loading">Cargando PDF...</div>

        <div v-if="hasError" class="error">
            {{ errorMessage }}
        </div>

        <!-- Container for our custom PDF viewer -->
        <div ref="containerRef" class="pdf-container"></div>

        <!-- Custom navigation controls -->
        <!-- <div class="controls" v-if="!hasError && !isLoading">
            <button @click="prevPage">⬅️ Anterior</button>
            <span>Página {{ currentPage }}</span>
            <button @click="nextPage">Siguiente ➡️</button>
        </div> -->
    </div>
</template>

<style scoped>
.pdf-viewer {
    display: flex;
    flex-direction: column;
    align-items: center;
    width: 100%;
    position: relative;
}

.pdf-container {
    width: 100%;
    min-height: 500px;
    border: 1px solid #ccc;
    overflow: hidden;
}

.loading {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    background: rgba(255, 255, 255, 0.8);
    padding: 10px;
    border-radius: 5px;
    z-index: 10;
}

.error {
    color: red;
    padding: 20px;
    text-align: center;
    border: 1px solid #ffcccc;
    background-color: #fff0f0;
    border-radius: 5px;
    margin: 20px 0;
    width: 100%;
}

.controls {
    margin-top: 10px;
    display: flex;
    align-items: center;
    gap: 10px;
}

button {
    padding: 5px 10px;
    background: #007bff;
    color: white;
    border: none;
    cursor: pointer;
    border-radius: 5px;
}

button:disabled {
    background: #ccc;
    cursor: not-allowed;
}
</style>
