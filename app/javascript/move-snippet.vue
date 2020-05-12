<template>
  <div>
    <input class="move-snippet--search" type="search" placeholder="Find a folder..." v-model="filterTerm">
    <div class="move-snippet--list">
      <div v-for="folder in folders" :key="folder.name" :class="classForFolder(folder)" @click="setFolder(folder)">
        <span>{{ folder.name }}</span>
      </div>
    </div>
    <div class="move-snippet--buttons">
      <button class="button--cta-new">MOVE SNIPPET</button>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import _ from 'lodash';
import snippetsMixin from './mixins/snippetsMixin';

export default {
  mixins: [snippetsMixin],

  props: {
    snippet: { type: Object, required: true }
  },

  data() {
    return {
      foldersForSelect: [],
      folder: null,
      filterTerm: ''
    }
  },

  computed: {
    folders() {
      return this.foldersForSelect.filter(folder => {
        return folder.name.toLowerCase().includes(this.filterTerm.toLowerCase());
      })
    },

    selectedFolderName() {
      if (this.folder) { return this.folder.name; };
    }
  },

  methods: {
    classForFolder(folder) {
      if (this.selectedFolderName !== folder.name) {
        return 'move-snippet--item'
      } else {
        return 'move-snippet--item-selected'
      }
    },

    setFolder(folder) {
      if (this.selectedFolderName !== folder.name) {
        this.folder = folder;
      } else {
        this.folder = null;
      }
    }
  },

  created() {
    axios.get('/folders')
      .then(res => {
        console.log(res)

        console.log('folders', this.folders)
        this.foldersForSelect = res.data.folders

        console.log('folders', this.folders)
      })
      .catch(console.error)
  },
}
</script>

<style lang="scss">
  .move-snippet {
    &--search {
      width: 100%;
      box-sizing: border-box;
      border-radius: 2px;
      padding: 8px;
      border: 1px solid #DEF2F1;
      font-family: Helvetica, sans-serif;
      font-size: 14px;
      font-weight: 100;

      &:focus { outline: none; }
    }

    &--list {
      max-height: 200px;
      min-height: 200px;
      overflow-y: scroll;
      margin: 16px 0px;
      border: 1px solid #DEF2F1;
      border-radius: 2px;
      font-size: 14px;
    }

    &--item {
      padding: 6px 6px;

      &:nth-child(odd) {background: #F2F2F2}
      &:nth-child(even) {background: white}

      &:hover {
        cursor: pointer;
        background-color: #DEF2F1;
      }

      &-selected {
        padding: 6px 6px;

        background-color: pink;

        &:hover {
          cursor: pointer;
          background-color: pink;
        }
      }
    }

    &--buttons {
      display: flex;
      justify-content: flex-end;
    }
  }
</style>
