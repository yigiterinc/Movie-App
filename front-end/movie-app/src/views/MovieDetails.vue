<template>
    <div class="container movie-container" v-if="movie">
        <div class="movie-container-inner">
            <v-row>
                <v-col cols="1"></v-col>
                <v-col cols="3">
                    <v-img :src="getPosterUrl(this.movie.poster_path)"
                           class="poster"
                           gradient="to bottom, rgba(0,0,0,.1), rgba(0,0,0,.3)">
                    </v-img>
                </v-col>
                <div class="spacing"></div>
                <v-col cols="6">
                    <div class="title">
                        <h2>{{this.movie.title}}</h2>
                        <hr>
                    </div>

                    <p><strong class="subtitle">Release Date: </strong>
                        {{getDateFormatted(this.movie.released)}}
                    </p>
                    <p><strong class="subtitle">Duration: </strong>
                        {{this.movie.runtime}} Min.
                    </p>
                    <p><strong class="subtitle">Average Vote: </strong>
                        {{this.getAverageVoteFormatted(movie.vote_average)}}
                    </p>
                    <p><strong class="subtitle">Budget:</strong>
                        {{this.getNumberFormatted(this.movie.budget)}} $
                    </p>
                    <p v-if="revenueExists(movie)"><strong class="subtitle">Revenue:</strong>
                        {{this.getNumberFormatted(this.movie.revenue)}} $
                    </p>

                    <p><strong class="sutitle">Plot:</strong>
                        {{this.movie.plot}}
                    </p>
                </v-col>
            </v-row>
        </div>
    </div>
</template>

<script>
    import ServicesMixin from '../mixins/services-mixin'
    import UtilsMixin from '../mixins/utils-mixin'

    export default {
        name: "MovieDetails",
        mixins: [ServicesMixin, UtilsMixin],
        data() {
            return {
                movie: {}
            }
        },
        created() {
            const movieId = this.$route.params.id
            this.getMovie(movieId).then(movie => {
                console.log(movie)
                this.movie = movie
            })
        },
        methods: {
            getAverageVoteFormatted: function (voteAverage) {
                return parseFloat(voteAverage).toPrecision(2) + " / 10.0"
            },
            revenueExists: function () {
                return this.movie.revenue > 0
            },
            getDateFormatted: function (date) {
                const split = date.split("-")
                return split[1] + "." + split[2] + "." + split[0]
            },
            getNumberFormatted: function (x) {
                return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            }
        }
    }
</script>

<style scoped>
    .poster {
        height: auto;
        width: auto;
        max-height: 60vh;
        max-width: 40vh;
        border-radius: 5%
    }

    .movie-container {
        margin-top: 2vh;
        padding-top: 3vh;
        padding-left: 2vw;
        padding-right: 3vw;
    }

    .title  {
        margin-bottom: 20px;
    }

    .subtitle {
        font-size: 20px
    }

    .movie-container-inner p {
        font-size: 18px;
    }
</style>