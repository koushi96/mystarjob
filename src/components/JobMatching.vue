<script setup>
import jobMatching_img from '../assets/jobMatching/jobMatching_img.png';
import freeAdmissionGift from '../assets/jobMatching/freeAdmissionGift.jpg';
import earlyBird_img from '../assets/jobMatching/earlyBird_img.png';
import ComponentButton from './ComponentButton.vue';

const jobMatchingDesc = "Each session will have 12 recruiters and up to 24 jobseekers. Each discussion will be 2 minutes. Jobseekers will move to the next recruiter when time is up. The recruiter remains at their place. A lucky draw for the jobseekers will be done at the end of the session.";

const careerTalkSessionList = [
  {
    day: "1",
    date: "24 May 2025, Saturday",
    list: [
      { company: "Perkeso", time: "10-11am" },
      { company: "Allianz", time: "11-12pm" },
      { company: "Aonic", time: "2-3pm" },
      { company: "Aat", time: "3-4pm" },
      { company: "Babas", time: "4-5pm" },
      { company: "LYC Healthcare", time: "5-6pm" },
    ],
  },
  {
    day: "2",
    date: "25 May 2025, Sunday",
    list: [
      { company: "Public Bank", time: "10-11am" },
      { company: "Seatrium", time: "11-12pm" },
      { company: "Setel", time: "2-3pm" },
      { company: "MYFutureJobs", time: "3-4pm" },
      { company: "GreatEastern", time: "4-5pm" },
      { company: "Hong Leong Assurance", time: "5-6pm" },
    ],
  },
];

function chunkArray(arr, chunkSize) {
  const result = [];
  for (let i = 0; i < arr.length; i += chunkSize) {
    result.push(arr.slice(i, i + chunkSize));
  }
  return result;
}
</script>

<template>
  <div class="titleDiv">
    <div class="bodyContainer">
        <div class="jobMatchingDiv">
        <img :src="jobMatching_img" alt="jobMatching_img" />
        <div class="jobMatchingDesc">
            <p>{{ jobMatchingDesc }}</p>
        </div>
        </div>

        <!-- Loop through each day/session -->
        <div v-for="(session, index) in careerTalkSessionList" :key="index" class="slotDiv">
        
        <!-- Insert divider between Day 1 and Day 2 -->
        <div v-if="index === 1" class="dayDivider">
            <h1 class="dividerTitle">Career Talk Session</h1>
        </div>

        <div class="eachDayDiv">
            <p>Day {{ session.day }} - {{ session.date }}</p>

            <!-- Chunk list into rows of 3 -->
            <div 
            v-for="(group, groupIndex) in chunkArray(session.list, 3)" 
            :key="groupIndex" 
            class="eachCompanyRow"
            >
            <div 
                v-for="(item, idx) in group" 
                :key="idx" 
                class="eachCompanyCard"
            >
                {{ item.company }} <br /> {{ item.time }}
            </div>
            </div>
        </div>
        </div>

        <div>
            <ComponentButton 
                :isExhibitor="true"
            >
                BE OUR VISITOR
            </ComponentButton>
        </div>

        <div class='freeAdmissionDiv'>
            <div class='freeAdmissionImgDiv'>
                <img :src='freeAdmissionGift' alt='freeAdmissionGift' />
            </div>
            
        </div>
    </div>
  </div>
</template>

<style scoped>
.titleDiv {
    width: 100vw;
    height: auto;
    border-top: 3px solid black;
    margin-left: -5rem;
    color: white;
    background: linear-gradient(to bottom,
            purple 0%,
            #00308F 80%,
            #00308F 96%,
            white 100%);
}

.bodyContainer {
    max-width: 100vw;
    height: auto;
    margin-right: 7rem;
    margin-left: 7rem;
    text-align: center;
    overflow-x: hidden;
    overflow-y: auto;
}

.jobMatchingDiv {
    width: 100%;
    display: flex;
    flex-direction: row;
    justify-content: start;
    align-items: center;
    text-align: center;
    margin: 5rem 0 5rem;
}

.jobMatchingDiv img {
    height: 35rem;
    width: auto;
}

.jobMatchingDesc {
    margin-left: 5%;
    width: 30%;
    height: auto;
}

.jobMatchingDesc p {
    font-size: 24px;
    font-weight: 400;
    line-height: 32px;
}

.slotDiv {
    padding: 1rem 2rem;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
}

.eachDayDiv {
    padding: 1rem;
    border-radius: 8px;
    width: 100%;
    height: auto;
}

.eachDayDiv p {
    margin: 0 0 2rem;
    width: 100%;
    height: 30px;
    border-radius: 24px;
    font-size: 20px;
    font-weight: 400;
}

.eachCompanyRow {
    display: flex;
    justify-content: center;
    gap: 4rem;
    margin-bottom: 1rem;
}

.eachCompanyCard {
    background-color: #F4C2C2;
    width: 25%;
    min-width: 200px;
    height: 5rem;
    border-radius: 24px;
    font-size: 1.2rem;
    display: flex;
    justify-content: center;
    align-items: center;
    text-align: center;
    padding: 0.5rem;
    color: black;
    font-weight: 500;
    transition: transform 0.3s ease;
}

.eachCompanyCard:hover {
    transform: scale(1.2);
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
} 

.dayDivider {
    margin: 0rem 0 2rem;
    display: flex;
    justify-content: center;
}

.dividerTitle {
    font-size: 2rem;
    font-weight: bold;
    text-align: center;
    color: #fff;
}

.freeAdmissionDiv {
    width: 100%;
    height: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 64px 0 64px;
}

.freeAdmissionImgDiv {
    width: auto;
    height: 260px;
    background-color: red;
    display: flex;
    justify-content: center;
    align-items: center;
}

.freeAdmissionImgDiv img{
    height: 250px;
    width: auto;
    object-fit: contain;
}
</style>