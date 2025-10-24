<script setup>
  import ComponentButton from './ComponentButton.vue';
  import { resolveAsset } from '../common/commonFunctions.ts'
  import data from '../common/data.json';
</script>

<template>
  <nav class="navbar">
    <div class="nav-container">
      <div class="logo">
        <img :src="resolveAsset(data.navMenue.logoJobFairUrl)" alt="Company_Logo" />
      </div>
      <div class="nav-links">
        <ComponentButton :isExhibitor="false" :to="data.navMenue.homeButtonUrl">
          {{data.navMenue.homeButton}}
          <span class="arrowDiv">
            <img :src="resolveAsset(data.navMenue.arrowNextSvg)" alt="arrow-next-small"/>
          </span>
        </ComponentButton>

        <ComponentButton :isExhibitor="false" :to="data.navMenue.contactUsUrl">
          {{data.navMenue.contactUsButton}}
          <span class="arrowDiv">
            <img :src="resolveAsset(data.navMenue.arrowNextSvg)" alt="arrow-next-small"/>
          </span>
        </ComponentButton>

        <ComponentButton :isExhibitor="true" :to="data.navMenue.beOurExhibitorUrl">
          {{data.navMenue.beOurExhibitorButton}}
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