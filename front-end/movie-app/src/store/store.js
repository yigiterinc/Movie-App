import Vuex from "vuex";

import Vue from 'vue'

Vue.use(Vuex);

import axios from "axios";

axios.defaults.headers.post['Access-Control-Allow-Origin'] = '*';

export const store = new Vuex.Store({
    state: {
        user: {},
        token: localStorage.getItem('token') || '',
        loginStatus: null   // Login state
    },
    mutations: {
        loading (state) {
            state.loginStatus = 'loading'
        },
        loginSuccess(state, { token, user }) {
            state.loginStatus = 'success'
            state.token = token
            state.user = user
        },
        loginFailure(state) {
            state.loginStatus = 'failure'
            state.token = ''
            state.user = {}
        }
    },
    actions: {
       loginAction({ commit }, userDetails) {
          commit('loading');    // Set the state to loading

           return new Promise((resolve, reject) => {
               const postEndpoint = 'http://localhost:3000/user/authenticate' + '?email=' + userDetails.email
                   + '&password=' + userDetails.password;

               axios.post(postEndpoint).then(response => {
                   const token = response.data.auth_token;
                   const user = response.data.user;

                   if (response.status == 200) {
                       commit('loginSuccess', { token, user })
                       localStorage.setItem('token', token)
                       axios.defaults.headers.common['Authorization'] = token
                       console.log('success')
                       resolve(response.data)
                   } else {
                       commit('loginFailure')
                       localStorage.removeItem('token');
                       reject()
                   }
               }).catch(err => {
                   console.error(err)
                   commit('loginFailure')
                   localStorage.removeItem('token');
                   reject()
               })
           })
      }
    },
    getters: {
        isLoggedIn: state => state.loginStatus === 'success',
        name: state => state.user.name,
        email: state => state.user.email,
        token: state => state.token
    }
});
