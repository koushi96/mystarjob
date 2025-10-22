<script setup>

import findTheRightTalent from '../assets/earlyBird/findTheRightTalent.png' 
import earlyBird from '../assets/earlyBird/earlyBird_img.png' 
</script>

<template>
  <div class='header'>
    <div class='leftSide'>
        <img :src="findTheRightTalent" alt="findTheRightTalent" />
    </div>
    <div class='rightSide'>
        <img :src="earlyBird" alt="earlyBird" />
    </div>
    
  </div>
</template>

<style scoped>
.header {
    width: auto;
    height: auto;
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items:center;
}

.leftSide {
    width: 50%;
    height: auto;
}

.leftSide img {
    width: 60%;
    height: auto;
    object-fit: contain;
}

.rightSide {
    width: 50%;
    height: auto;
}

.rightSide img {
    width: 60%;
    height: auto;
    object-fit: contain;
}


</style>