<template>
  <div>
    <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 16px;">
      <div style="display: flex; align-items: center;">
        <div class="searchbar">
          <input type="text" v-model="searchTerm" @keyup="updateSearchTerm" placeholder="Search" @focus="setFocus" @blur="removeFocus"/>
          <img v-if="!focus" src="/icons/search.svg">
        </div>
        <p class="no-margin-top no-margin-bottom margin-left margin-right">in</p>
        <div>
          <select v-model="searchingIn" @change="resetSearchParams" name="filter-resource" id="filter-resource">
            <option value="folders">Folders</option>
            <option value="snippets">Snippets</option>
          </select>
        </div>
      </div>
      <a :href="buttonLocation" class="button--cta-new">NEW {{ resourceName }}</a>
    </div>
    <folders v-if="isSearchingInFolders" :key="1234"></folders>
    <snippets v-if="!isSearchingInFolders" :key="5678"></snippets>
  </div>
</template>

<script>
import Card from './card'
import Folders from './folders'
import Snippets from './snippets'
import Snipt from './snipt'
import SnippetPreview from './snippet-preview'

import _ from 'lodash'

import { EventBus } from './event-bus.js';

export default {
  components: { Card, Folders, Snipt, Snippets, SnippetPreview },

  props: {
    in: { required: true, type: String }
  },

  data() {
    return {
      snippetz: this.snippets,
      searchingIn: this.in,
      searchTerm: '',
      focus: false,
    }
  },

  computed: {
    isSearchingInFolders() {
      return this.searchingIn === 'folders';
    },

    header() {
      if (this.isSearchingInFolders) {
        return `Folders`
      } else {
        return `Filed Snippets`;
      }
    },

    buttonLocation() {
      if (this.isSearchingInFolders) {
        return "/folders/new"
      } else {
        return "/snippets/new";
      }
    },

    resourceName() {
      if (this.isSearchingInFolders) {
        return "FOLDER"
      } else {
        return "SNIPPET";
      }
    }
  },

  methods: {
    updateSearchTerm: _.debounce(function(e) {
      const params = {
        search_term: this.searchTerm,
        page: 1,
        per_page: 20
      }

      this.$store.commit('updateSearchParams', params)
      EventBus.$emit('search', true)
    }, 400),

    setFocus() {
      this.focus = true;
    },

    removeFocus() {
      this.focus = false;
    },

    resetSearchParams() {
      this.searchTerm = '';
      this.$store.commit('resetSearchParams');
    }
  }
}
</script>

<style scoped>
#filter-resource {
  padding: 6px;
  font-size: 16px;
  background-color: white;
  border-radius: 5px;
  border: 1px solid #DEF2F1;
  font-family: Helvetica, sans-serif;
  font-weight: 100;
}
</style>
