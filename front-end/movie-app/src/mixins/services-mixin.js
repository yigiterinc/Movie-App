import Vue from 'vue'

import axios from 'axios'
import VueAxios from 'vue-axios'

Vue.use(VueAxios, axios);

axios.defaults.headers.post['Access-Control-Allow-Origin'] = '*';

export default {
    data() {
        return {
            SERVICES_ENDPOINT: 'http://localhost:3000',
            USERS_ENDPOINT: this.SERVICES_ENDPOINT + '/users'
        }
    },
    methods: {
        register: function (name, email, password) {
            const url = this.SERVICES_ENDPOINT + '/users'
            const data = {
                user: {
                    name: name,
                    email: email,
                    password: password
                }
            }

            return new Promise((resolve, reject) => { axios.post(url, data).then(() => {
                resolve()
            }).catch(error => {
                reject(error)
            })})
        }
    }
}
