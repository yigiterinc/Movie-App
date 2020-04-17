<template>
    <div class="container">
        <v-container v-for="(row, j) in genres" fluid :key="j">
            <v-row :key="j" justify="center">
                <v-col v-for="(genre, i) in row" cols="3" :key="i">
                    <v-card max-width="280">
                        <div>
                            <v-list-item>
                                <v-list-item-content>
                                    <v-list-item-title><h3 class="name">{{ genre.name }}</h3></v-list-item-title>
                                </v-list-item-content>
                            </v-list-item>
                            <img :src="genre.poster_path"
                                   class="white--text align-end genre-poster"
                                   gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.5)">
                        </div>

                        <v-card-actions>
                            <v-spacer></v-spacer>
                            <div v-if="!loading && loggedIn">
                                <v-btn v-if="following[3 * j + i]" color="error" @click="unfollow(genre.name, i, j)">
                                    Unfollow
                                </v-btn>
                                <v-btn v-else color="primary" @click="follow(genre.name, i, j)">
                                    Follow
                                </v-btn>
                            </div>
                        </v-card-actions>
                    </v-card>
                </v-col>
            </v-row>
        </v-container>
    </div>
</template>
<script>
    import ServicesMixin from '../mixins/services-mixin'

    export default {
        name: 'Genres',
        mixins: [ServicesMixin],
        data() {
            return {
                genres: {},
                following: [],
                done: false,
                loading: false
            }
        },
        methods: {
            follow: function (title, row, col) {
                this.loading = true
                let i = 3 * row + col

                let genre = this.genres[row][col]

                this.followGenre(this.$store.getters.id, title).then(() => {
                    this.following.splice(i, 1, true)
                    console.log('success')
                    this.$store.commit('saveGenre', genre)
                    this.loading = false
                }).catch(error => {
                    this.following.splice(i, 1, false)
                    console.error(error)
                    this.loading = false
                })

                this.loading = false
            },

            unfollow: function (title, row, col) {
                let i = 3 * row + col

                this.loading = true
                this.unfollowGenre(this.$store.getters.id, title).then(() => {
                    this.following.splice(i, 1, false)
                    console.log('success', this.following[i])
                    this.loading = false
                }).catch(error => {
                    this.following.splice(i, 1, true)
                    console.error(error)
                    this.loading = false
                })
            },

            determineFollowedGenres: function () {
                if (!this.followed || !this.genres)
                    return

                let followedGenres = this.followed.genres.map(genre => genre.name)
                this.following = [this.genres.length]

                this.genres.forEach((row, i) => {
                    row.forEach((genre, j) => {
                        this.following[3 * i + j] = followedGenres.includes(genre.name)
                    })
                })

                console.log(this.following)
            }
        },
        watch: {
            genres: {
                handler: function () {
                    this.determineFollowedGenres()
                },
                immediate: true,
                deep: true
            },
            followed: {
                handler: 'determineFollowedGenres',
                immediate: true,
                deep: true
            }
        },
        computed: {
            followed: function () { return this.$store.getters.following },
            loggedIn: function () { return this.$store.getters.isLoggedIn }
        },
        created() {
            this.getGenres().then(genres => {
                function splitIntoNPieces(array, n) {
                    let [...arr]  = array;
                    var res = [];
                    while (arr.length) {
                        res.push(arr.splice(0, n));
                    }
                    return res;
                }

                this.genres = splitIntoNPieces(genres.filter(genre => genre.poster_path != null), 3)
            }).catch(error => {
                console.error(error)
            })
        }
    }
</script>
<style>

    .name {
        text-align: center;
        font-weight: bold;
    }

    .genre-poster {
        max-height: 310px;
        width: 100%;
        height: 100%;
    }
</style>