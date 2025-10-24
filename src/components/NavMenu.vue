<script setup>
import ComponentButton from './ComponentButton.vue';
import { resolveAsset } from '../common/commonFunctions.ts';
import data from '../common/data.json';
import { useI18n } from 'vue-i18n';

const { locale } = useI18n();

function changeLang(lang) {
  locale.value = lang;
  localStorage.setItem('lang', lang); // remember selection
}
</script>

<template>
  <nav class="navbar">
    <div class="nav-container">
      <!-- LOGO -->
      <div class="logo">
        <img :src="resolveAsset(data.navMenue.logoJobFairUrl)" alt="Company_Logo" />
      </div>

      <!-- NAV BUTTONS -->
      <div class="nav-links">
        <ComponentButton :isExhibitor="false" :to="data.navMenue.homeButtonUrl">
          {{ $t('navMenue.homeButton') }}
          <span class="arrowDiv">
            <img :src="resolveAsset(data.navMenue.arrowNextSvg)" alt="arrow-next-small" />
          </span>
        </ComponentButton>

        <ComponentButton :isExhibitor="false" :to="data.navMenue.contactUsUrl">
          {{ $t('navMenue.contactUsButton') }}
          <span class="arrowDiv">
            <img :src="resolveAsset(data.navMenue.arrowNextSvg)" alt="arrow-next-small" />
          </span>
        </ComponentButton>

        <ComponentButton :isExhibitor="true" :to="data.navMenue.beOurExhibitorUrl">
          {{ $t('navMenue.beOurExhibitorButton') }}
        </ComponentButton>

        <!-- LANGUAGE SWITCHER -->
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
  align-items: center;
  gap: 16px;
}

.arrowDiv {
  display: flex;
  align-items: center;
}

.arrowDiv img {
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

/* === LANGUAGE SWITCHER === */
.language-switcher {
  margin-left: 12px;
}

.language-switcher select {
  background-color: white;
  border: 1px solid #ddd;
  border-radius: 8px;
  padding: 6px 10px;
  font-size: 14px;
  color: #333;
  cursor: pointer;
  transition: all 0.3s ease;
}

.language-switcher select:hover {
  border-color: #703EFF;
  color: #703EFF;
}
</style>
