<template>
  <div>
    <folder-row v-for="(row, index) in folderRows" :folders="row" :key="`${index}${Math.random()}`"></folder-row>
    <img style="display: block; margin: 0 auto;" v-if="isFirstLoad" src="/icons/loader-grey.svg" width="50">
  </div>
</template>

<script>
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
}
</script>
