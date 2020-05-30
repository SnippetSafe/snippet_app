<template>
  <div>
    <modal v-if="showModal" header="Move Snippet" @close="closeModal">
      <action-snippet
        slot="body"
        :snippet="snippet"
        :current-folder="currentFolder"
        :confirm-action="folderConfirm"
        confirm-text="MOVE SNIPPET">
      </action-snippet>
    </modal>

    <div class="snippets--list-item--wrapper">
      <a class="snippets--list-item" :href="snippetPath">
        <div class="snippets--list-item--title-wrapper">
          <span class="snippets--list-item--title-link">{{ snippet.description }}</span>
          <div style="display: flex; align-items: center; position: relative;">
            <span class="language-tag">{{ snippet.language }}</span>
            <!-- TODO: Pass event and make popover global rather than using template like this -->
            <div @click.prevent="displayPopover" class="more-button">
              <img src="/icons/more.svg" width="12">
            </div>
          </div>
        </div>
        <div class="snippets--list-item--author-wrapper">
        </div>
        <div class="snippets--list-item--social-wrapper">
          <div style="display: flex; align-items: center;">
            <img style="border-radius: 50%; margin-right: 10px;" src="https://media-exp1.licdn.com/dms/image/C4E03AQG0MUNjxFvBTw/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=WnnJ_Q6MpQFur5Uev2iqeLAnoX6Rdb1Bv6RoAijK3tA" height="24" width="24" />
            <span style="font-size: 14px; color: grey;">{{ snippet.user.name }} <span style="margin: 0px 5px;">|</span> {{ snippet.created_at }}</span>
          </div>
          <div style="display: flex; align-items: center;">
            <img style="margin-left: 10px; margin-bottom: 2px;" src="/icons/heart.svg" width="14">
            <span style="font-size: 12px; margin-left: 4px;">{{ snippet.likes_count }}</span>
            <img style="margin-left: 10px; margin-bottom: 2px;" src="/icons/comment.svg" width="14">
            <span style="font-size: 12px; margin-left: 4px;">{{ snippet.comments_count }}</span>
            <img style="margin-left: 10px; margin-bottom: 2px;" src="/icons/star.svg" width="14">
            <span style="font-size: 12px; margin-left: 4px;">0</span>
          </div>
        </div>
      </a>
    </div>
  </div>
</template>

<script>
import MoreButton from './more-button';
import Popover from './popover';
import Modal from './modal';
import ActionSnippet from './action-snippet';

import snippetsMixin from './mixins/snippetsMixin';
import foldersMixin from './mixins/foldersMixin';

import { EventBus } from './event-bus.js';
import { store } from './store';

export default {
  components: { MoreButton, ActionSnippet, Modal, Popover },

  mixins: [snippetsMixin, foldersMixin],

  props: {
    snippet: { required: true, type: Object },
    currentFolder: { required: true, type: Object },
  },

  data() {
    return {
      showModal: false
    }
  },

  created() {
    console.log('nippet', this.snippet)
  },

  // TODO: Extract this into a class or module that can be reused accross the application
  beforeCreate() {
    this.currentUser = this.$store.state.currentUser;
  },

  computed: {
    snippetPath() {
      return `/snippets/${this.snippet.id}`;
    }
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
      this.unfileSnippet(this.currentFolder.id, this.snippet.id)
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
