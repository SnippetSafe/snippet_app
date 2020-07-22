<template>
  <div>
    <input class="move-snippet--search" type="search" placeholder="Find a folder..." v-model="filterTerm">
    <div class="move-snippet--list">
      <div v-for="folder in folders" :key="folder.name" :class="classForFolder(folder)" @click="setFolder(folder)">
        <span>{{ folder.name }}</span>
        <img v-if="selectedFolderId === folder.id" src="/icons/checked.svg" width="14">
      </div>
      <loader v-if="foldersForSelect.length === 0" />
    </div>
    <div class="move-snippet--buttons">
      <button @click="closeModal" class="button--cta-cancel">CANCEL</button>
      <button @click="confirmAction(folder)" :class="buttonClass" :disabled="!newFolderDifferentToCurrent">{{ confirmText }}</button>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
import _ from 'lodash';
import snippetsMixin from './mixins/snippetsMixin';
import  { EventBus } from './event-bus';
import Loader from './loader';

export default {
  
  components: { Loader },

  mixins: [snippetsMixin],

  props: {
    snippet: { type: Object, required: true },
    confirmAction: { type: Function, required: true },
    confirmText: { type: String, required: false, default: 'CONFIRM' }
  },

  data() {
    return {
      currentFolder: null,
      foldersForSelect: [],
      folder: null,
      filterTerm: ''
    }
  },

  created() {
    axios.get(`/snippets/${this.snippet.id}/current_folder?ajax=true`)
      .then(res => {
        this.currentFolder = res.data.current_folder
        this.foldersForSelect = res.data.folders
      })
      .catch(console.error)
  },

  computed: {
    folders() {
      return this.foldersForSelect.filter(folder => {
        return folder.name.toLowerCase().includes(this.filterTerm.toLowerCase());
      })
    },

    selectedFolderId() {
      if (this.folder) {
        return this.folder.id;
      } else if (this.currentFolder) {
        return this.currentFolder.id
      } else {
        undefined
      }
    },

    buttonClass() {
      if (this.newFolderDifferentToCurrent) {
        return "button--cta-new";
      } else {
        return "button--cta-disabled"
      }
    },

    newFolderDifferentToCurrent() {
      if (this.currentFolder) {
        return this.folder && this.folder.id !== this.currentFolder.id
      } else {
        return !!this.folder
      }
    },
  },

  methods: {
    classForFolder(folder) {
      if (this.selectedFolderId !== folder.id) {
        return 'move-snippet--item'
      } else {
        return 'move-snippet--item-selected'
      }
    },

    setFolder(folder) {
      if (this.selectedFolderId !== folder.id) {
        this.folder = folder;
      } else {
        this.folder = null;
      }
    },

    closeModal() {
      EventBus.$emit('closeModal')
    }
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
      height: 400px;
      overflow-y: scroll;
      margin: 16px 0px;
      border: 1px solid #DEF2F1;
      border-radius: 2px;
      font-size: 14px;
      scrollbar-width: none; /* Firefox */
      -ms-overflow-style: none;  /* Internet Explorer 10+ */

      &::-webkit-scrollbar { /* WebKit */
        width: 0;
        height: 0;
      }
    }

    &--item {
      padding: 6px 6px;
      display: flex;
      justify-content: space-between;

      // &:nth-child(odd) {background: white}
      // &:nth-child(even) {background: #F2F2F2}

      &:hover {
        cursor: pointer;
        background-color: #DEF2F1;
      }

      &-selected {
        padding: 6px 6px;
        display: flex;
        justify-content: space-between;

        background-color: #ffd8dd;

        &:hover {
          cursor: pointer;
          background-color: #ffd8dd;
        }
      }
    }

    &--buttons {
      display: flex;
      justify-content: flex-end;
    }
  }
</style>
