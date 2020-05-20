<template>
  <div class="folders--list-item-wrapper">
    <div @mouseenter="loadPreview" @mouseleave="dismissPreview" class="folders--list-item-wrapper-container">
      <div class="folders--list-item">
        <div @click.prevent="displayPopover" class="more-button" style="position: absolute; top: 4px; right: 4px;">
          <img src="/icons/more.svg" width="12">
        </div>
        <a :href="folderPath" class="folders--list-item--link" :title="folderTitle">
          <span class="folders--snippet-count">{{ folder.snippet_count }}</span>
          <img class="folders--snippet-icon" src="/icons/folder-1.svg" width="28">
          <span class="folders--list-item--title">{{ folder.name }}</span>
          <img v-if="loadingPreview" class="preview-loader" src="/icons/loader-grey.svg" width="28">
        </a>
      </div>
      <div v-if="(folder.recent_snippets.length > 0) && viewPreview" class="preview-popover">
        <a v-for="snippet in folder.recent_snippets" :href="snippetPath(snippet)" class="preview-wrapper" :title="snippet.description" :key="snippet.id">
          <div style="display: flex; justify-content: space-between;">
            <span class="language-tag">{{ snippet.language }}</span>
            <span class="date-tag">Just now</span>
          </div>
          <span style="display: block; font-size: 14px; margin-top: 4px;">{{ snippet.description.substring(0, 78) }}...</span>
        </a>
      </div>
      <div v-else-if="(folder.recent_snippets.length === 0) && viewPreview" class="preview-popover">
        <a :href="newSnippetPath({ folder_id: folder.id, redirect_url: '/folders' })" class="preview-wrapper" style="display: flex; justify-content: center;">
          <img src="/icons/edit.svg" width="20">
          <div style="display: flex; flex-direction: column; justify-content: center; margin-left: 8px;">
            <span style="font-size: 14px; display: block;">Add snippet</span>
          </div>
        </a>
      </div>
    </div>
  </div>
</template>

<script>
import Popover from './popover';
import _ from 'lodash';
import { EventBus } from './event-bus.js';
import foldersMixin from './mixins/foldersMixin';

export default {
  components: { Popover },

  mixins: [foldersMixin],

  props: {
    folder: { required: true, type: Object }
  },

  data() {
    return {
      viewPreview: false,
      loadingPreview: false
    }
  },

  computed: {
    folderPath() {
      return `/folders/${this.folder.id}`
    },

    folderTitle() {
      return `Open folder - ${this.folder.name}`;
    }
  },

  methods: {
    snippetPath(snippet) {
      return `/snippets/${snippet.id}`
    },
    // TODO: Use the params
    newSnippetPath(opts = {}) {
      return `/snippets/new`
    },

    loadPreview() {
      this.loadingPreview = true;

      this.openPreview()
    },

    openPreview: _.debounce(function(e) {
      if (this.loadingPreview) { this.viewPreview = true; };
      this.loadingPreview = false;
    }, 400),

    dismissPreview() {
      this.loadingPreview = false;
      this.viewPreview = false
    },

    displayPopover(event) {
      event.stopPropagation()

      const popoverOpts = [
        {
          title: 'Delete folder',
          action: this.triggerDeleteAlert
        }
      ]

      EventBus.$emit('presentPopover', event, popoverOpts)
    },

    triggerDeleteAlert() {
      EventBus.$emit('presentAlert', {
        title: 'Delete Folder',
        message: 'Are you sure you want to delete this folder?',
        confirm: 'DELETE',
        onConfirm: this.handleDeleteConfirm
      })
    },

    handleDeleteConfirm() {
      this.deleteFolder(this.folder.id)
        .then(res => {
          this.$emit('deleted', this.folder.id)
          console.log('res', res)
          EventBus.$emit('presentToast', res.data.message)
        })
        .catch(error => {
          console.log(error)

          EventBus.$emit('presentToast', error.response.data.message)
        })
    }
  }
}
</script>
