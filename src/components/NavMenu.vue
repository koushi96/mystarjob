<script setup>
import { ref, onMounted, onBeforeUnmount } from 'vue';
import ComponentButton from './ComponentButton.vue';
import { resolveAsset } from '../common/commonFunctions.ts';
import data from '../common/data.json';
import { useI18n } from 'vue-i18n';

const { locale } = useI18n();
const menuOpen = ref(false);
const menuRef = ref(null);

function changeLang(lang) {
  locale.value = lang;
  localStorage.setItem('lang', lang);
}

function toggleMenu() {
  menuOpen.value = !menuOpen.value;
}

function handleClickOutside(event) {
  if (
    menuOpen.value &&
    menuRef.value &&
    !menuRef.value.contains(event.target) &&
    !event.target.closest('.hamburger')
  ) {
    menuOpen.value = false;
  }
}

onMounted(() => {
  document.addEventListener('click', handleClickOutside);
});
onBeforeUnmount(() => {
  document.removeEventListener('click', handleClickOutside);
});
</script>

<template>
  <nav class="navbar">
    <div class="nav-container">
      <!-- LOGO -->
      <div class="logo">
        <img :src="resolveAsset(data.navMenue.logoJobFairUrl)" alt="Company_Logo" />
      </div>

      <div class="hamburger" @click.stop="toggleMenu">
        <template v-if="!menuOpen">
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M4 6h16M4 12h16M4 18h16" />
          </svg>
        </template>
        <template v-else>
          <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                  d="M6 18L18 6M6 6l12 12" />
          </svg>
        </template>
      </div>

      <div ref="menuRef" class="nav-links" :class="{ active: menuOpen }">
        <ComponentButton :isExhibitor="false" :to="data.navMenue.homeButtonUrl">
          {{ $t('navMenue.homeButton') }}
        </ComponentButton>

        <ComponentButton :isExhibitor="false" :to="data.navMenue.contactUsUrl">
          {{ $t('navMenue.contactUsButton') }}
        </ComponentButton>

        <ComponentButton :isExhibitor="true" :to="data.navMenue.beOurExhibitorUrl">
          {{ $t('navMenue.beOurExhibitorButton') }}
        </ComponentButton>

        <div class="language-switcher">
          <select v-model="locale" @change="changeLang(locale)">
            <option value="en">EN</option>
            <option value="zh">中文</option>
            <option value="ta">தமிழ்</option>
            <option value="ms">BM</option>
          </select>
        </div>
      </div>
    </div>
  </nav>
</template>

<style scoped>
  .navbar {
    width: 100%;
    background-color: white;
    padding: 16px 24px;
    box-shadow: 0 2px 4px rgba(0,0,0,0.05);
    position: relative;
    z-index: 20;
  }

  .nav-container {
    display: flex;
    justify-content: space-between;
    align-items: center;
  }

  .logo img {
    height: 4rem;
    width: auto;
    object-fit: contain;
  }

  .hamburger {
    display: none;
    cursor: pointer;
    z-index: 30;
  }

  .nav-links {
    display: flex;
    align-items: center;
    gap: 16px;
  }

  @media (max-width: 1024px) {

    .navbar {
      width: 100%;
      background-color: #FBFCFA;
      padding: 0px;
      position: relative;
      z-index: 20;
    }

    .hamburger {
      display: flex;
    }

    .nav-links {
      position: absolute;
      top: 72px;
      right: 0px;
      flex-direction: column;
      align-items: flex-start;
      background-color: #FBFCFA;
      padding: 1rem 1.5rem;
      border-radius: 12px;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      width: 220px;
      opacity: 0;
      visibility: hidden;
      transform: translateY(-10px);
      transition: all 0.3s ease;
    }

    .nav-links.active {
      opacity: 1;
      visibility: visible;
    }
  }
</style>
