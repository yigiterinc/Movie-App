<template>
    <div class="container">
        {{user}}
    </div>
</template>

<script>
    import {mapGetters} from "vuex";

    export default {
        name: "UserProfile",
        data() {
            return {
            }
        },
        components: {

        },
        computed: {
            user: function () {
                return this.$store.getters.user
            },
            ...mapGetters(['isLoggedIn'])
        },
    }
</script>

<style scoped>

</style>