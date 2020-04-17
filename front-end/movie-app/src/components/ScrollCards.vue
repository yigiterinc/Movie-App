<template>
    <div>
        <div class="spacing">
            <h2 class="subtitle">{{ this.label }}</h2>
        </div>
        <v-row class="row-style">
            <v-col v-for="(movie, i) in movies" cols="2" :key="{keyVal} + i" class="col-style">
                <v-card v-if="movie" max-width="220">
                    <div @click="redirectToMovieDetails(movie)">
                        <v-list-item>
                            <v-list-item-content>
                                <v-list-item-title class="headline title">{{ movie.title }}</v-list-item-title>
                            </v-list-item-content>
                        </v-list-item>
                        <v-img :src="getPosterUrl(movie.poster_path)"
                               class="white--text align-end"
                               gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)"
                               height="180px">
                            <v-card-title v-text="movie.title"></v-card-title>
                        </v-img>
                    </div>

                    <v-card-actions>
                        <v-spacer></v-spacer>
                        <div v-if="!loading && loggedIn">
                            <v-btn v-if="following[i]" color="error" @click="unfollow(movie.title, i)">
                                Unfollow
                            </v-btn>
                            <v-btn v-else color="primary" @click="follow(movie.title, i)">
                                Follow
                            </v-btn>
                        </div>
                    </v-card-actions>
                </v-card>
            </v-col>
        </v-row>
    </div>
</template>
<script>
    import ServicesMixin from '../mixins/services-mixin'
    import UtilsMixin from '../mixins/utils-mixin'

    export default {
        name: 'Scroll-Cards',
        mixins: [ServicesMixin, UtilsMixin],
        props: ['movies', 'label', 'keyVal'],
        data() {
            return {
                following: [],
                done: false,
                loading: false
            }
        },
        methods: {
            follow: function (title, i) {
                this.loading = true

                this.followMovie(this.$store.getters.id, title).then(() => {
                    this.following.splice(i, 1, true)
                    console.log('success', this.following[i])
                    this.loading = false
                }).catch(error => {
                    this.following.splice(i, 1, false)
                    console.error(error)
                    this.loading = false
                })
            },

            unfollow: function (title, i) {
                this.loading = true

                this.unfollowMovie(this.$store.getters.id, title).then(() => {
                    this.following.splice(i, 1, false)
                    console.log('success', this.following[i])
                    this.loading = false
                }).catch(error => {
                    this.following.splice(i, 1, true)
                    console.error(error)
                    this.loading = false
                })
            },

            determineFollowedMovies: function () {
                if (!this.followed || !this.movies)
                    return

                let following = []
                let followedTitles = this.followed.movies

                this.movies.forEach((movie) => {
                    following.push(followedTitles.includes(movie.title))
                })
                console.log()

                this.following = following
            },
            redirectToMovieDetails: function (movie) {
                this.$router.push('/details/' + movie.id)
            }
        },
        watch: {
            movies: {
                handler: function () {
                    this.determineFollowedMovies()
                },
                immediate: true,
                deep: true
            },
            followed: {
                handler: 'determineFollowedMovies',
                immediate: true,
                deep: true
            }
        },
        computed: {
            followed: function () { return this.$store.getters.following },
            loggedIn: function () { return this.$store.getters.isLoggedIn }
        }
    }
</script>
<style>
    .row-style {
        flex-wrap: nowrap !important;
        overflow: auto;
        width: 100vw !important;
        margin-right: 5vw;
        background: #1E1E1E;
        padding-top: 10px;
        padding-left: 40px;
        padding-bottom: 10px;
        padding-right: 10px;
    }

    .col-style {
        padding: 0 !important;
    }

    v-card {
        padding: 20px !important;
    }

    .title {
        font-size: 12px !important;
    }

    .spacing {
        height: 8vh;
        line-height: 8vh;
        padding-left: 2vw;
    }

    .subtitle {
        font-size: 25px;
        text-align: left;
    }
</style>