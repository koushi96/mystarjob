import { createRouter, createWebHistory } from 'vue-router';
import HomePage from '../views/HomePage.vue';
import ExhibitorRegistration from '../components/ExhibitorResgistration.vue';
import Reservation from '../components/Reservation.vue';

const routes = [
  {
    path: '/',
    name: 'Home',
    component: HomePage
  },
  {
    path: '/exhibitorRegistration',
    name: 'ExhibitorRegistration',
    component: ExhibitorRegistration
  },
  {
    path: '/reservation',
    name: 'Reservation',
    component: Reservation
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes
});

export default router;