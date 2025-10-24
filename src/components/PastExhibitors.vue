<script setup>
    const images = import.meta.glob('../assets/pastExhibitors/*.{jpg,jpeg,png,webp}', { eager: true });
    const imageList = Object.values(images).map(i => i.default);
</script>


<template>
    <div class="titleDiv">
        <h3 class='title'>{{ $t('pastExhibitors.mainTitle') }}</h3>
        <div class="gallery">
            <img v-for="(img, index) in imageList" :key="index" :src="img" alt="Past Exhibitor" />
        </div>
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

.gallery {
    width: auto;
    display: flex;
    flex-wrap: wrap;
    gap: 2rem 6rem; 
    justify-content: start;
    margin-bottom: 64px;
}

.gallery img {
    height: 55px;
    width: auto;
    object-fit: contain;
}


</style>