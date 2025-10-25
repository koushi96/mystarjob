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
    font-size: 3.5rem;
    font-height: 4rem;
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

@media (max-width: 767px) {
    .title {
        font-size:2rem;
        font-height: 2.5rem;
    }

    .gallery {
        gap: 2rem 1rem; 
    }

    .gallery img {
        height: 2.25rem;
        width: auto;
        object-fit: contain;
    }
}


</style>