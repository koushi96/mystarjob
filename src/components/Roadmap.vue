<script setup>
import logo_JobFair from '../assets/introductionSection/logo_JobFair.jpg'; 
import roadmap_pic from '../assets/roadMap/roadmap_pic.jpg' 
</script>

<template>
  <div class='header'>
    <div class="mainLayout">
        <div class="titleDiv">
            <h3 class='title'>myStarJob Fair 2025 Roadmap</h3>
        </div>
        <div class="logo">
            <img :src="logo_JobFair" alt="Company_Logo" />
        </div>
        
    </div>
    
    
    <div>
       <img :src="roadmap_pic" alt="roadmap_pic"></img> 
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