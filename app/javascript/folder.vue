<template>
    <div class="folders--list-item-wrapper">
      <modal v-if="showModal" header="Rename Folder" @close="closeModal">
        <div slot="body">
          <input v-model="newName" type="text">
          <div class="move-snippet--buttons">
            <button @click="closeModal" class="button--cta-cancel">CANCEL</button>
            <button @click="renameFolder" :class="buttonClass">RENAME FOLDER</button>
          </div>
        </div>
      </modal>

      <div @mouseenter="loadPreview" @mouseleave="dismissPreview" class="folders--list-item-wrapper-container">
        <div class="folders--list-item">
          <div @click.prevent="displayPopover" class="more-button" style="position: absolute; top: 4px; right: 4px;">
            <img src="/icons/more.svg" width="12">
          </div>
          <a :href="folderPath" class="folders--list-item--link" :title="folderTitle">
            <span class="folders--snippet-count">{{ folderDup.snippet_count }}</span>
            <img class="folders--snippet-icon" src="/icons/folder-1.svg" width="28">
            <span class="folders--list-item--title">{{ folderDup.name }}</span>
            <img v-if="loadingPreview" class="preview-loader" src="/icons/loader-grey.svg" width="28">
          </a>
        </div>
        <div v-if="(folderDup.recent_snippets.length > 0) && viewPreview" class="preview-popover">
          <a v-for="snippet in folderDup.recent_snippets" :href="snippetPath(snippet)" class="preview-wrapper" :title="snippet.description" :key="snippet.id">
            <div style="display: flex; justify-content: space-between;">
              <span class="language-tag">{{ snippet.language }}</span>
              <span class="date-tag">Just now</span>
            </div>
            <span style="display: block; font-size: 14px; margin-top: 4px;">{{ snippet.description.substring(0, 78) }}...</span>
          </a>
        </div>
        <div v-else-if="(folderDup.recent_snippets.length === 0) && viewPreview" class="preview-popover">
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
import Modal from './modal';
import Popover from './popover';
import _ from 'lodash';
import { EventBus } from './event-bus.js';
import foldersMixin from './mixins/foldersMixin';

export default {
  components: { Modal, Popover },

  mixins: [foldersMixin],

  props: {
    folder: { required: true, type: Object }
  },

  data() {
    return {
      viewPreview: false,
      loadingPreview: false,
      showModal: false,
      folderDup: this.folder,
      newName: this.folder.name
    }
  },

  computed: {
    folderPath() {
      return `/folders/${this.folder.id}`
    },

    folderTitle() {
      return `Open folder - ${this.folder.name}`;
    },

    buttonClass() {
      if (this.validNewName) {
        return "button--cta-new";
      } else {
        return "button--cta-disabled"
      }
    },

    validNewName() {
      return (this.newName !== this.folderDup.name) && (this.newName.length > 0)
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

      let popoverOpts = [
        {
          title: 'Add snippet',
          action: this.navigateToNewSnippetPage
        },
        {
          title: 'Rename folder',
          action: () => { this.showModal = true; }
        }
      ]

      if (this.folder.snippet_count === 0) {
        popoverOpts.push(
          {
            title: 'Delete folder',
            action: this.triggerDeleteAlert
          }
        )
      }

      EventBus.$emit('presentPopover', event, popoverOpts)
    },

    triggerDeleteAlert() {
      EventBus.$emit('presentAlert', {
        title: 'Delete Folder',
        message: "Are you sure you want to delete this folder? You won't be able to undo this.",
        confirm: 'DELETE',
        onConfirm: this.handleDeleteConfirm
      })
    },

    closeModal() {
      this.showModal = false;
    },

    handleDeleteConfirm() {
      this.deleteFolder(this.folder.id)
        .then(res => {
          EventBus.$emit('folderDeleted', this.folder.id)
          EventBus.$emit('presentToast', res.data.message)
        })
        .catch(error => {
          console.log(error)

          EventBus.$emit('presentToast', error.response.data.message)
        })
    },

    renameFolder() {
      if (this.validNewName) {
        const params = { name: this.newName };

        this.updateFolder(this.folder.id, params)
          .then(res => {
            this.folderDup.name = this.newName;
            this.closeModal();
            EventBus.$emit('presentToast', res.data.message)
          })
          .catch(error => {
            EventBus.$emit('presentToast', error.response.data.message)
          })
      }
    },

    navigateToNewSnippetPage() {
      window.location.href = `/snippets/new?folder_id=${this.folderDup.id}&redirect_url=/folders`
    }
  }
}
</script>
