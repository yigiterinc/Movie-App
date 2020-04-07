import Vue from 'vue'

import axios from 'axios'
import VueAxios from 'vue-axios'

Vue.use(VueAxios, axios);

axios.defaults.headers.post['Access-Control-Allow-Origin'] = '*';

export default {
    data() {
        return {
            SERVICES_ENDPOINT: 'https://localhost:3000/login'
        }
    },
    methods: {

    }
}
