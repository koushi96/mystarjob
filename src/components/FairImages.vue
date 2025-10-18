<template>
  <div class="slider-container">
    <!-- Left Arrow -->
    <button class="nav-button left" @click="prevSlide" :disabled="currentIndex === 0">
      &#10094;
    </button>

    <!-- Slider Window -->
    <div class="slider-window">
      <div
        class="slider-track"
        :style="{ transform: `translateX(-${currentIndex * (100 / visibleSlides)}%)` }"
      >
        <div class="slide" v-for="(img, index) in images" :key="index">
          <img :src="img" alt="Slide Image" />
        </div>
      </div>
    </div>

    <!-- Right Arrow -->
    <button class="nav-button right" @click="nextSlide" :disabled="currentIndex >= maxIndex">
      &#10095;
    </button>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'

// Static image list — replace with import.meta.glob if needed
const images = [
  new URL('../assets/fairPictures/1.jpg', import.meta.url).href,
  new URL('../assets/fairPictures/2.jpg', import.meta.url).href,
  new URL('../assets/fairPictures/3.jpg', import.meta.url).href,
  new URL('../assets/fairPictures/4.jpg', import.meta.url).href,
  new URL('../assets/fairPictures/5.jpg', import.meta.url).href,
  new URL('../assets/fairPictures/6.jpg', import.meta.url).href
]

const visibleSlides = 3
const currentIndex = ref(0)

const maxIndex = computed(() => images.length - visibleSlides)

function nextSlide() {
  if (currentIndex.value < maxIndex.value) {
    currentIndex.value++
  }
}

function prevSlide() {
  if (currentIndex.value > 0) {
    currentIndex.value--
  }
}
</script>

<style scoped>
.slider-container {
  width: 100%;
  max-width: 900px;
  margin: 2rem auto;
  position: relative;
  overflow: hidden;
  display: flex;
  align-items: center;
}

.slider-window {
  flex-grow: 1;
  overflow: hidden;
}

.slider-track {
  display: flex;
  transition: transform 0.4s ease-in-out;
  width: fit-content;
}

.slide {
  flex: 0 0 calc(100% / 3); /* 3 visible slides */
  padding: 8px;
}

.slide img {
  width: 100%;
  height: 200px;
  object-fit: cover;
  border-radius: 8px;
}

/* Side nav buttons */
.nav-button {
  background-color: white;
  color: black;
  border: none;
  font-size: 2rem;
  padding: 10px;
  cursor: pointer;
  z-index: 10;
  border-radius: 50%;
  transition: background 0.2s ease;
}

.nav-button:hover {
  background: linear-gradient(to right, purple, blue);
  color: white;
}

.nav-button:disabled {
  opacity: 0.4;
  cursor: not-allowed;
}

.nav-button.left {
  margin-right: 10px;
}

.nav-button.right {
  margin-left: 10px;
}
</style>