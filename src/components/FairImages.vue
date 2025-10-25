<script setup>
  import { Swiper, SwiperSlide } from 'swiper/vue';
  import 'swiper/css';
  import 'swiper/css/navigation';
  import 'swiper/css/pagination';
  import { Navigation, Pagination, Autoplay } from 'swiper/modules';
  import data from '../common/data.json';
  import { resolveAsset } from '../common/commonFunctions.ts'
</script>

<template>
  <div class="swiper-wrapper">
    <Swiper
      :modules="[Navigation, Pagination, Autoplay]"
      :slides-per-view="3"
      :space-between="20"
      :loop="true"
      :autoplay="{ delay: 3000, disableOnInteraction: false }"
      :pagination="{ clickable: true }"
      navigation
      :breakpoints="{
        0: { slidesPerView: 1 },
        768: { slidesPerView: 2 },
        1024: { slidesPerView: 3 }
      }"
    >
      <SwiperSlide v-for="(img, index) in data.fairImages.images" :key="index">
        <img :src="resolveAsset(img)" alt="Fair Image" class="slide-img" />
      </SwiperSlide>
    </Swiper>
  </div>
</template>

<style scoped>
.swiper-wrapper {
  width: 100%;
  max-width: 1000px;
  margin: 2rem auto;
}

.slide-img {
  width: 100%;
  height: 250px;
  object-fit: cover;
  border-radius: 12px;
  transition: transform 0.3s ease;
}

.slide-img:hover {
  transform: scale(1.03);
}

:deep(.swiper-pagination-bullet) {
  background: #ccc;
  opacity: 1;
  width: 10px;
  height: 10px;
  transition: background 0.3s ease;
}

:deep(.swiper-pagination-bullet-active) {
  background: linear-gradient(to right, #703eff, #2c97ff);
}

/* Customize navigation arrows */
:deep(.swiper-button-next),
:deep(.swiper-button-prev) {
  color: #703eff;
  transition: color 0.3s ease, transform 0.3s ease;
}

:deep(.swiper-button-next:hover),
:deep(.swiper-button-prev:hover) {
  color: #2c97ff;
  transform: scale(1.1);
}
</style>