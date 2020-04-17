export default {
    methods: {
        getPosterUrl: function (posterPath) {
            return 'http://image.tmdb.org/t/p/original' + posterPath
        }
    }
}