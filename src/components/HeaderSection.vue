<script setup>
import { resolveAsset } from '../common/commonFunctions.ts'
import data from '../common/data.json'
import { ref, onMounted, onUnmounted } from 'vue'

const isMobile = ref(false)

function checkIsMobile() {
  isMobile.value = window.innerWidth < 768
}

onMounted(() => {
  checkIsMobile()
  window.addEventListener('resize', checkIsMobile)
})

onUnmounted(() => {
  window.removeEventListener('resize', checkIsMobile)
})
</script>

<template>
  <div class="header">
    <img
      v-if="!isMobile"
      :src="resolveAsset(data.headerSection.mainPicUrl)"
      alt="main_header_pic"
      class="main-pic"
    />

    <div v-else class="mobile-header">
      <img
        :src="resolveAsset(data.headerSection.mobileMainPicWordsUrl)"
        alt="mobile_header_words"
        class="mobile-words"
      />
      <img
        :src="resolveAsset(data.headerSection.mobileMainPicPeopleUrl)"
        alt="mobile_header_people"
        class="mobile-people"
      />
    </div>
  </div>
</template>

<style scoped>
.header {
  width: 100%;
  height: auto;
  color: black;
  cursor: pointer;
}

.main-pic {
  width: 100%;
  height: auto;
  object-fit: contain;
}

.mobile-header {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0;
}

.mobile-header img {
  width: 100%;
  height: auto;
  object-fit: contain;
}
</style>