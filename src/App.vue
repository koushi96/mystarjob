<script setup>
import NavMenu from './components/NavMenu.vue';
import HeaderSection from './components/HeaderSection.vue';
import FairDescription from './components/FairDescription.vue';
import PastExhibitors from './components/PastExhibitors.vue';
import FairImages from './components/FairImages.vue';
import UpcomingFair from './components/UpcomingFair.vue';
import ExhibitionHallLayout from './components/ExhibitionHallLayout.vue';
import JobMatching from './components/JobMatching.vue';
</script>

<template >
  <div>
    <NavMenu></NavMenu>
    <HeaderSection></HeaderSection>
    <FairDescription></FairDescription>
    <PastExhibitors></PastExhibitors>
    <FairImages></FairImages>
    <UpcomingFair></UpcomingFair>
    <ExhibitionHallLayout></ExhibitionHallLayout>
    <JobMatching></JobMatching>
    
  </div>
</template>



