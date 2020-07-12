<template>
  <card>
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; padding: 0px 8px;">
      <h2 class="no-margin">{{ header }}</h2>
      <div style="display: flex; align-items: center;">
        <div class="searchbar">
          <input type="text" v-model="searchTerm" @keyup="updateSearchTerm" placeholder="Search" @focus="setFocus" @blur="removeFocus"/>
          <img v-if="!focus" src="/icons/search.svg">
        </div>
        <p class="margin-left margin-right">in</p>
        <div>
          <select v-model="searchingIn" name="filter-resource" id="filter-resource">
            <option value="folders">Folders</option>
            <option value="snippets">Snippets</option>
          </select>
        </div>
      </div>
    </div>
    <folders v-if="isSearchingInFolders" :folders="filteredResources"></folders>
    <snippets v-else></snippets>
  </card>
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
    folders: { type: Array, required: true }
  },

  data() {
    return {
      folderz: this.folders,
      snippetz: this.snippets,
      searchingIn: 'folders',
      searchTerm: '',
      focus: false,
    }
  },

  created() {
    EventBus.$on('folderDeleted', this.handleFolderDeletion)
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

    filteredResources() {
      const lowerSearchTerm = this.searchTerm.toLowerCase();

      if (this.isSearchingInFolders) {
        return this.folderz.filter(folder => {
          return folder.name.toLowerCase().includes(lowerSearchTerm);
        });
      }
    },
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
      console.log('params', this.$store.state.searchParams)
    }, 400),

    setFocus() {
      this.focus = true;
    },

    removeFocus() {
      this.focus = false;
    },

    handleSnippetDeletion(snippetId) {
      this.snippetz = this.snippetz.filter(s => {
        return s.id !== snippetId
      })
    },

     handleFolderDeletion(folderId) {
      this.folderz = this.folderz.filter(folder => {
        return folder.id !== folderId
      })
    },
  }
}
</script>

<style scoped>
#filter-resource {
  padding: 6px;
  font-size: 16px;
  background-color: #E6ECF0;
  border-radius: 5px;
  border: 1px solid #DEF2F1;
  font-family: Helvetica, sans-serif;
  font-weight: 100;
}
</style>
