import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex';

Vue.use(Vuex);

export const store = new Vuex.Store({
  state: {
    currentUser: undefined,
    searchParams: {
      page: 1,
      per_page: 20,
      search_term: ''
    }
  },
  mutations: {
    setCurrentUser(state, currentUser) {
      if (currentUser) {
        state.currentUser = currentUser;
      }
    },

    updateSearchParams(state, newParams) {
      Object.keys(newParams).forEach(key => {
        state.searchParams[key] = newParams[key]
      })
    },

    resetSearchParams(state) {
      state.searchParams = {
        page: 1,
        per_page: 20,
        search_term: ''
      }
    }
  }
});
