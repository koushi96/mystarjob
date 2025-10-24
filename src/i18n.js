import { createI18n } from 'vue-i18n'

import en from './locales/data_en.json'
import zh from './locales/data_zh.json'
import ta from './locales/data_ta.json'
import ms from './locales/data_ms.json'

const i18n = createI18n({
  legacy: false, 
  locale: 'en',  
  fallbackLocale: 'en',
  messages: {
    en,
    zh,
    ta,
    ms
  }
})

export default i18n