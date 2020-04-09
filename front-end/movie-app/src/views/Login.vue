<template>
  <div id="login">
    <v-app id="inspire">
      <v-content>
        <v-container fluid fill-height>
          <v-layout align-center justify-center>
            <v-flex xs12 sm8 md4>
              <v-card class="elevation-12">
                <v-toolbar color="light-blue darken-1 " flat>
                  <v-toolbar-title class="white--text">Login</v-toolbar-title>
                  <v-spacer></v-spacer>
                </v-toolbar>
                <v-card-text>
                  <v-form>
                    <v-text-field label="Email" name="email"
                                  prepend-icon="person" type="text" v-model="email"></v-text-field>

                    <v-text-field id="password" label="Password" name="password"
                                  prepend-icon="lock" type="password" v-model="password"></v-text-field>
                  </v-form>
                </v-card-text>
                <v-card-actions>
                  <v-spacer></v-spacer>
                  <v-btn v-on:click="this.resetForm"
                         color="light-blue" class="white--text" outlined>Clear</v-btn>
                  <v-btn color="light-blue darken-1" class="white--text">Login</v-btn>
                </v-card-actions>
              </v-card>
            </v-flex>
          </v-layout>
        </v-container>
      </v-content>
    </v-app>
  </div>
</template>

<script>

  export default {
    data() {
      return {
        email: '',
        password: ''
      }
    },
    methods: {
      resetForm: function () {
        this.email = '';
        this.password = '';
      }
    }
  }
</script>
