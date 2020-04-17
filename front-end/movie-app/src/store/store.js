import Vuex from "vuex";

import Vue from 'vue'

Vue.use(Vuex);

import axios from "axios";

axios.defaults.headers.post['Access-Control-Allow-Origin'] = '*';

export const store = new Vuex.Store({
    state: {
        user: {},
        following: {},
        token: localStorage.getItem('token') || '',
        loginStatus: null   // Login state
    },
    mutations: {
        loading (state) {
            state.loginStatus = 'loading'
        },
        saveGenre (state, genre) {
            state.following.genres.push(genre)
        },
        loginSuccess(state, { token, user, followedMovies, followedGenres, followedStars }) {
            state.loginStatus = 'success'
            state.token = token
            state.user = user
            state.following = {
                movies: followedMovies,
                genres: followedGenres,
                stars: followedStars
            }
        },
        loginFailure(state) {
            state.loginStatus = 'failure'
            state.token = ''
            state.user = {}
        },
        logout(state) {
            state.user = ''
            state.token = ''
            state.loginStatus = ''
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
                   const followedMovies = response.data.followed_movies
                   const followedGenres = response.data.followed_genres
                   const followedStars = response.data.followed_stars

                   if (response.status == 200) {
                       commit('loginSuccess',
                                { token, user, followedMovies, followedGenres, followedStars })
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
      },

      logout({ commit }) {
          commit('logout')
          localStorage.removeItem('token')
       }
    },
    getters: {
        user: state => state.user,
        isLoggedIn: state => state.loginStatus === 'success',
        name: state => state.user.name,
        email: state => state.user.email,
        id: state => state.user.id,
        token: state => state.token,
        following: state => state.following
    }
});
