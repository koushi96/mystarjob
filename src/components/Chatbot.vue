<script setup>
import { onMounted } from 'vue';

onMounted(() => {
  // dynamically load Dialogflow Messenger script if not already loaded
  if (!document.querySelector('script[src*="dialogflow-console/fast/messenger/bootstrap.js"]')) {
    const s = document.createElement('script');
    s.src = 'https://www.gstatic.com/dialogflow-console/fast/messenger/bootstrap.js?v=1';
    document.body.appendChild(s);
  }
});
</script>

<template>
  <df-messenger
    intent="WELCOME"
    chat-title="myStarJob"
    agent-id="40005450-b521-46b0-9634-0f6ecc92c205"
    language-code="en"
  ></df-messenger>
</template>

<style scoped>
df-messenger {
  --df-messenger-bot-message: #f1f1f1;
  --df-messenger-button-titlebar-color: #007bff;
}
</style>