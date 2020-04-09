import Vue from 'vue'

import axios from 'axios'
import VueAxios from 'vue-axios'

Vue.use(VueAxios, axios);

axios.defaults.headers.post['Access-Control-Allow-Origin'] = '*';

export default {
    data() {
        return {
            SERVICES_ENDPOINT: 'https://localhost:3000',
            LOGIN_ENDPOINT: this.SERVICES_ENDPOINT + '/user/authenticate'
        }
    },
    methods: {
        authenticateUser: (email, password) => {
            console.log('hello')
            return new Promise((resolve, reject) => {
                const postEndpoint = this.LOGIN_ENDPOINT + '?email=' + email
                                            + '&password=' + password;

                axios.post(postEndpoint).then(response => {
                    const token = response.data.auth_token;
                    const user = response.data.user;
                    const resolveData = {token, user};
                    console.log(resolveData)
                    resolve(resolveData)
                }).catch(error => {
                    console.log('fucked up')
                    reject(error)
                })
            })
        }
    }
}
