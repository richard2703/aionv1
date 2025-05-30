<script setup>
defineProps({
    visible: {
        type: Boolean,
        default: false
    }
});

</script>

<template>
    <div v-if="visible">
        <slot></slot>
    </div>
</template>
