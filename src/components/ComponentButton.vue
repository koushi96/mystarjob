<script setup>
import { useRouter } from 'vue-router';

const props = defineProps({
  isExhibitor: Boolean,
  to: String 
});

const router = useRouter();

function handleClick() {
  if (props.to) {
    router.push(props.to);
  }
}
</script>

<template>
  <button 
    :class="isExhibitor ? 'btnGreen' : 'btn'" 
    @click="handleClick"
  >
    <slot></slot>
  </button>
</template>

<style scoped>
.btn {
  background: white;
  color: black;
  border: 1px solid black;
  cursor: pointer;
  border-radius: 24px;
  padding: 16px 16px;
  display: flex;
  flex-direction: row;
}

.btnGreen {
  background: green;
  color: white;
  border: none;
  cursor: pointer;
  border-radius: 10px;
  padding: 16px 16px;
}
</style>