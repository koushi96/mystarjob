<script setup>
    import { resolveAsset } from '../common/commonFunctions.ts'
    import data from '../common/data.json';

    const images = import.meta.glob('../assets/upcomingFair/*.{jpg,jpeg,png,webp}', { eager: true });
    const imageList = Object.values(images).map(i => i.default);

    let upcomingFairDetails = data.upcomingFair.upcomingFairDetails;
</script>


<template>
    <div class="titleDiv">
        <h3 class='title'>{{ $t('upcomingFair.mainTitle') }}</h3>
    </div>
    <div class="cardDiv">
        <div class="card"  v-for="(fair, index) in $tm('upcomingFair.upcomingFairDetails')" :key="index">
            <h4>{{ fair.city }}</h4>
            <h6>{{ fair.area }}</h6>
            <p>{{ fair.venue }}</p>
            <h6>{{ fair.date }}</h6>

            <div class="overlappingCity">
                <img :src="resolveAsset(fair.image)" :alt="`${fair.city} Silhouette`" />
            </div>
        </div>
    </div>
</template>


<style scoped>
.titleDiv {
    width: auto;
    height: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 2rem;
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

.cardDiv{
    width: auto;
    height: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    gap : 24px
}

.card {
  position: relative;
  background-color: #367588;
  color: white;
  width: 15rem;
  height: 20rem;
  border-radius: 20px;
  display: flex;
  flex-direction: column;
  justify-content: flex-start;
  align-items: flex-start;
  padding: 1.5rem;
  overflow: visible; 
}

.overlappingCity {
  position: absolute;
  bottom: 0;
  left: -2.5% ; 
  width: 105% ; 
  height: 6rem;
  pointer-events: none;
  z-index: 0;
}

.overlappingCity img {
  width: 100%;
  height: 100%;
  object-fit: cover;
  opacity: 0.3; 
}

.card h4 {
    font-size: 2.5rem;
    margin-top: 0;
    margin-bottom: 0;
    text-align: start;
}

.card h6 {
    font-size: 1.8rem;
    margin-top: 0;
    margin-bottom: 0;
    text-align: start;
}

.card p {
    font-size: 1.2rem;
    margin-top: 0;
    margin-bottom: 0;
    text-align: start;
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

