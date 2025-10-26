<script setup>
import { ref, onMounted } from 'vue'

/* ---------------------------
    State & References
---------------------------- */
const container = ref(null)
const result = ref('')
const spinning = ref(false)
let totalRotation = 0

/* ---------------------------
    Prize Configuration
---------------------------- */
const prizes = ref([
  { id: 'grand', name: 'Grand Prize', qty: 1, prob: 1, color: '#3f51b5', tier: 'grand' },
  { id: 'second', name: 'Second Prize', qty: 2, prob: 3, color: '#ff9800', tier: 'second' },
  { id: 'consol', name: 'Consolation Prize', qty: 5, prob: 6, color: '#e91e63', tier: 'consolation' },
  { id: 'none', name: 'Better luck next time', qty: 999, prob: 10, color: '#4caf50', tier: 'none' },
])

/* ---------------------------
    Render Wheel Segments
---------------------------- */
onMounted(() => {
  const slices = container.value.querySelectorAll('div')
  prizes.value.forEach((p, i) => {
    const slice = slices[i]
    if (slice) {
      slice.style.backgroundColor = p.color
      slice.textContent = p.name
    }
  })
})

/* ---------------------------
    Weighted Prize Picker
---------------------------- */
function pickPrizeWeighted() {
  const available = prizes.value.filter(p => p.qty > 0)
  if (available.length === 0) return null

  const total = available.reduce((a, b) => a + b.prob, 0)
  let r = Math.random() * total

  for (let p of available) {
    r -= p.prob
    if (r <= 0) return p
  }
  return available[available.length - 1]
}

/* ---------------------------
    Spin Logic
---------------------------- */
function spin() {
  if (spinning.value) return

  const prize = pickPrizeWeighted()
  if (!prize) {
    result.value = 'No prizes left!'
    return
  }

  spinning.value = true
  result.value = ''

  const n = prizes.value.length
  const idx = prizes.value.findIndex(p => p.id === prize.id)
  const sliceAngle = 360 / n
  const offset = (Math.random() * (sliceAngle - 8)) + 4
  const targetMid = (idx * sliceAngle) + (sliceAngle / 2)
  const extraSpins = 4 + Math.floor(Math.random() * 3)

  //  reset any accumulated rotation drift
  const currentRotation = totalRotation % 360
  container.value.style.transition = 'none'
  container.value.style.transform = `rotate(${currentRotation}deg)`
  void container.value.offsetWidth // force repaint

  // compute new absolute rotation so that the chosen slice lands under the arrow
  const rotationDeg = (extraSpins * 360) + (360 - targetMid) + offset

  totalRotation = rotationDeg // ← not cumulative anymore!

  container.value.style.transition = 'transform 4.5s cubic-bezier(.15,.85,.35,1)'
  container.value.style.transform = `rotate(${rotationDeg}deg)`

  container.value.addEventListener(
    'transitionend',
    () => {
      handleWin(prize)
      spinning.value = false
    },
    { once: true }
  )
}

/* ---------------------------
    Handle Prize Result
---------------------------- */
function handleWin(prize) {
  prize.qty = Math.max(0, prize.qty - 1)
  result.value = prize.name
  triggerPrizeEffect(prize.tier)
}

/* ---------------------------
    Prize Visual Effects
---------------------------- */
function triggerPrizeEffect(tier) {
  const body = document.querySelector('.gameBody')
  body.classList.remove('grand', 'second', 'consolation', 'none')

  if (tier === 'grand') {
    showConfetti(80)
    body.classList.add('grand')
  } else if (tier === 'second') {
    showConfetti(30)
    body.classList.add('second')
  } else if (tier === 'consolation') {
    showConfetti(15)
    body.classList.add('consolation')
  } else {
    body.classList.add('none')
  }

  setTimeout(() => {
    body.classList.remove('grand', 'second', 'consolation', 'none')
  }, 2500)
}

/* ---------------------------
    Confetti Effect
---------------------------- */
function showConfetti(count = 40) {
  const frag = document.createDocumentFragment()
  for (let i = 0; i < count; i++) {
    const el = document.createElement('div')
    el.className = 'confetti-piece'
    el.style.left = Math.random() * 100 + '%'
    el.style.background = `hsl(${Math.random() * 360}deg,70%,60%)`
    el.style.animationDelay = Math.random() * 300 + 'ms'
    frag.appendChild(el)
  }
  const conf = document.createElement('div')
  conf.className = 'confetti'
  conf.appendChild(frag)
  document.body.appendChild(conf)
  setTimeout(() => conf.remove(), 2500)
}
</script>

<template>
  <div class="gameBody">
    <button id="spin" @click="spin">Spin</button>
    <span class="arrow"></span>

    <div class="container" ref="container">
      <div class="one"></div>
      <div class="two"></div>
      <div class="three"></div>
      <div class="four"></div>
    </div>

    <div v-if="result" class="result">You won: {{ result }} 🎉</div>
  </div>
</template>

<style scoped>
* { box-sizing: border-box; }
.gameBody {
  background-color: #34495e;
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
  overflow: hidden;
  position: relative;
  transition: background 1s;
}
.container {
  width: 500px;
  height: 500px;
  background-color: #ccc;
  border-radius: 50%;
  border: 15px solid #dde;
  position: relative;
  overflow: hidden;
}
.container div {
  height: 50%;
  width: 470px;
  position: absolute;
  clip-path: polygon(100% 0 , 50% 100% , 0 0 );
  transform: translateX(-25%);
  transform-origin: bottom;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 16px;
  font-weight: bold;
  color: #fff;
  
}
.container .one { transform: rotate(0deg); }
.container .two { transform: rotate(90deg); }
.container .three { transform: rotate(180deg); }
.container .four { transform: rotate(270deg); }

.arrow {
  position: absolute;
  top: 0;
  left: 50%;
  transform: translateX(-50%);
}
.arrow::before {
  content: "⮟"; 
  font-size: 50px;
  color: #fff;
}
#spin {
  position: absolute;
  top: 50%;
  left: 50%;
  transform: translate(-50%, -50%);
  z-index: 10;
  background-color: #e2e2e2;
  border: 8px solid #fff;
  font-weight: bold;
  font-size: 20px;
  color: #333;
  width: 90px;
  height: 90px;
  border-radius: 50%;
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
}
.result {
  position: absolute;
  bottom: 50px;
  color: white;
  font-size: 1.2rem;
  font-weight: bold;
}

/* Confetti Effect */
.confetti {
  position: fixed;
  left: 0; top: 0; right: 0; bottom: 0;
  pointer-events: none;
  z-index: 9999;
}
.confetti-piece {
  position: absolute;
  width: 10px; height: 18px;
  border-radius: 2px;
  opacity: 0.9;
  animation: confetti-fall 1.5s linear forwards;
}
@keyframes confetti-fall {
  to { transform: translateY(110vh) rotate(720deg); opacity: 1; }
}

/* Flash Effects */
.gameBody.grand { background-color: #ffd700; }
.gameBody.second { background-color: #ff9800; }
.gameBody.consolation { background-color: #e91e63; }
.gameBody.none { background-color: #4caf50; }
</style>
