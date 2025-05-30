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
const evaluacionClass = ref();

onMounted(() => {
    chartData.value = setChartData();
    chartOptions.value = setChartOptions();
    formatDataSet();
});

const formatDataSet = async () => {
    await axios
        .get(route('evaluaciones.radarChart', evaluacion.value.id))
        .then((response) => {
            chartValues.value = response.data.map(record => record.score);
            chartLabels.value = response.data.map(record => record.area.nombre);
            results.value = response.data;
        })
        .catch((error) => {
            console.log(error);
        });
}

const setChartData = () => {
    const documentStyle = getComputedStyle(document.documentElement);
    const textColor = documentStyle.getPropertyValue('--p-text-color');

    return {
        labels: chartLabels,
        datasets: [
            {
                label: 'Resultados por Pilar',
                borderColor: documentStyle.getPropertyValue('--p-gray-400'),
                pointBackgroundColor: documentStyle.getPropertyValue('--p-gray-400'),
                pointBorderColor: documentStyle.getPropertyValue('--p-gray-400'),
                pointHoverBackgroundColor: textColor,
                pointHoverBorderColor: documentStyle.getPropertyValue('--p-gray-400'),
                data: chartValues
            },
            {
                label: 'Resultados por Pilar',
                fill: false,
                // borderColor: documentStyle.getPropertyValue('--p-gray-50'),
                // pointBackgroundColor: documentStyle.getPropertyValue('--p-gray-50'),
                // pointBorderColor: documentStyle.getPropertyValue('--p-gray-50'),
                // pointHoverBackgroundColor: textColor,
                // pointHoverBorderColor: documentStyle.getProspertyValue('--p-gray-50'),
                data: [100, 100, 100, 100, 100]
            },
        ]

    };
};
const setChartOptions = () => {
    const documentStyle = getComputedStyle(document.documentElement);
    const textColor = documentStyle.getPropertyValue('--p-text-color');
    const textColorSecondary = documentStyle.getPropertyValue('--p-text-muted-color');

    return {
        plugins: {
            legend: {
                labels: {
                    color: textColor
                }
            }
        },
        scales: {
            r: {
                grid: {
                    color: textColorSecondary
                },
                ticks: {
                    beginAtZero: true,
                    min: 1,
                    max: 100,
                    stepSize: 20,
                    suggestedMin: 50,
                    suggestedMax: 100
                }
            }
        }
    };
};

function setClass(nota) {
    if (nota >= 0 && nota < 21) {
        return evaluacionClass.value = 'text-center border border-slate-500 px-1 content-center bg-red-800 text-white';
    } else if (nota >= 21 && nota < 41) {
        return evaluacionClass.value = 'text-center border border-slate-500 px-1 content-center bg-red-500 text-white';
    } else if (nota >= 41 && nota < 61) {
        return evaluacionClass.value = 'text-center border border-slate-500 px-1 content-center bg-yellow-500 text-white';
    } else if (nota >= 61 && nota < 81) {
        return evaluacionClass.value = 'text-center border border-slate-500 px-1 content-center bg-green-500 text-white';
    } else if (nota >= 81) {
        return evaluacionClass.value = 'text-center border border-slate-500 px-1 content-center bg-blue-500 text-white';
    }
}
</script>

<template>
    <div class="card">
        <Chart type="radar" :data="chartData" :options="chartOptions" class="radar w-full flex justify-center" />
        <div class="flex justify-center ">
            <table class="table w-80 border-collapse border border-slate-400  text-sm">
                <tr v-for="result in results">
                    <td class="text-center border border-slate-500">{{ result.area.nombre }}</td>
                    <td :class="setClass(result.score)">{{ result.score }}%</td>
                    <td v-if="result.score >= 0 && result.score < 21" :class="setClass(result.score)">
                        INICIAL
                    </td>
                    <td v-if="result.score >= 21 && result.score < 41" :class="setClass(result.score)">
                        BÁSICO
                    </td>
                    <td v-if="result.score >= 41 && result.score < 61" :class="setClass(result.score)">
                        INTERMEDIO
                    </td>
                    <td v-if="result.score >= 61 && result.score < 81" :class="setClass(result.score)">
                        AVANZADO
                    </td>
                    <td v-if="result.score >= 81" :class="setClass(result.score)">LÍDER</td>
                </tr>
            </table>
        </div>
    </div>
</template>
