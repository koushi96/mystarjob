
<script setup>
import NavMenu from '../components/NavMenu.vue';
import HeaderSection from '../components/HeaderSection.vue';
import FairDescription from '../components/FairDescription.vue';
import PastExhibitors from '../components/PastExhibitors.vue';
import FairImages from '../components/FairImages.vue';
import UpcomingFair from '../components/UpcomingFair.vue';
import ExhibitionHallLayout from '../components/ExhibitionHallLayout.vue';
import JobMatching from '../components/JobMatching.vue';
import EarlyBird from '../components/EarlyBird.vue';
import Roadmap from '../components/Roadmap.vue';
import ContactUs from '../components/ContactUs.vue';
import LiveCountdown from '../components/LiveCountdown.vue';
import Chatbot from '../components/Chatbot.vue';
</script>


<template>
  <div id="app">
    <NavMenu />
    <HeaderSection />
    <FairDescription />
    <PastExhibitors />
    <FairImages />
    <UpcomingFair />
    <ExhibitionHallLayout />
    <JobMatching />
    <EarlyBird />
    <Roadmap />
    <LiveCountdown />
    <ContactUs />
    <Chatbot/>
  </div>
</template>

<style scoped>
  #app {
    max-width: 100vw;
    margin-right: 5rem;
    margin-left: 5rem;
  }

  /* Tablet view (≤1024px) */
  @media (max-width: 1024px) {
    #app {
      margin-right: 2rem;
      margin-left: 2rem;
    }
  }

  /* Mobile view (≤768px) */
  @media (max-width: 768px) {
    #app {
      margin-right: 1rem;
      margin-left: 1rem;
    }
  }
</style>
