<template>
  <v-app>
    <NavBar></NavBar>
    <v-content>
      <router-view/>
    </v-content>
  </v-app>
</template>

<script>
  import NavBar from './components/NavBar'

export default {
  name: 'App',

  components: {
    NavBar
  },

  data: () => ({
  }),

};
</script>
