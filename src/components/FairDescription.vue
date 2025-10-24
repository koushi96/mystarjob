<script setup>
    import data from '../common/data.json';
</script>


<template>
    <div class="titleDiv">
        <h3 class='title'>{{data.fairDescription.title}}</h3>
        <p class='desc'>{{data.fairDescription.description}}</p>
    </div>
</template>


<style scoped>
.titleDiv {
    width: auto;
    height: auto;
}

.title {
    color: black;
    border: none;
    font-size: 4rem;
    font-height: 5rem;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 0;
}

.desc {
    color: black;
    border: none;
    font-size: 1rem;
    font-height: 1.5rem;
    font-weight: 500;
    display: flex;
    justify-content: center;
    align-items: center;
    align-self: center;
}
</style>