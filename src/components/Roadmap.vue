<script setup>
    import { resolveAsset } from '../common/commonFunctions.ts'
    import data from '../common/data.json';
</script>

<template>
  <div class='header'>
    <div class="mainLayout">
        <div class="titleDiv">
            <h3 class='title'>{{ $t('roadMap.mainTitle') }}</h3>
        </div>
        <div class="logo">
            <img :src="resolveAsset(data.roadMap.logoJobFairUrl)" alt="Company_Logo" />
        </div>
        
    </div>
    
    <div>
       <img :src="resolveAsset(data.roadMap.roadmapPicUrl)" alt="roadmap_pic"></img> 
    </div>
  </div>
</template>

<style scoped>
.header {
    width: auto;
    height: auto;
}

.mainLayout {
    width: 100%;
    height: auto;
    display: flex;
    justify-content: center;
    align-items: center;
}

.titleDiv {
    width: 60%;
    height: auto;
    display: flex;
    flex-direction: row;
    justify-content: start;
    align-items: center;
}

.logo {
    display: flex;
    align-items: center;
}

.logo img {
    height: 4rem;      
    width: auto;      
    object-fit: contain;
}

.title {
    color: black;
    border: none;
    font-size: 4rem;
    font-height: 5rem;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 36px;
}

.header img {
    width: 100%;
    height: auto;
    object-fit: contain;
}


</style>