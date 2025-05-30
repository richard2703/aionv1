<script setup>
import { ref, onMounted } from "vue";
import Chart from 'primevue/chart';
import axios from "axios";


const props = defineProps({
    evaluacion: Object
})

const evaluacion = ref(props.evaluacion);
const results = ref({});
const chartData = ref();
const chartOptions = ref();
const chartValues = ref();
const chartLabels = ref();

onMounted(() => {
    chartData.value = setChartData();
    chartOptions.value = setChartOptions();
    formatDataSet();
});

const formatDataSet = async () => {
    await axios
        .get(route('evaluaciones.barChart', evaluacion.value.id))
        .then((response) => {
            // return

            chartValues.value = response.data.map(record => record.score);
            chartLabels.value = response.data.map(record => record.seccion.titulo);
            results.value = response.data;
            console.log({ chartValues: chartValues.value, chartLabels: chartLabels.value, results: results.value });

        })
        .catch((error) => {
            console.log(error);
        });
}
const setChartData = () => {
    const documentStyle = getComputedStyle(document.documentElement);

    return {
        labels: chartLabels,
        datasets: [
            {
                label: 'Resultados por Sección',
                backgroundColor: documentStyle.getPropertyValue('--p-cyan-500'),
                borderColor: documentStyle.getPropertyValue('--p-cyan-500'),
                data: chartValues
            }
        ]
    };
};
const setChartOptions = () => {
    const documentStyle = getComputedStyle(document.documentElement);
    const textColor = documentStyle.getPropertyValue('--p-text-color');
    const textColorSecondary = documentStyle.getPropertyValue('--p-text-muted-color');
    const surfaceBorder = documentStyle.getPropertyValue('--p-content-border-color');

    return {
        indexAxis: 'y',
        maintainAspectRatio: false,
        aspectRatio: 0.8,
        plugins: {
            legend: {
                labels: {
                    color: textColor
                }
            }
        },
        scales: {
            x: {
                ticks: {
                    color: textColorSecondary,
                    font: {
                        weight: 500
                    }
                },
                grid: {
                    display: false,
                    drawBorder: false
                }
            },
            y: {
                ticks: {
                    color: textColorSecondary
                },
                grid: {
                    color: surfaceBorder,
                    drawBorder: false
                }
            }
        }
    };
}
</script>

<template>
    <div class="card">
        <Chart type="bar" :data="chartData" :options="chartOptions" class="bar w-full  flex justify-center" />
    </div>
</template>

<style>
.bar {
    width: 100%;
    height: 800px;
}
</style>
