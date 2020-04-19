import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex';

Vue.use(Vuex);

export const store = new Vuex.Store({
  state: {
    currentUser: undefined,
  },
  mutations: {
    setCurrentUser(state, currentUser) {
      if (currentUser) {
        state.currentUser = currentUser;
      }
    }
  }
});
