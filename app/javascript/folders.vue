<template>
  <div>
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
      folderz: this.folders
    }
  },

  created() {
    EventBus.$on('folderDeleted', this.handleFolderDeletion)
  },

  computed: {
    folderRows() {
      let rows = [];
      let currentRow = [];
      let n = 1;
      console.log('folders', this.folderz)
      this.folderz.forEach(folder => {
        currentRow.push(folder);

        if (n % 3 === 0) {
          rows.push(currentRow);
          currentRow = [];
        }

        if (n === this.folderz.length) {
          console.log('row', currentRow)
          if (currentRow.length > 0) { rows.push(currentRow); };
        } else {
          n++
        }
      })
      console.log('rows', rows)
      return rows;
    }
  },

  methods: {
    handleFolderDeletion(folderId) {
      console.log('id', folderId)
      this.folderz = this.folderz.filter(folder => {
        console.log(folder.id === folderId)
        return folder.id !== folderId
      })
    }
  }
}
</script>
