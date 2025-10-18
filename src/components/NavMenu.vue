<script setup>
    import ComponentButton from './ComponentButton.vue';
    import logo_JobFair from '../assets/introductionSection/logo_JobFair.jpg'; 
    import arrowNext from '../assets/introductionSection/arrow-next-small.svg';
</script>

<template>
  <nav class="navbar">
    <div class="nav-container">
      <div class="logo">
        <img :src="logo_JobFair" alt="Company_Logo" />
      </div>
      <div class="nav-links">
        <ComponentButton :isExhibitor="false">
        HOME
        <span class="arrowDiv"> 
            <img :src="arrowNext" alt="arrow-next-small"/>
        </span>
        </ComponentButton>
        <ComponentButton :isExhibitor="false">
        CONTACT US
        <span class="arrowDiv"> 
            <img :src="arrowNext" alt="arrow-next-small"/>
        </span>
        </ComponentButton>
        <ComponentButton :isExhibitor="true">
        BE OUR EXHIBITOR
        </ComponentButton>
      </div>
    </div>
  </nav>
</template>



<style scoped>
.navbar {
    width: auto;
    background-color: white;
    padding: 16px 24px;
}

.nav-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.nav-links {
    display: flex;
    gap: 16px;
}

.arrowDiv {
    display: flex;
    align-items: center;
}

.arrowDiv img{
    height: 1rem;      
    width: auto;      
    object-fit: contain;
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

</style>