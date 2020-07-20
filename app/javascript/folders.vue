<template>
  <div>
    <folder-row v-for="(row, index) in folderRows" :folders="row" :key="`${index}${Math.random()}`"></folder-row>
  </div>
</template>

<script>
import axios from 'axios';

import  { EventBus } from './event-bus';

import FolderRow from './folder-row'

export default {
  components: { FolderRow },

  data() {
    return {
      searchTerm: '',
      focus: false,
      hasMoreFolders: true,
      busy: true,
      folders: []
    }
  },

  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
    axios.defaults.headers.common['Accept'] = 'application/json'

    EventBus.$on('folderDeleted', this.handleFolderDeletion)
    EventBus.$on('search', this.getFolders)
    this.getFolders();
  },
  
  destroyed() {
    this.$store.commit('resetSearchParams')
  },

  computed: {
    folderRows() {
      let rows = [];
      let currentRow = [];
      let n = 1;

      this.folders.forEach(folder => {
        currentRow.push(folder);

        if (n % 3 === 0) {
          rows.push(currentRow);
          currentRow = [];
        }

        if (n === this.folders.length) {
          if (currentRow.length > 0) { rows.push(currentRow); };
        } else {
          n++
        }
      })

      return rows;
    }
  },

  methods: {
    getFolders(reset = false) {
      if (reset) {
        this.hasMoreFolders = true;
        this.folders = [];
      }

      if (this.hasMoreFolders) {
        this.busy = true
        let params = this.$store.state.searchParams
  
        axios.get('/folders/search', { params: params })
          .then(res => {
            const returnedSnippets = res.data.folders
  
            if (returnedSnippets.length > 0) {
              this.folders = this.folders.concat(returnedSnippets)
              params.page += 1
              this.$store.commit('updateSearchParams', params)
            } else {
              this.hasMoreFolders = false;
            }
            
            this.busy = false
          })
          .catch(console.error)
      }
    },

    handleFolderDeletion(folderId) {
      this.folders = this.folders.filter(folder => {
        return folder.id !== folderId
      })
    },

    setFocus() {
      this.focus = true;
    },

    removeFocus() {
      this.focus = false;
    }
  }
}
</script>
