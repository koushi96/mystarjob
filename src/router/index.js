import { createRouter, createWebHistory } from 'vue-router';
import HomePage from '../views/HomePage.vue';
import ExhibitorRegistration from '../components/ExhibitorResgistration.vue';
import Reservation from '../components/Reservation.vue';
import Game from '../components/Game.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: 'Home',
      component: HomePage,
    },
    {
      path: '/exhibitorRegistration',
      name: 'ExhibitorRegistration',
      component: ExhibitorRegistration,
    },
    {
      path: '/reservation',
      name: 'Reservation',
      component: Reservation,
    },
    {
      path: '/game',
      name: 'Game',
      component: Game,
    },
  ],

  scrollBehavior(to, from, savedPosition) {
    // If navigating with a hash (like /#contact-us)
    if (to.hash) {
      return {
        el: to.hash,
        behavior: 'smooth',
      }
    }
    // If using browser back/forward
    else if (savedPosition) {
      return savedPosition
    }
    // Default: scroll to top
    else {
      return { top: 0 }
    }
  },
})

export default router