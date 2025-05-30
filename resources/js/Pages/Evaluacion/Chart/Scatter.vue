<script setup>
import { ref, onMounted } from "vue";
import Chart from "primevue/chart";

const props = defineProps({
    evaluacion: Object,
});

const evaluacion = ref(props.evaluacion);
const results = ref({});
const chartData = ref();
const chartOptions = ref();
// const chartValues = ref();
const chartLabels = ref();
const aionX = ref();
const aionY = ref();
const item = ref();
const business = ref();

onMounted(() => {
    config();
    formatDataSet();
});

const formatDataSet = async () => {
    await axios
        .get(route("evaluaciones.scatterChart", evaluacion.value.id))
        .then((response) => {
            results.value = response.data;
            aionX.value = Number(formatNumber(results.value.promedioGente));
            aionY.value = Number(formatNumber(results.value.promedioProcess));
            // Seinicializa el grafico con los valores iniciales de la BD
            chartData.value = setChartData();
            chartOptions.value = setChartOptions();
        })
        .catch((error) => {
            console.log(error);
        });
};

const config = async () => {
    await axios
        .get("/api/config-dashboard")
        .then((response) => {
            item.value = response.data;
            business.value = item.value[0].nombre_negocio;
        })
        .catch((error) => {
            console.error("Error fetching item:", error);
        });
};
const setChartData = () => {
    const documentStyle = getComputedStyle(document.documentElement);

    return {
        labels: chartLabels,
        datasets: [
            {
                label: `${business.value}`,
                data: [{ x: aionX.value, y: aionY.value }],
                backgroundColor: "rgba(255, 99, 132, 0.2)",
                borderColor: "rgba(255, 99, 132, 1)",
                borderWidth: 1,
            },
            {
                label: "Others",
                data: [
                    { x: 52, y: 63 },
                    { x: 18, y: 15 },
                    { x: 32, y: 25 },
                    { x: 76, y: 85 },
                    { x: 25, y: 63 },
                    { x: 48, y: 39 },
                    { x: 75, y: 65 },
                    { x: 83, y: 77 },
                    { x: 62, y: 60 },
                    { x: 49, y: 63 },
                    { x: 52, y: 42 },
                    { x: 69, y: 83 },
                    { x: 65, y: 80 },
                    { x: 80, y: 81 },
                    { x: 75, y: 62 },
                    { x: 55, y: 42 },
                    { x: 39, y: 35 },
                    { x: 36, y: 42 },
                    { x: 53, y: 27 },
                    { x: 24, y: 19 },
                    { x: 27, y: 19 },
                    { x: 34, y: 29 },
                    { x: 43, y: 48 },
                    { x: 37, y: 35 },
                    { x: 54, y: 59 },
                    { x: 24, y: 28 },
                    { x: 37, y: 32 },
                    { x: 48, y: 32 },
                    { x: 41, y: 53 },
                    { x: 30, y: 30 },
                    { x: 44, y: 59 },
                    { x: 59, y: 47 },
                ],
                backgroundColor: "rgba(54, 162, 235, 0.2)",
                borderColor: "rgba(54, 162, 235, 1)",
                borderWidth: 1,
            },
        ],
    };
};
const setChartOptions = () => {
    const documentStyle = getComputedStyle(document.documentElement);
    const textColor = documentStyle.getPropertyValue("--p-text-color");
    const textColorSecondary = documentStyle.getPropertyValue(
        "--p-text-muted-color"
    );
    const surfaceBorder = documentStyle.getPropertyValue(
        "--p-content-border-color"
    );

    return {
        maintainAspectRatio: false,
        aspectRatio: 0.6,
        plugins: {
            legend: {
                labels: {
                    color: textColor,
                },
            },
        },
        scales: {
            x: {
                min: 0,
                max: 100,
                ticks: {
                    color: textColorSecondary,
                },
                grid: {
                    color: surfaceBorder,
                },
            },
            y: {
                min: 0,
                max: 100,
                ticks: {
                    color: textColorSecondary,
                },
                grid: {
                    color: surfaceBorder,
                },
            },
        },
    };
};

function formatNumber(value) {
    if (value == null) return ""; // Manejar el caso cuando el valor es nulo o indefinido
    return parseFloat(value).toFixed(2);
}
</script>

<template>
    <div class="card">
        <Chart
            type="scatter"
            :data="chartData"
            :options="chartOptions"
            class="w-full h-96 flex justify-center"
        />
    </div>
</template>
