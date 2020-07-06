<template>
  <div>
    <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px; padding: 0px 8px;">
      <h2 class="no-margin">{{ folderz.length }} Folders</h2>
      <div class="searchbar">
        <input type="text" v-model="searchTerm" placeholder="Search folders" @focus="setFocus" @blur="removeFocus"/>
        <img v-if="!focus" src="/icons/search.svg">
      </div>
    </div>
    <folder-row v-for="(row, index) in folderRows" :folders="row" :key="`${index}${Math.random()}`"></folder-row>
  </div>
</template>

<script>
import FolderRow from './folder-row'
import { EventBus } from './event-bus.js';

export default {
  components: { FolderRow },

  props: {
    folders: { type: Array, required: true }
  },

  data() {
    return {
      searchTerm: '',
      folderz: this.folders,
      focus: false,
    }
  },

  created() {
    EventBus.$on('folderDeleted', this.handleFolderDeletion)
  },

  computed: {
    filteredFolders() {
      const lowerSearchTerm = this.searchTerm.toLowerCase();

      return this.folderz.filter(folder => {
        return folder.name.toLowerCase().includes(lowerSearchTerm);
      });
    },

    folderRows() {
      let rows = [];
      let currentRow = [];
      let n = 1;

      this.filteredFolders.forEach(folder => {
        currentRow.push(folder);

        if (n % 3 === 0) {
          rows.push(currentRow);
          currentRow = [];
        }

        if (n === this.filteredFolders.length) {
          if (currentRow.length > 0) { rows.push(currentRow); };
        } else {
          n++
        }
      })

      return rows;
    }
  },

  methods: {
    handleFolderDeletion(folderId) {
      this.folderz = this.folderz.filter(folder => {
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
