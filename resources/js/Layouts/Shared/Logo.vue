<template>

    <img :src="logo_path" alt="Logo" />
</template>

<script setup>
import { ref, onMounted } from "vue";

onMounted(() => {
    getItem();
});

const item = ref({});
const logo_path = ref();

const props = defineProps({
    item: Object || null,
});

const getItem = () => {
    axios
        .get("/api/config-dashboard")
        .then((response) => {
            item.value = response.data;
            logo_path.value = item.value[0].logo_path;
        })
        .catch((error) => {
            console.error('Error fetching item:', error);
        });
};

</script>
