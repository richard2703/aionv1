<script setup>
import { onMounted, computed } from "vue";
import { Head, Link } from "@inertiajs/vue3";
import Layout from "@/Layouts/Layout.vue";

const props = defineProps({});

onMounted(() => {});
</script>

<template>
    <Layout :titulo="title">
        <Head title="Terminos" />
        <div class="overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Terminos y Condiciones</h3>
            </div>
            <div class="breadcrumbs flex">
                <Link :href="route('dashboard')" class="px-1">
                    <h3>Home -</h3>
                </Link>
                <Link class="active">
                    <h3>Terminos y Condiciones</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="max-w-7xl mx-auto sm:px-6 lg:px-8">
                <div class="bg-white overflow-hidden shadow-sm sm:rounded-lg">
                    <div class="p-6 bg-white border-b border-gray-200">
                        <!-- <iframe src="/pdfs/terminos_condiciones.pdf" width="100%" height="800px"></iframe> -->

                        <h1>TÉRMINOS Y CONDICIONES DE USO</h1>
                        <p><strong>Última actualización:</strong> [Fecha]</p>
                        <p>
                            Bienvenido a <strong>AION Business</strong>. Al
                            acceder y utilizar nuestra plataforma, usted acepta
                            cumplir con los siguientes términos y condiciones.
                            Si no está de acuerdo con ellos, le recomendamos que
                            no utilice el servicio.
                        </p>

                        <h2>1. DEFINICIONES</h2>
                        <ul>
                            <li>
                                <strong>"Plataforma"</strong>: Se refiere al
                                sistema web <strong>AION Business</strong>.
                            </li>
                            <li>
                                <strong>"Usuario"</strong>: Persona o entidad
                                que accede y utiliza la plataforma.
                            </li>
                            <li>
                                <strong>"Servicio"</strong>: Funcionalidades y
                                herramientas proporcionadas por
                                <strong>AION Business</strong>.
                            </li>
                        </ul>

                        <h2>2. USO DE LA PLATAFORMA</h2>
                        <p>
                            <strong>2.1. Requisitos:</strong> Para utilizar
                            <strong>AION Business</strong>, el usuario debe
                            registrarse con información válida y mantenerla
                            actualizada.
                        </p>
                        <p>
                            <strong>2.2. Uso Adecuado:</strong> Se prohíbe el
                            uso de la plataforma para actividades ilegales,
                            fraudulentas o que vulneren derechos de terceros.
                        </p>
                        <p>
                            <strong>2.3. Disponibilidad:</strong>
                            <strong>AION Business</strong> no garantiza que el
                            servicio estará disponible en todo momento y se
                            reserva el derecho de interrumpirlo por
                            mantenimiento o actualizaciones.
                        </p>

                        <h2>3. REGISTRO Y CUENTAS</h2>
                        <p>
                            <strong>3.1. Responsabilidad del Usuario:</strong>
                            El usuario es responsable de mantener la
                            confidencialidad de sus credenciales de acceso.
                        </p>
                        <p>
                            <strong>3.2. Suspensión de Cuentas:</strong>
                            <strong>AION Business</strong> se reserva el derecho
                            de suspender o eliminar cuentas que infrinjan estos
                            términos.
                        </p>

                        <h2>4. PRIVACIDAD Y DATOS PERSONALES</h2>
                        <p>
                            <strong>4.1. Protección de Datos:</strong> La
                            recopilación y tratamiento de datos personales se
                            rige por nuestra
                            <strong>Política de Privacidad</strong>.
                        </p>
                        <p>
                            <strong>4.2. Uso de Información:</strong> No
                            compartiremos datos personales con terceros sin el
                            consentimiento del usuario, salvo requerimiento
                            legal.
                        </p>

                        <h2>5. PROPIEDAD INTELECTUAL</h2>
                        <p>
                            <strong>5.1. Derechos de Autor:</strong> Todos los
                            derechos sobre el contenido de la plataforma
                            pertenecen a <strong>AION Business</strong> o a sus
                            respectivos propietarios.
                        </p>
                        <p>
                            <strong>5.2. Restricciones:</strong> No está
                            permitido copiar, modificar o distribuir contenido
                            sin autorización expresa.
                        </p>

                        <h2>6. LIMITACIÓN DE RESPONSABILIDAD</h2>
                        <p>
                            <strong>6.1. Sin Garantías:</strong>
                            <strong>AION Business</strong> se proporciona "tal
                            cual", sin garantías de ningún tipo.
                        </p>
                        <p>
                            <strong>6.2. Daños y Perjuicios:</strong> No nos
                            hacemos responsables por daños directos o indirectos
                            derivados del uso de la plataforma.
                        </p>

                        <h2>7. MODIFICACIONES Y TERMINACIÓN</h2>
                        <p>
                            <strong>7.1. Actualizaciones:</strong> Nos
                            reservamos el derecho de modificar estos términos en
                            cualquier momento.
                        </p>
                        <p>
                            <strong>7.2. Terminación del Servicio:</strong>
                            Podemos suspender el acceso a la plataforma sin
                            previo aviso en caso de incumplimiento.
                        </p>

                        <h2>8. LEGISLACIÓN APLICABLE</h2>
                        <p>
                            Estos términos se rigen por las leyes del país en el
                            que opera <strong>AION Business</strong>. Cualquier
                            disputa será resuelta ante los tribunales
                            competentes.
                        </p>

                        <p>
                            Si tiene alguna pregunta sobre estos términos, puede
                            contactarnos a través de [correo electrónico o
                            contacto].
                        </p>

                        <p>
                            Gracias por utilizar <strong>AION Business</strong>.
                            Estamos comprometidos con la excelencia y la calidad
                            de nuestros servicios.
                        </p>
                    </div>
                    <div
                        class="p-6 bg-white border-b border-gray-200 flex justify-end"
                    >
                        <label for="aceptar"
                            >He leído y acepto los términos y condiciones de uso
                            de la plataforma</label
                        >
                        <input class="m-2" type="checkbox" id="aceptar" />
                    </div>
                </div>
            </div>
        </div>
    </Layout>
</template>

<style></style>
