<template>
    <v-app-bar app dark>
        <div class="d-flex align-center">
            <h1><router-link to="/" class="remove-link-styles">Cinephile</router-link></h1>
        </div>

        <div class="left-aligned-links">
            <v-btn to="/stars" text>
                Stars
            </v-btn>

            <v-btn to="/genres" text>
                Genres
            </v-btn>
        </div>

        <v-spacer></v-spacer>

        <div v-if="!isLoggedIn">
            <v-btn to="/login" text>
                Login
            </v-btn>
        </div>
        <div v-else>
            <v-btn text :to="getProfileRoute()">
                Profile
            </v-btn>
            <v-btn text @click="logoutAndAlert">
                Log out
            </v-btn>
        </div>
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
            },
            getProfileRoute: function () {
                return '/profile/' + this.$store.getters.id
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

    .left-aligned-links {
        margin-left: 2vw;
    }
</style>