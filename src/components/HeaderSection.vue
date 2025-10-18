<script setup>

import mainPic from '../assets/introductionSection/main_Pic.png' 
</script>

<template>
  <div class='header'>
    <img :src="mainPic" alt="main_header_pic"></img>
  </div>
</template>

<style scoped>
.header {
    width: auto;
    height: auto;
    color: black;
    cursor: pointer;
}

.header img {
    width: 100%;
    height: auto;
    object-fit: contain;
}


</style>