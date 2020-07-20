<template>
  <div>
    <folder-row v-for="(row, index) in folderRows" :folders="row" :key="`${index}${Math.random()}`"></folder-row>
  </div>
</template>

<script>
import axios from 'axios';
import  { EventBus } from './event-bus';
import searchMixin from './mixins/searchMixin';
import FolderRow from './folder-row'

export default {
  components: { FolderRow },

  mixins: [searchMixin],

  data() {
    return {
      resourceName: 'folders'
    }
  },

  computed: {
    folderRows() {
      let rows = [];
      let currentRow = [];
      let n = 1;

      this.items.forEach(folder => {
        currentRow.push(folder);

        if (n % 3 === 0) {
          rows.push(currentRow);
          currentRow = [];
        }

        if (n === this.items.length) {
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
      this.items = this.items.filter(folder => {
        return folder.id !== folderId
      })
    }
  }
}
</script>
