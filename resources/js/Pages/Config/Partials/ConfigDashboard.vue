<script setup>
import { ref, onMounted } from "vue";
import { useForm } from "@inertiajs/vue3";
import axios from "axios";
import InputLabel from "@/Components/InputLabel.vue";
import TextInput from "@/Components/TextInput.vue";
import PrimaryButton from "@/Components/PrimaryButton.vue";

const props = defineProps({
    item: Object || null,
});

const item = ref(props.item);
const banner_path = ref();
const logo_path = ref();

const form = useForm({
    proposito: item.value?.proposito || "",
    slogan: item.value?.slogan || "",
    actuacion: item.value?.actuacion || "",
    logo: null,
    banner: null,
    nombre_negocio: item.value?.nombre_negocio || "",
});

const isUpdating = ref(false);

const getItem = () => {
    axios
        .get("/api/config-dashboard")
        .then((response) => {
            item.value = response.data;
            form.proposito = item.value[0].proposito;
            form.slogan = item.value[0].slogan;
            form.actuacion = item.value[0].actuacion;
            form.nombre_negocio = item.value[0].nombre_negocio;
            logo_path.value = item.value[0].logo_path;
            banner_path.value = item.value[0].banner_path;

            ({
                logo_path: logo_path.value[0],
                banner_path: banner_path.value[0],
            });
            console.log("item", item.value);
        })
        .catch((error) => {
            console.error("Error fetching item:", error);
        });
};

// Function to handle file input change and update form data
const onFileChange = (key, event) => {
    form[key] = event.target.files[0];
};

onMounted(() => {
    getItem(); // Fetch item data
});

const submit = async () => {
    const formData = new FormData();
    formData.append("proposito", form.proposito);
    formData.append("slogan", form.slogan);
    formData.append("actuacion", form.actuacion);
    formData.append("logo", form.logo);
    formData.append("banner", form.banner);
    formData.append("nombre_negocio", form.nombre_negocio);
    try {
        let response;
        if (item.value[0].id) {
            // Update existing item
            response = await axios.post(
                `/dashboard/${item.value[0].id}/update`,
                formData,
                {
                    headers: {
                        "Content-Type": "multipart/form-data",
                    },
                }
            );
        } else {
            // Create new item
            response = await axios.post("/dashboard/store", formData, {
                headers: {
                    "Content-Type": "multipart/form-data",
                },
            });
        }
        getItem();
        // Optionally reset form state after successful submission
        // form.reset();
    } catch (error) {
        if (error.response) {
            console.error("Error response:", error.response.data);
            // Handle validation errors or other errors from backend
        } else {
            console.error("Error submitting form:", error);
        }
    }
};
</script>

<template>
    <div class="py-2">
        <div class="bg-white overflow-hidden shadow-xl sm:rounded-lg">
            <div class="px-4 py-2 bg-white border-b border-gray-200">
                <div class="container mx-auto">
                    <h2 class="text-center text-2xl">Dashboard</h2>
                    <form
                        @submit.prevent="submit"
                        enctype="multipart/form-data"
                    >
                        <div class="grid grid-cols-1 gap-4">
                            <div>
                                <InputLabel
                                    for="nombre_negocio"
                                    value="Identidad del negocio: "
                                />
                                <TextInput
                                    id="nombre_negocio"
                                    v-model="form.nombre_negocio"
                                    type="text"
                                    class="mt-1 block w-full"
                                    required
                                    autofocus
                                    autocomplete="nombre_negocio"
                                />
                            </div>
                            <div>
                                <InputLabel
                                    for="proposito"
                                    value="Propósito: "
                                />
                                <TextInput
                                    id="proposito"
                                    v-model="form.proposito"
                                    type="text"
                                    class="mt-1 block w-full"
                                    required
                                    autofocus
                                    autocomplete="proposito"
                                />
                            </div>
                            <div>
                                <InputLabel for="slogan" value="Slogan: " />
                                <TextInput
                                    id="slogan"
                                    v-model="form.slogan"
                                    type="text"
                                    class="mt-1 block w-full"
                                    required
                                    autofocus
                                    autocomplete="slogan"
                                />
                            </div>
                            <div>
                                <InputLabel
                                    for="actuacion"
                                    value="Principios de actuacion: "
                                />
                                <TextInput
                                    id="actuacion"
                                    v-model="form.actuacion"
                                    type="text"
                                    class="mt-1 block w-full"
                                    required
                                    autofocus
                                    autocomplete="actuacion"
                                />
                            </div>

                            <div>
                                <InputLabel for="logo" value="Logo: " />
                                <input
                                    id="logo"
                                    type="file"
                                    @change="onFileChange('logo', $event)"
                                    class="mt-1 block w-full"
                                    autocomplete="logo"
                                />
                                <img
                                    class="w-40"
                                    :src="logo_path"
                                    alt="Logo actual"
                                    srcset=""
                                />
                            </div>

                            <div>
                                <InputLabel for="banner" value="Banner: " />
                                <input
                                    id="banner"
                                    type="file"
                                    @change="onFileChange('banner', $event)"
                                    class="mt-1 block w-full"
                                    autocomplete="banner"
                                />
                                <img
                                    class="w-40"
                                    :src="banner_path"
                                    alt="Banner actual"
                                    srcset=""
                                />
                            </div>

                            <div
                                class="col-span-full flex items-center justify-end mt-4"
                            >
                                <PrimaryButton
                                    class="ms-4 pi pi-save"
                                    :class="{
                                        'opacity-25': form.processing,
                                    }"
                                    :disabled="form.processing"
                                >
                                    <span
                                        class="p-1"
                                        :style="{
                                            fontSize: '10px',
                                        }"
                                    >
                                        Guardar</span
                                    >
                                </PrimaryButton>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</template>
