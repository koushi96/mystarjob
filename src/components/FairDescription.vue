<script setup>
</script>


<template>
    <div class="titleDiv">
        <h3 class='title'>{{ $t('fairDescription.title') }}</h3>
        <p class='desc'>{{ $t('fairDescription.description') }}</p>
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
    font-size: 3.5rem;
    font-height: 4rem;
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

@media (max-width: 767px) {
    .title {
        font-size:2rem;
        font-height: 2.5rem;
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
        text-align: start;
    }
}
</style>