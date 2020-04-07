import Vuex from "vuex";

import Vue from 'vue'

Vue.use(Vuex);

export const store = new Vuex.Store({
    state: {
        user: {},
        token: localStorage.getItem('token') || '',
        status: null   // Login state
    },
    mutations: {
        setUserId: (state, userId) => {
            state.userId = userId;
        },
        setHrExpertName: (state, hrExpertName) => {
            state.hrExpertName = hrExpertName;
        }
    },
    getters: {
        userAuthenticated: state => {
            return state.userId !== "";
        },
        hrExpertAuthenticated: state => {
            return state.hrExpertName !== "";
        }
    }
});
