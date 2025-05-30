<script setup>
import PrimaryButton from '@/Components/PrimaryButton.vue';
import Layout from '@/Layouts/Layout.vue';
import { Head, Link } from '@inertiajs/vue3';
import { onMounted, ref } from 'vue';
import Chart from 'primevue/chart';
import { format } from 'date-fns';
import Bar from './Chart/Bar.vue';
import Radar from "./Chart/Radar.vue";
import Scatter from "./Chart/Scatter.vue";

const props = defineProps({
    evaluacion: Object,

});

const title = "assessment";
const subTitle = "evaluaciones";
const evaluacionClass = ref();
const showInfo = ref(false);

onMounted(() => {
})

const formatearFecha = (dateString) => {
    return format(new Date(dateString), 'dd/MM/yyyy');
};

function formatNumber(value) {
    if (value == null) return ''; // Manejar el caso cuando el valor es nulo o indefinido
    return parseFloat(value).toFixed(2);
}

function setClass(nota) {
    if (nota >= 0 && nota < 21) {
        return evaluacionClass.value = 'px-1 content-center bg-red-800 text-white';
    } else if (nota >= 21 && nota < 41) {
        return evaluacionClass.value = 'px-1 content-center bg-red-500 text-white';
    } else if (nota >= 41 && nota < 61) {
        return evaluacionClass.value = 'px-1 content-center bg-yellow-500 text-white';
    } else if (nota >= 61 && nota < 81) {
        return evaluacionClass.value = 'px-1 content-center bg-green-500 text-white';
    } else if (nota >= 81) {
        return evaluacionClass.value = 'px-1 content-center bg-blue-500 text-white';
    }
}
</script>

<template>
    <Layout :titulo="title" :subTitulo="subTitle">

        <Head title="Assessment" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>RESULTADOS DE AUTOEVALUACIÓN</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                <h3>Home -</h3>
                </Link>
                <Link href="#" class="px-1">
                <h3>Assessment -</h3>
                </Link>
                <Link :href="route('evaluacion.index')" class="px-1">
                <h3>Evaluaciones -</h3>
                </Link>
                <Link href="#" class="active">
                <h3>Benchmark</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div class="p-6 bg-white border-b border-gray-200">

                    <!-- R1 -->
                    <div class="grid grid-cols-3 sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3  gap-2">
                        <div class="bg-slate-500 text-white p-1 rounded content-center">
                            Fecha: {{ formatearFecha(evaluacion.created_at) }}
                        </div>
                        <div class="bg-white p-1 rounded flex justify-between border">
                            <div class="px-1 bg-slate-500 text-white font-bold rounded content-center"> Score:</div>
                            <div :class="setClass(evaluacion.global)">{{ formatNumber(evaluacion.global) }} %</div>
                            <div v-if="evaluacion.global >= 0 && evaluacion.global < 21"
                                :class="setClass(evaluacion.global)">
                                INICIAL
                            </div>
                            <div v-if="evaluacion.global >= 21 && evaluacion.global < 41"
                                :class="setClass(evaluacion.global)">
                                BÁSICO
                            </div>
                            <div v-if="evaluacion.global >= 41 && evaluacion.global < 61"
                                :class="setClass(evaluacion.global)">
                                INTERMEDIO
                            </div>
                            <div v-if="evaluacion.global >= 61 && evaluacion.global < 81"
                                :class="setClass(evaluacion.global)">
                                AVANZADO
                            </div>
                            <div v-if="evaluacion.global >= 81" :class="setClass(evaluacion.global)">LÍDER</div>
                        </div>
                        <div class="bg-white p-1 rounded">
                            <!-- SubGrid -->
                            <div class="grid grid-cols-3 gap-1 border">
                                <div class="bg-slate-500 text-white content-center">People</div>
                                <div v-if="evaluacion.gente >= 0 && evaluacion.gente < 21"
                                    :class="setClass(evaluacion.gente)">
                                    INICIAL
                                </div>
                                <div v-if="evaluacion.gente >= 21 && evaluacion.gente < 41"
                                    :class="setClass(evaluacion.gente)">
                                    BÁSICO
                                </div>
                                <div v-if="evaluacion.gente >= 41 && evaluacion.gente < 61"
                                    :class="setClass(evaluacion.gente)">
                                    INTERMEDIO
                                </div>
                                <div v-if="evaluacion.gente >= 61 && evaluacion.gente < 81"
                                    :class="setClass(evaluacion.gente)">
                                    AVANZADO
                                </div>
                                <div v-if="evaluacion.gente >= 81" :class="setClass(evaluacion.gente)">LÍDER</div>
                                <div :class="setClass(evaluacion.gente)">{{ formatNumber(evaluacion.gente) }}%</div>
                            </div>
                            <div class="grid grid-cols-3 gap-1 border">
                                <div class="bg-slate-500 text-white content-center">Process & Systems</div>
                                <div v-if="evaluacion.proceso >= 0 && evaluacion.proceso < 21"
                                    :class="setClass(evaluacion.proceso)">
                                    INICIAL
                                </div>
                                <div v-if="evaluacion.proceso >= 21 && evaluacion.proceso < 41"
                                    :class="setClass(evaluacion.proceso)">
                                    BÁSICO
                                </div>
                                <div v-if="evaluacion.proceso >= 41 && evaluacion.proceso < 61"
                                    :class="setClass(evaluacion.proceso)">
                                    INTERMEDIO
                                </div>
                                <div v-if="evaluacion.proceso >= 61 && evaluacion.proceso < 81"
                                    :class="setClass(evaluacion.proceso)">
                                    AVANZADO
                                </div>
                                <div v-if="evaluacion.proceso >= 81" :class="setClass(evaluacion.proceso)">LÍDER</div>
                                <div :class="setClass(evaluacion.proceso)">{{ formatNumber(evaluacion.proceso) }}%</div>
                            </div>
                        </div>
                    </div>
                    <br>
                    <!-- R2 -->
                    <button v-if="!showInfo"
                        class="w-full text-center text-indigo-500 hover:bg-slate-300 hover:text-white"
                        @click="showInfo = !showInfo">Mostrar
                        información</button>
                    <button v-if="showInfo"
                        class="w-full text-center text-indigo-500 hover:bg-slate-300 hover:text-white"
                        @click="showInfo = !showInfo">Mostrar
                        menos</button>
                    <br>
                    <div class="grid grid-cols-1 sm:grid-cols-1 md:grid-cols-2 lg:grid-cols-3  gap-2">
                        <div class="border p-1 rounded">
                            <div class="bg-slate-500 text-white my-2 text-center rounded "> A GRAN NIVEL</div>
                            <Radar :evaluacion="evaluacion" />
                            <br>
                            <div v-if="showInfo" class="border p-1 rounded grid-cols-2 flex">
                                <div class="w-1/2">
                                    <p class="text-xs p-1 text-justify bg-red-800 text-white">
                                        INICAL.- La oportunidad es grande para mejorar, todo lo que hagas con un sistema
                                        de
                                        excelencia operacional dará un gran beneficio en tu organización.
                                    </p>
                                    <p class="text-xs p-1 text-justify bg-red-500 text-white">
                                        BASICO:Haz establecido los primeros pasos en el trabajo con mejora contina,
                                        estableciendo procesos y midiendo resultados, Ajustar tu sistema de gestión te
                                        vendría bien en este punto
                                    </p>
                                    <p class="text-xs p-1 text-justify bg-yellow-500 text-white">
                                        INTERMEDIO : Un nivel ideal para obtener buenos resultados de un sistema de
                                        gestión operado con herramientas de mejora continua como Lean o Six Sigma.
                                    </p>
                                    <p class="text-xs p-1 text-justify bg-green-500 text-white">
                                        AVANZADO :Momento de dar un brinco a la tecnología, si tus procesos ya son
                                        estables
                                        será el momento idóneo para comenzar a evaluar el fase 2 de un sistema de
                                        exclencia
                                        operacional
                                    </p>
                                    <p class="text-xs p-1 text-justify bg-blue-500 text-white">
                                        LÍDER : Eres un líder en tu ramo, usando todo tu potencial y listo para
                                        enfrentar
                                        los retos, evaluate en fase 2 de excelencia operacional, mejora de forma
                                        integrada
                                    </p>

                                </div>
                                <div class="w-1/2">
                                    <p class="text-xs p-1 text-justify">
                                        Nuestros niveles de calificación máxima representan las prácticas de
                                        excelencia
                                        adoptadas por miles de empresas en todo el mundo durante la Fase 1 de Excelencia
                                        Operacional. Esto indica que estas prácticas son el estándar mínimo que se debe
                                        lograr para garantizar que tu equipo pueda aumentar su productividad, entregar
                                        resultados de alta calidad y contribuir de manera más significativa al éxito
                                        global
                                        de la organización.
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="border p-1 rounded">
                            <div class="bg-slate-500 text-white my-2 text-center rounded ">LO QUE TE DUELE</div>
                            <Bar :evaluacion="evaluacion" />
                            <br>
                            <br>
                            <div v-if="showInfo" class="border p-1 rounded">
                                <p class="text-xs p-1 text-justify">
                                    Primero se presentan los resultados de la evaluación del sistema de gestión, ya que
                                    este
                                    es un componente crítico para la excelencia operacional. De hecho, gran parte de tu
                                    calificación general depende de la puntuación en este elemento, ya que es
                                    fundamental
                                    para desplegar todo el potencial de los demás elementos. A continuación, se muestran
                                    los
                                    elementos de mejora continua, seguidos del resto de los pilares hasta llegar a la
                                    base:
                                    el desarrollo y el aprendizaje.
                                </p>
                                <p class="text-xs p-1 text-justify">
                                    Si tus resultados se encuentran debajo del 40% es un nivel esperado en la mayor
                                    parte de
                                    empresas, si estás entre 40%-75% felicidades seguramente ya comenzaste con un
                                    programa
                                    pero aún hace falta reforzar algunas prácticas, si estas por encima del 75% ¡es
                                    increíble! estás con prácticas maduras y estás listo para involucrar nuevos
                                    conceptos
                                    para el nivel 2 de iPMS® o de cualquier modelo de excelencia operacional.
                                </p>
                                <p class="text-xs p-1 text-justify">
                                    Como notarás, todos los elementos evaluados son esenciales; todas las empresas y
                                    todos
                                    los equipos, independientemente de su tipo, los requieren. Este es el fundamento
                                    sobre
                                    el que se edifican las empresas. Como gerentes o líderes de organizaciones, nuestra
                                    responsabilidad es fomentar estos elementos para asegurar nuestro desarrollo.
                                </p>
                                <p class="text-xs p-1 text-justify">
                                    Nuestras recomendaciones generales son:
                                <ol class="list-decimal list-inside">
                                    <li>Establece un sistema de gestión realmente integrado.</li>
                                    <li>Capacita y certifica a tu personal</li>
                                    <li>Asegurate de generar estándares basados en plataformas tecnológicas, es el
                                        futuro.
                                    </li>
                                </ol>
                                </p>
                                <p class="text-xs p-1 text-justify">
                                    Te invitamos a contactar a Productivity Center® e invertir 20 minutos de tu tiempo
                                    para
                                    que te expliquemos de manera detallada el informe completo de tu autoevaluación el
                                    cual
                                    comprende 40 hojas. Te proporcionaremos consejos específicos para cada uno de los 25
                                    puntos e incluso algunos cursos gratuitos en nuestra plataforma de aprendizaje.
                                    Escribenos a contacto@productivity.center para solicitarlo.
                                </p>
                            </div>
                        </div>
                        <div class="border p-1 rounded">
                            <div class="bg-slate-500 text-white my-2 text-center rounded ">EN DONDE ESTÁS</div>
                            <Scatter :evaluacion="evaluacion" />
                            <br>
                            <div v-if="showInfo" class="border p-1 rounded">
                                <p class="text-xs p-1 text-justify">
                                    Este mapa te permite conocer tu nivel de madurez en prácticas de excelencia
                                    operacional
                                    respecto a otras empresas que han desarrollado el ejercicio.
                                </p>
                                <p class="text-xs p-1 text-justify">
                                    Los colores te demuestran el nivel general:
                                <ul>
                                    <li class="text-red-900">INICIAL.- Los procesos son inconsistentes y reactivos.</li>
                                    <li class="text-red-500">BÁSICO.- Los procesos clave están documentados y
                                        estandarizados, cultura aceptable.
                                    </li>
                                    <li class="text-yellow-500">INTERMEDIO.- Los procesos están optimizados y son
                                        impulsados
                                        por datos.</li>
                                    <li class="text-green-500">AVANZADO.- Monitoreo sistemático y mejora de las métricas
                                        clave.</li>
                                    <li class="text-blue-500">LÍDER.- Innovación continua y rendimiento líder en la
                                        industria.</li>
                                </ul>
                                </p>
                                <p class="text-xs p-1 text-justify">
                                    Las zonas te advierten 3 posibles comportamientos:
                                <ul>
                                    <li><strong>Zona A.-</strong> Procesos sólidos, los resultados se logran mediante
                                        procesos automatizados, pero en la mayoría de los casos con poco trabajo en
                                        equipo o
                                        un ambiente de equipo mejorable, alto riesgo de rotación y renuncias en la zona
                                        roja, posible zona de confort en el sector amarillo.
                                    </li>
                                    <li><strong>Zona B.-</strong> En camino hacia la mejora continua, organización
                                        equilibrada, uso y mejora de procesos alineados con el nivel de cultura. En esta
                                        zona, las posibilidades de lograr buenos avances en la excelencia operacional
                                        son
                                        altas.
                                    </li>
                                    <li><strong>Zona C.-</strong> Resultados a través de equipos con alta pasión, en la
                                        mayoría de los casos con poco seguimiento de procesos, organización más reactiva
                                        que
                                        planificada.
                                    </li>
                                </ul>
                                </p>
                                <p class="text-xs p-1 text-justify">
                                    La mejora basada en la autoevaluación que recién has realizado se convierte en un
                                    instrumento esencial para el crecimiento y desarrollo de tu organización. Cada
                                    resultado
                                    obtenido puede brindarte una perspectiva y reflexión clara sobre qué áreas requieren
                                    mejora. Sin embargo, la efectividad de las mejoras se potencia cuando estas se
                                    ejecutan
                                    dentro de un sistema integrado, en lugar de tratarse como proyectos independientes.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>
