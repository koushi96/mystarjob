<script setup>
  import { resolveAsset } from '../common/commonFunctions.ts'
  import data from '../common/data.json';
</script>

<template>
  <div class='header'>
    <img :src="resolveAsset(data.headerSection.mainPicUrl)" alt="main_header_pic"></img>
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