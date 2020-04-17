import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../views/Home.vue'


Vue.use(VueRouter);

const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
  {
    path: '/login',
    name: 'Login',
    component: () => import(/* webpackChunkName: "about" */ '../views/Login.vue')
  },
  {
    path: '/details/:id',
    name: 'Details',
    component: () => import('../views/MovieDetails.vue')
  },
  {
    path: '/profile/:id',
    name: 'Profile',
    component: () => import('../views/UserProfile.vue')
  },
  {
    path: '/genres',
    name: 'Genres',
    component: () => import('../views/Genres.vue')
  },
  {
    path: '/stars',
    name: 'Stars',
    component: () => import('../views/Stars.vue')
  },
  {
    path: '/resetPassword/:token',
    name: 'ForgotPassword',
    component: () => import('../views/ResetPassword.vue')
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

export default router
