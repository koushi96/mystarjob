<script setup>
    import { ref, onMounted, onUnmounted } from 'vue'

    // 🕒 Set your target date here
    const targetDate = new Date('2025-12-31T23:59:59')

    const timeLeft = ref({
    total: 0,
    days: 0,
    hours: 0,
    minutes: 0,
    seconds: 0
    })

    let timer = null

    function updateCountdown() {
    const now = new Date()
    const difference = targetDate - now

    if (difference <= 0) {
        clearInterval(timer)
        timeLeft.value = {
        total: 0,
        days: 0,
        hours: 0,
        minutes: 0,
        seconds: 0
        }
        return
    }

    timeLeft.value = {
        total: difference,
        days: Math.floor(difference / (1000 * 60 * 60 * 24)),
        hours: Math.floor((difference / (1000 * 60 * 60)) % 24),
        minutes: Math.floor((difference / (1000 * 60)) % 60),
        seconds: Math.floor((difference / 1000) % 60)
    }
    }

    onMounted(() => {
    updateCountdown() // initialize immediately
    timer = setInterval(updateCountdown, 1000)
    })

    onUnmounted(() => {
    clearInterval(timer)
    })
</script>

<template>
    <div class="mainLayout">
        <div class="titleDiv">
        <h3 class='title'>Next myStarJob Fair in...</h3>
        </div>
    </div>
    <div class="countdown">
        <div v-if="timeLeft.total > 0">
        <span>{{ timeLeft.days }}d</span>
        <span>{{ timeLeft.hours }}h</span>
        <span>{{ timeLeft.minutes }}m</span>
        <span>{{ timeLeft.seconds }}s</span>
        </div>
        <div v-else>
        <strong>Countdown Complete!</strong>
        </div>
    </div>
</template>

<style scoped>
.mainLayout {
  width: 100%;
  height: auto;
  display: flex;
  justify-content: center;
  align-items: center;
}

.titleDiv {
  width: 60%;
  height: auto;
  display: flex;
  flex-direction: row;
  justify-content: center;
  align-items: center;
} 

.title {
  color: black;
  border: none;
  font-size: 4rem;
  font-height: 5rem;
  display: flex;
  justify-content: center;
  align-items: center;
  margin-bottom: 0px;
}

.countdown {
  font-family: 'Segoe UI', sans-serif;
  font-size: 3.5rem;
  display: flex;
  gap: 1rem;
  justify-content: center;
  align-items: center;
  margin-top: 2rem;
}

.countdown span {
  padding: 0.5rem 1rem;
  background: linear-gradient(to right, purple, blue);
  color: white;
  border-radius: 6px;
  font-weight: bold;
  margin-left: 2rem;
}
</style>