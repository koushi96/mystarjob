<script setup>
  import { ref, onMounted, computed  } from 'vue';
  import ComponentButton from './ComponentButton.vue';
  import data from '../common/data.json';
  import { resolveAsset } from '../common/commonFunctions.ts'

  const JobMatchingSessionList = ref([]);
  const careerTalkSessionList = ref([]);

  function chunkArray(arr, chunkSize) {
    const result = [];
    for (let i = 0; i < arr.length; i += chunkSize) {
      result.push(arr.slice(i, i + chunkSize));
    }
    return result;
  }

  async function fetchSessions() {
    try {
      const res = await fetch("http://localhost/backend/api/getSessions.php");
      const data = await res.json();
      console.log("API response:", data);
      
      const venuSessions = computed(() =>
        (data || []).filter(item => item.venue === 'Pulau Pinang')
      )

      const jobMatching = venuSessions.value.filter(
        (s) => s.session_type_id === "1" || s.session_type_id === 1
      );
      const careerTalk = venuSessions.value.filter(
        (s) => s.session_type_id === "2" || s.session_type_id === 2
      );

      const groupByDate = (sessions) => {
        const grouped = {};
        sessions.forEach((s) => {
          if (!grouped[s.session_date]) grouped[s.session_date] = [];
          grouped[s.session_date].push({
            company: s.company || "",
            time: s.slot_time || "",
          });
        });

        const mapped = Object.entries(grouped).map(([date, list], index) => ({
          day: index + 1,
          date,
          list,
        }));

        // If API returned nothing, create placeholders
        if (mapped.length === 0) {
          return [
            {
              day: 1,
              date: "No sessions yet",
              list: [
                { company: "", time: "" },
                { company: "", time: "" },
                { company: "", time: "" },
              ],
            },
          ];
        }

        return mapped;
      };

      JobMatchingSessionList.value = groupByDate(jobMatching);
      careerTalkSessionList.value = groupByDate(careerTalk);

      const padEmpty = (list) => {
        list.forEach((day) => {
          const remainder = day.list.length % 3;
          if (remainder > 0) {
            const emptySlots = 3 - remainder;
            for (let i = 0; i < emptySlots; i++) {
              day.list.push({ company: "", time: "" });
            }
          }
        });
      };

      padEmpty(JobMatchingSessionList.value);
      padEmpty(careerTalkSessionList.value);
    } catch (err) {
      console.error("Error fetching sessions:", err);

      // show fallback placeholders even if fetch fails
      JobMatchingSessionList.value = [
        {
          day: 1,
          date: "No data (fetch failed)",
          list: [
            { company: "", time: "" },
            { company: "", time: "" },
            { company: "", time: "" },
          ],
        },
      ];

      careerTalkSessionList.value = [
        {
          day: 1,
          date: "No data (fetch failed)",
          list: [
            { company: "", time: "" },
            { company: "", time: "" },
            { company: "", time: "" },
          ],
        },
      ];
    }
  }

  onMounted(fetchSessions);
</script>

<template>
  <div class="titleDiv">
    <div class="bodyContainer">
        <div class="jobMatchingDiv">
          <img v-if="data.jobMatching?.jobMatchingImgUrl"
            :src="resolveAsset(data.jobMatching.jobMatchingImgUrl)"
            alt="jobMatching_img" />
        <div class="jobMatchingDesc">
            <p>{{ $t('jobMatching.jobMatchingDesc') }}</p>
        </div>
        </div>

        <!-- Loop through each day/session -->
        <div v-for="(session, index) in JobMatchingSessionList" :key="index" class="slotDiv">

            <div class="eachDayDiv">
                <p>{{ $t('jobMatching.day') }} {{ session.day }} - {{ session.date }}</p>

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
            
        <h1 class="dividerTitle">{{ $t('jobMatching.careerTalkSession') }}</h1>

        <!-- Loop through each day/session -->
        <div v-for="(session, index) in careerTalkSessionList" :key="index" class="slotDiv">

            <div class="eachDayDiv">
                <p>{{ $t('jobMatching.day') }} {{ session.day }} - {{ session.date }}</p>

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

        <div class='buttonComponent'>
            <ComponentButton 
                :isExhibitor="true"
                :to=data.jobMatching.buttonUrl
            >
              {{ $t('jobMatching.buttonName') }}
            </ComponentButton>
        </div>

        <div class='freeAdmissionDiv'>
            <div class='freeAdmissionImgDiv'>
              <img v-if="data.jobMatching?.freeAdmissionGiftUrl"
              :src="resolveAsset(data.jobMatching.freeAdmissionGiftUrl)"
              alt="freeAdmissionGift" />
            </div>
            
        </div>
    </div>
  </div>
</template>

<style scoped>
  .titleDiv {
    position: relative;
    width: 100vw;
    left: 50%;
    right: 50%;
    margin-left: -50vw;
    margin-right: -50vw;
    border-top: 3px solid black;
    color: white;
    background: linear-gradient(
      to bottom,
      purple 0%,
      #00308F 80%,
      #00308F 96%,
      white 100%
    );
    overflow: hidden;
  }

  .bodyContainer {
    max-width: 100%;
    height: auto;
    margin: 0 auto;
    padding: 0 5rem;
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
    margin: 5rem 0;
  }

  .jobMatchingDiv img {
    height: 30rem;
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
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }

  .eachDayDiv {
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
    height: 4rem;
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

  .dividerTitle {
    font-size: 2rem;
    font-weight: bold;
    text-align: center;
    color: #fff;
    padding: 5rem 0 2rem;
  }

  .buttonComponent {
    padding-top: 5rem;
  }

  .freeAdmissionDiv {
    width: 100%;
    height: auto;
    display: flex;
    justify-content: center;
    align-items: center;
    margin: 64px 0;
  }

  .freeAdmissionImgDiv {
    width: 80%;
    height: auto;
    background-color: red;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .freeAdmissionImgDiv img {
    width: 100%;
    height: auto;
    object-fit: contain;
  }

  @media (max-width: 1024px) {
    .bodyContainer {
      padding: 0 2rem;
    }
  }

  @media (max-width: 767px) {
    .bodyContainer {
      padding: 0 1rem;
    }

    .jobMatchingDiv {
      flex-direction: column;
      justify-content: center;
      align-items: center;
      margin: 5rem 0;
    }

    .jobMatchingDiv img {
      height: auto;
      width: 80%;
    }

    .jobMatchingDesc {
      margin-left: 0%;
      width: 70%;
      text-align: start;
    }

    .jobMatchingDesc p {
      font-size: 16px;
      line-height: 28px;
    }

    .eachCompanyRow {
      flex-direction: column;
      justify-content: center;
      align-items: center;
      gap: 2rem;
    }

    .eachCompanyCard {
      min-width: 70%;
    }

    .freeAdmissionImgDiv {
      width: 100%;
      height: auto;
      background-color: red;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .freeAdmissionImgDiv img {
      height: auto;
      width: 100%;
      object-fit: contain;
    }
  }

  @media (min-width: 768px) and (max-width: 1023px){
    .bodyContainer {
      padding: 0 2rem;
    }

    .jobMatchingDiv {
      flex-direction: column;
      justify-content: center;
      align-items: center;
      margin: 5rem 0;
    }

    .jobMatchingDiv img {
      height: auto;
      width: 80%;
    }

    .jobMatchingDesc {
      margin-left: 0%;
      width: 70%;
      text-align: start;
    }

    .jobMatchingDesc p {
      font-size: 16px;
      line-height: 28px;
    }

    .eachCompanyCard {
      min-width: 180px;
    }

    .freeAdmissionImgDiv {
      width: 100%;
      height: auto;
      background-color: red;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .freeAdmissionImgDiv img {
      height: auto;
      width: 100%;
      object-fit: contain;
    }
  }
</style>