<template>
  <card>
    <modal v-if="showModal" header="Move Snippet" @close="closeModal">
      <action-snippet
        slot="body"
        :snippet="snippet"
        :confirm-action="folderConfirm"
        confirm-text="MOVE SNIPPET">
      </action-snippet>
    </modal>

    <a class="snippet-preview--container" :href="snippetUrl">
      <div class="snippet-preview--author-wrapper">
        <user-preview :user="snippet.user" :date="snippet.created_at"/>
        <div>
          <div style="display: flex; flex-direction: column;">
            <div style="display: flex; justify-content: flex-end; margin-bottom: 8px; align-items: center;">
              <span class="language-tag">{{ snippet.language }}</span>
              <!-- TODO: Pass event and make popover global rather than using template like this -->
              <div v-if="actionable" @click.prevent="displayPopover" class="more-button">
                <img src="/icons/more.svg" width="12">
              </div>
            </div>
            <action-button-bar :snippet="snippet"></action-button-bar>
          </div>
        </div>
      </div>
      <p class="snippet-preview--description">{{ snippet.description }}</p>
      <div style="display: flex; flex-direction: column;">
        <code-highlight class="snippet-preview--content" :highlighted-code="snippet.highlighted_body"></code-highlight>
      </div>
    </a>
  </card>
</template>

<script>
import ActionButtonBar from './action-button-bar';
import ActionSnippet from './action-snippet';
import CodeHighlight from './code-highlight';
import Card from './card';
import SnippetHeader from './snippet-header';
import UserPreview from './user-preview';
import Modal from './modal';
import MoreButton from './more-button';
import Popover from './popover';

import snippetsMixin from './mixins/snippetsMixin';
import foldersMixin from './mixins/foldersMixin';

import { EventBus } from './event-bus.js';

export default {
  components: {
    ActionButtonBar,
    CodeHighlight,
    Card,
    SnippetHeader,
    UserPreview,
    ActionSnippet,
    Modal,
    Popover,
    MoreButton
  },

  mixins: [snippetsMixin, foldersMixin],

  props: {
    snippet: { type: Object, required: true },
    actionable: { type: Boolean, default: false }
  },

  data() {
    return {
      showModal: false
    }
  },

  // TODO: Extract this into a class or module that can be reused accross the application
  beforeCreate() {
    this.currentUser = this.$store.state.currentUser;
  },

  computed: {
    snippetHTML() {
      return `
        <div class="snippet-preview--content">
          ${this.snippet.highlighted}
        </div>
      `
    },

    snippetUrl() {
      return `/snippets/${this.snippet.id}`
    },

    // popoverOptions() {
    //   let options = [];

    //   if (this.currentUser.id === this.snippetDup.user.id) {
    //     options.push(
    //       {
    //         title: 'Edit snippet',
    //         action: this.edit
    //       },
    //       {
    //         title: 'Delete snippet',
    //         action: this.delete
    //       }
    //     )
    //   }

    //   return options
    // }
  },

  methods: {
    moveSnippet() {
      this.showModal = true;
    },

    delete() {
      EventBus.$emit('presentAlert', {
        title: 'Delete Snippet',
        message: "Are you sure you want to delete this snippet? You won't be able to undo this.",
        confirm: 'DELETE',
        onConfirm: this.handleDeleteConfirm
      })
    },

    remove() {
      EventBus.$emit('presentAlert', {
        title: 'Remove Snippet',
        message: "Are you sure you want to remove this snippet?",
        confirm: 'REMOVE',
        onConfirm: this.handleRemoveConfirm
      })
    },

    handleDeleteConfirm() {
      this.deleteSnippet(this.snippet.id)
        .then(res => {
          this.$emit('deleted', this.snippet.id)
          EventBus.$emit('presentToast', res.data.message)
        })
        .catch(error => {
          EventBus.$emit('presentToast', error.response.data.message)
        })
    },

    handleRemoveConfirm() {
      this.unfileSnippet(this.snippet.id)
        .then(res => {
          this.$emit('deleted', this.snippet.id)
          EventBus.$emit('presentToast', res.data.message)
        })
        .catch(error => {
          EventBus.$emit('presentToast', error.response.data.message)
        })
    },

    closeModal() {
      this.showModal = false;
    },

    displayPopover(event) {
      event.stopPropagation()

      let popoverOpts = [
        {
          title: 'Move to...',
          action: this.moveSnippet
        }
      ]

      if (this.snippet.user.id === this.currentUser.id) {
        popoverOpts.push({
          title: 'Delete snippet',
          action: this.delete
        })
      } else {
        popoverOpts.push({
          title: 'Remove',
          action: this.remove
        })
      }

      EventBus.$emit('presentPopover', event, popoverOpts)
    },

    folderConfirm(folder) {
      this.updateSnippet(this.snippet.id, { folder_id: folder.id })
        .then(res => {
          EventBus.$emit('closeModal')
          EventBus.$emit('changeSnippetFolder', this.snippet)
          EventBus.$emit('presentToast', res.data.message)
        })
        .catch(console.error)
    }
  }
}
</script>

<style lang="scss">
  .snippet-preview {
    &--container {
      display: block;
      text-decoration: none;
      color: inherit;

      &:hover {
        text-decoration: none;
        cursor: pointer;
      }
    }

    &--author-wrapper {
      display: flex;
      justify-content: space-between;
    }

    &--filename {
      font-family: Helvetica, sans-serif;
      font-size: 14px;
      text-decoration: none;

      &:hover { text-decoration: underline; }
    }

    &--description {
      font-family: Helvetica, sans-serif;
      font-size: 14px;
      color: darkslategrey;
    }

    &--content {
      max-height: 258px;
      overflow-y: scroll;

      &::-webkit-scrollbar { /* WebKit */
        width: 0;
        height: 0;
      }
    }
  }
</style>
