import Vue from 'vue'
import App from './App.vue'
import router from './router'
import vuetify from './plugins/vuetify';

import { store } from './store/store'

Vue.config.productionTip = false

import VueSweetalert2 from "vue-sweetalert2";

const options = {
  confirmButtonColor: '#04AAFB',
  cancelButtonColor: '#ff7674'
};

Vue.use(VueSweetalert2, options);

new Vue({
  router,
  store,
  render: h => h(App),
  vuetify,
}).$mount('#app')

