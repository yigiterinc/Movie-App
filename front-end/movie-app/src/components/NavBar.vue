<template>
    <v-app-bar app dark>
        <div class="d-flex align-center">
            <h1><router-link to="/" class="remove-link-styles">Cinephile</router-link></h1>
        </div>

        <v-spacer></v-spacer>

        <v-btn to="/" text>
            Home
        </v-btn>
        <v-btn v-if="!isLoggedIn" to="/login" text>
            Login
        </v-btn>
        <v-btn v-else text v-on:click="logoutAndAlert">
            Log out
        </v-btn>
    </v-app-bar>
</template>

<script>
    import { mapGetters, mapActions } from 'vuex'

    export default {
        name: "NavBar",

        methods: {
            ...mapActions(['logout']),

            logoutAndAlert: function() {
                this.$swal('Info', 'Logged out', 'info')
                this.logout()
            }
        },

        computed: {
            ...mapGetters(['isLoggedIn'])
        }
    }
</script>

<style scoped lang="scss">
.remove-link-styles {
    text-decoration: none;
    color: #1ba0c3;

    :visited {
        color: #1ba0c3;
    }
}
</style>