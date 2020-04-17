<template>
  <div class="home">
    <Scroll-Cards v-if="isLoggedIn" label="Recommended for you" :movies="recommendations"
                  :keyVal="popularMovies.length + moviesInTheatre.length"/>
    <Scroll-Cards label="Popular Movies" :movies="popularMovies" :keyVal="0" />
    <Scroll-Cards label="In Theatres" :movies="moviesInTheatre" :keyVal="popularMovies.length"/>
  </div>
</template>

<script>

  import ServicesMixin from "../mixins/services-mixin"
  import ScrollCards from "../components/ScrollCards";
  import {mapGetters} from "vuex";

  export default {
  name: 'Home',
  mixins: [ServicesMixin],
  data() {
    return {
      popularMovies: [],
      moviesInTheatre: [],
      recommendations: [],
    }
  },
  components: {
    ScrollCards
  },
  computed:  {
    ...mapGetters(['isLoggedIn'])
  },
  created() {
    this.fetchPopularMovies().then(response => {
      const data = response.response.table.results

      data.forEach(entry => {
        this.popularMovies.push(entry.table)
      })
    })

    this.fetchInTheatre().then(response => {
      const data = response.response.table.results

      data.forEach(entry => {
        this.moviesInTheatre.push(entry.table)
      })
    })

    function fillRecommendations(response) {
      this.recommendations = response.response.map(recommendation => {
        return {
          id: recommendation.table.id,
          title: recommendation.table.title,
          release_date: recommendation.table.release_date,
          poster_path: recommendation.table.poster_path
        }
      })
    }

    if (this.isLoggedIn) {
      this.fetchRecommendations(this.$store.getters.id).then(response => {
        fillRecommendations.call(this, response);
      })
    }
  }
}
</script>

<style>

  v-card {
    padding: 20px !important;
  }

</style>
