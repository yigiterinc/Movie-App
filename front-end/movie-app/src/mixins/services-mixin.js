import Vue from 'vue'

import axios from 'axios'
import VueAxios from 'vue-axios'

Vue.use(VueAxios, axios);

axios.defaults.headers.post['Access-Control-Allow-Origin'] = '*';

export default {
    data() {
        return {
            SERVICES_ENDPOINT: 'http://localhost:3000',
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

            return this.postWithData(url, data)
        },

        fetchPopularMovies: function () {
            const url = this.SERVICES_ENDPOINT + '/tmdb/popular'

            return this.get(url)
        },

        fetchInTheatre: function () {
            const url = this.SERVICES_ENDPOINT + '/tmdb/in_theatre'

            return this.get(url)
        },

        fetchRecommendations: function (userId) {
            const url = this.SERVICES_ENDPOINT + '/user/recommendations' + '?user_id='+ userId

            return this.get(url)
        },

        followMovie: function (userId, movieTitle) {
            const url = this.SERVICES_ENDPOINT + '/user/follow?user_id='
                            + userId + '&movie=' + movieTitle

            return this.post(url)
        },

        followGenre: function (userId, genre) {
            const url = this.SERVICES_ENDPOINT + '/user/follow?user_id='
                + userId + '&genre=' + genre

            return this.post(url)
        },

        followStar: function (userId, star) {
            const url = this.SERVICES_ENDPOINT + '/user/follow?user_id='
                + userId + '&star=' + star

            return this.post(url)
        },

        unfollowMovie: function (userId, movieTitle) {
            const url = this.SERVICES_ENDPOINT + '/user/unfollow?user_id='
                            + userId + '&movie=' + movieTitle

            return this.post(url)
        },

        unfollowStar: function (userId, star) {
            const url = this.SERVICES_ENDPOINT + '/user/unfollow?user_id='
                + userId + '&star=' + star

            return this.post(url)
        },

        unfollowGenre: function (userId, genre) {
            const url = this.SERVICES_ENDPOINT + '/user/unfollow?user_id='
                + userId + '&genre=' + genre

            return this.post(url)
        },

        getMovie: function (movieId) {
            const url = this.SERVICES_ENDPOINT + '/movies/' + movieId

            return this.get(url)
        },

        getGenres: function () {
            const url = this.SERVICES_ENDPOINT + '/genres'

            return this.get(url)
        },

        forgotPassword: function (email) {
            const url = this.SERVICES_ENDPOINT + '/password/forgot'
                            + '?email=' + email

            return this.post(url)
        },

        resetPassword: function (token, password) {
            const url = this.SERVICES_ENDPOINT + '/password/reset'
                        + '?token=' + token + '&password=' + password

            return this.post(url)
        },

        get: function (endpoint) {
            return new Promise ((resolve, reject) => {
                Vue.axios.get(endpoint).then(response => {
                    resolve(response.data)
                }).catch(error => {
                    console.error(error);
                    reject(error);
                })
            })
        },

        post: function (endpoint) {
            return new Promise((resolve, reject) => {
                axios.post(endpoint).then(() => {
                    resolve()
                }).catch(error => {
                    console.error(error)
                    reject(error)
                })
            })
        },

        postWithData: function (endpoint, data) {
            return new Promise((resolve, reject) => {
                axios.post(endpoint, data).then(() => {
                    resolve()
                }).catch(error => {
                    console.error(error)
                    reject(error)
                })
            })
        }
    }
}
