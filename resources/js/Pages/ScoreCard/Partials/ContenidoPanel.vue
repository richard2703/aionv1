<script setup>
import { onMounted, ref, watch } from "vue";
import axios from 'axios';
import InputLabel from "@/Components/InputLabel.vue";

const props = defineProps({
    area: Object,
});

const area = ref(props.area);
const departamentos = ref([]);
const departamento_id = ref('');
const kpis = ref([]);

onMounted(() => {
    getDepartamentos(area.value.id);
    getKpis();
})

watch(() => props.area, (newArea) => {
    area.value = newArea;
    // getKpis();
});

const getDepartamentos = async (userArea) => {
    await axios
        .get(route("departamentos.byArea", userArea))
        .then((response) => {
            departamentos.value = response.data.departamentos
        })
        .catch((error) => {
            console.log(error);
        });
}
const getKpis = async () => {
    await axios
        .get(route("kpis.byArea", area.value.id))
        .then((response) => {
            kpis.value = response.data;
        })
        .catch((error) => {
            console.log(error);
        });
}

const getKpisbyDepartamento = async (departamento_id) => {
    console.log({ departamento_id });
    if (departamento_id) {
        await axios
            .get(route("kpis.byDepartamento", departamento_id))
            .then((response) => {
                kpis.value = response.data;
            })
            .catch((error) => {
                console.log(error);
            });
        return
    }
    getKpis();
};

const getTrend = (promedio, objetivo, regla) => {

    const diferencia = (promedio - objetivo) / objetivo;

    if (diferencia > 0.05) {
        return regla === 1 ? 'pi pi-arrow-up text-green-500 font-black' : 'pi pi-arrow-up text-red-500 font-black';
    } else if (diferencia > 0.03) {
        return regla === 1 ? 'pi pi-arrow-up text-green-300' : 'pi pi-arrow-up text-red-300';
    } else if (diferencia > 0.01) {
        return regla === 1 ? 'pi pi-arrow-up text-yellow-500' : 'pi pi-arrow-up text-orange-500';
    } else if (diferencia < -0.01) {
        return regla === 1 ? 'pi pi-arrow-down text-orange-500' : 'pi pi-arrow-down text-yellow-500';
    } else if (diferencia < -0.03) {
        return regla === 1 ? 'pi pi-arrow-down font-weight: bolder' : 'pi pi-arrow-down text-green-300';
    } else if (diferencia < -0.05) {
        return regla === 1 ? 'pi pi-arrow-down text-red-500 font-black' : 'pi pi-arrow-down text-green-500 font-black';
    } else {
        return 'pi pi-minus text-gray-500';
    }
};

const getStatus = (actual, objetivo, regla) => {

    if (regla === 1) {
        return actual >= objetivo ? 'pi pi-check text-green-500 font-black' : 'pi pi-times text-red-500 font-black';
    } else {
        return actual <= objetivo ? 'pi pi-check text-green-500 font-black' : 'pi pi-times text-red-500 font-black';
    }
};

</script>

<template>
    <div class="w-full">
        <div class="p-2">
            <div class="mt-4">
                <InputLabel for="departamento_id" value="Flujo de valor: " />

                <select ref="departamento_select" @change="getKpisbyDepartamento(departamento_id)"
                    class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                    v-model="departamento_id">
                    <option value="" selected>
                        Todos
                    </option>
                    <option v-for="departamento in departamentos" :key="departamento.id" :value="departamento.id">
                        {{ departamento.nombre }}
                    </option>
                </select>
            </div>
            <div class="mt-4">
                <table class="border border-collapse mb-4 w-full">
                    <thead>
                        <tr class="bg-slate-100">
                            <th class="p-2 mx-2 text-left">KPI</th>
                            <th class="p-2 mx-2 text-center">Real</th>
                            <th class="p-2 mx-2 text-center">Objetivo</th>
                            <th class="p-2 mx-2 text-center">PYD</th>
                            <th class="p-2 mx-2 text-center">Estatus</th>
                            <th class="p-2 mx-2 text-center">Tendencia</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="kpi in kpis" :key="kpi.id" class="border hover:bg-gray-100">
                            <td class="p-2 mx-2 text-left">{{ kpi.titulo }}</td>
                            <td class="p-2 mx-2 text-center">{{ kpi.actual }}</td>
                            <td class="p-2 mx-2 text-center">{{ kpi.objetivo }}</td>
                            <td class="p-2 mx-2 text-center">
                                <div v-if="kpi.promedio">
                                    {{ kpi.promedio }}
                                </div>
                                <div v-else>
                                    <i class="pi pi-minus text-gray-500"></i>
                                </div>
                            </td>
                            <td class="p-2 mx-2 text-center">
                                <!-- <div v-if="kpi.promedio > kpi.objetivo"><i class="pi pi-check text-green-500"></i>
                                </div>
                                <div v-else-if="kpi.promedio < kpi.objetivo"><i class="pi pi-times text-red-500"></i>
                                </div>
                                <div v-else>
                                    <i class="pi pi-times text-red-500"></i>
                                </div> -->
                                <div>
                                    <i :class="getStatus(kpi.actual, kpi.objetivo, kpi.regla)"></i>
                                </div>
                            </td>
                            <td class="p-2 mx-2 text-center">
                                <div v-if="kpi.promedio">
                                    <div>
                                        <i :class="getTrend(kpi.promedio, kpi.objetivo, kpi.regla)"></i>
                                    </div>

                                    <!-- <div v-if="kpi.promedio > kpi.objetivo * 1.05"><i
                                            class="pi pi-arrow-up text-green-500"></i></div> -->
                                    <!-- aumento más de 5%  -->
                                    <!-- <div v-else-if="kpi.promedio > kpi.objetivo * 1.025"><i
                                            class="pi pi-arrow-up text-green-300"></i></div> -->
                                    <!-- aumento hasta 5% -->
                                    <!-- <div v-else-if="kpi.promedio > kpi.objetivo * 1.0125"><i
                                            class="pi pi-arrow-up text-yellow-500"></i></div> -->
                                    <!-- aumento hasta 2.5% -->
                                    <!-- <div v-else-if="kpi.promedio == kpi.objetivo"><i
                                            class="pi pi-minus text-gray-500"></i>
                                    </div> -->
                                    <!-- no aumento ni disminuyó -->
                                    <!-- <div v-else-if="kpi.promedio > kpi.objetivo * 0.9875"><i
                                            class="pi pi-arrow-down text-red-200"></i></div> -->
                                    <!-- disminuyó hasta -2.5% -->
                                    <!-- <div v-else-if="kpi.promedio > kpi.objetivo * 0.95"><i
                                            class="pi pi-arrow-down text-red-300"></i></div> -->
                                    <!-- disminuyó hasta -5% -->
                                    <!-- <div v-else><i class="pi pi-arrow-down text-red-500"></i></div> -->
                                    <!-- disminuyó más de -5% -->
                                </div>
                                <div v-else>
                                    <i class="pi pi-minus text-gray-500"></i>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</template>
