<script setup>
import { Head, Link, useForm } from '@inertiajs/vue3';
import Layout from '@/Layouts/Layout.vue';
import PrimaryButton from '@/Components/PrimaryButton.vue';
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";


// import as component
import Badge from 'primevue/badge';
import OverlayBadge from 'primevue/overlaybadge';
import Button from 'primevue/button';
import { ref } from 'vue';

const badge = ref('1');

const form = useForm({
    nombre: "",
    descripcion: "",
});
const submit = () => {
    form.post(route("area.store"), {
        onFinish: () => form.reset(),
    });
};

const title = "dashboard";  // Aquí asegúrate de que esto coincida con el valor que esperas en MainMenu
const subTitle = "subTitle2"; // Este segundo es por siu viene de un menu desplegable en MainMenu

</script>

<template>
    <Layout :titulo="title" :subTitulo="subTitle">

        <Head title="Dashboard" />
        <div class=" overflow-hidden sm:rounded-lg">
            <div class="breadcrumbsTitulo px-1">
                <h3>Dashboard</h3>
            </div>
            <div class="breadcrumbs flex ">
                <Link :href="route('dashboard')" class="px-1">
                <h3>Dashboard -</h3>
                </Link>
                <Link class="active">
                <h3>Test</h3>
                </Link>
            </div>
        </div>

        <div class="py-2">
            <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
                <div>
                    <div class="px-4 py-2 flex justify-end bg-white border-b border-gray-200">
                        <PrimaryButton>Nuevo</PrimaryButton>
                    </div>
                    <div class="px-4 py-2 flex justify-end bg-white border-b border-gray-200">
                        <PrimaryButton :href="route('mailer.sendMailWithAttachment')">Enviar</PrimaryButton>
                    </div>
                    <div class="px-4 py-2 bg-white border-b border-gray-200">

                        <div class="container mx-auto">
                            <form @submit.prevent="submit">
                                <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-2 gap-4">
                                    <div>
                                        <InputLabel for="name" value="Nombre: " />
                                        <TextInput id="name" v-model="form.nombre" type="text" class="mt-1 block w-full"
                                            required autofocus autocomplete="name" />
                                    </div>

                                    <div>
                                        <InputLabel for="area_id" value="Area: " />
                                        <select ref="select"
                                            class="border-gray-300 focus:border-indigo-500 focus:ring-indigo-500 rounded-md shadow-sm w-full px-3 py-2 cursor-pointer"
                                            v-model="form.area_id" required>
                                            <option value="" disabled selected>
                                                Seleccione una opcion
                                            </option>
                                            <option v-for="area in areas" :key="area.id" :value="area.id">
                                                {{ area.nombre }}
                                            </option>
                                        </select>
                                    </div>

                                    <div>
                                        <InputLabel for="descripcion" value="Descripcion:" />
                                        <TextInput id="descripcion" v-model="form.descripcion" type="text"
                                            class="mt-1 block w-full" required autocomplete="descripcion" />
                                    </div>

                                    <div class="col-span-full flex items-center justify-end mt-4">
                                        <PrimaryButton class="ms-4" :class="{ 'opacity-25': form.processing }"
                                            :disabled="form.processing">
                                            Guardar
                                        </PrimaryButton>
                                    </div>
                                </div>
                            </form>
                        </div>

                        <hr>

                        <div class="px-4 py-2 bg-white border-gray-200">

                            <div class="card flex justify-center">
                                <Badge value="2"></Badge>
                            </div>
                            <br>
                            <div class="card flex flex-wrap justify-center gap-2">
                                <Badge value="2"></Badge>
                                <Badge value="6" severity="secondary"></Badge>
                                <Badge value="8" severity="success"></Badge>
                                <Badge value="4" severity="info"></Badge>
                                <Badge value="9" severity="warn"></Badge>
                                <Badge value="3" severity="danger"></Badge>
                                <Badge value="5" severity="contrast"></Badge>
                            </div>
                            <br>
                            <div class="card flex flex-wrap justify-center items-end gap-2">
                                <Badge value="8" size="xlarge" severity="success"></Badge>
                                <Badge value="6" size="large" severity="warn"></Badge>
                                <Badge value="4" severity="info"></Badge>
                                <Badge value="2" size="small"></Badge>
                            </div>
                            <br>
                            <div class="card flex flex-wrap justify-center gap-6">
                                <OverlayBadge value="2">
                                    <i className="pi pi-bell" />
                                </OverlayBadge>
                                <OverlayBadge value="4" severity="danger">
                                    <i className="pi pi-calendar" />
                                </OverlayBadge>
                                <OverlayBadge severity="danger">
                                    <i className="pi pi-envelope" badge="2" />
                                </OverlayBadge>
                            </div>


                            <br>
                            <div class="card flex justify-center flex-wrap gap-4">
                                <Button type="button" icon="pi pi-bell" severity="contrast" :badge="badge" link />
                                <Button type="button" icon="pi pi-bell" :badge="badge" severity="contrast" />
                            </div>
                            <br>
                            <div class="card flex flex-wrap justify-center">
                                <!-- <Badge value="3" severity="danger"></Badge> -->
                            </div>

                            <div class="relative m-6 inline-flex w-fit">
                                <div
                                    class="absolute bottom-auto left-auto right-0 top-0 z-10 inline-block -translate-y-1/2 translate-x-2/4 rotate-0 skew-x-0 skew-y-0 scale-x-100 scale-y-100 rounded-full bg-red-600 p-2.5 text-xs">
                                </div>
                                <div
                                    class="flex items-center justify-center rounded-lg bg-primary-500 px-8 py-6 text-center text-white shadow-lg dark:text-gray-200">
                                    <span class="[&>svg]:h-10 [&>svg]:w-10">
                                        <i class="pi pi-bell text-red-500" style="font-size: 2rem" />
                                    </span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <iframe title="KPI AION" class="w-full" width="100%" height="541.25"
                        src="https://app.powerbi.com/reportEmbed?reportId=179bf37c-7e0d-4b16-8efb-1dd0d892b9d3&autoAuth=true&ctid=10cd56f7-ad91-4efa-afeb-28102e28951c"
                        frameborder="0" allowFullScreen="true">
                    </iframe>
                </div>
            </div>
        </div>
    </Layout>
</template>
