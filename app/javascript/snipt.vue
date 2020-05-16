<template>
  <div>
    <modal v-if="showModal" header="Move Snippet" @close="closeModal">
      <move-snippet slot="body" :snippet="snippet" :current-folder="currentFolder"></move-snippet>
    </modal>

    <div class="snippets--list-item--wrapper">
      <a class="snippets--list-item" :href="snippetPath">
        <div class="snippets--list-item--title-wrapper">
          <span class="snippets--list-item--title-link">{{ snippet.description }}</span>
          <div style="display: flex; align-items: center; position: relative;">
            <span class="language-tag">{{ snippet.language }}</span>
            <!-- TODO: Pass event and make popover global rather than using template like this -->
            <popover :options="snippetOpts"></popover>
          </div>
        </div>
        <div class="snippets--list-item--author-wrapper">
        </div>
        <div class="snippets--list-item--social-wrapper">
          <div>
            <span style="font-size: 14px; color: grey;">{{ snippet.user.name }} <span style="margin: 0px 5px;">|</span> {{ snippet.created_at }}</span>
          </div>
          <div style="display: flex; align-items: center;">
            <img style="margin-left: 12px; margin-bottom: 2px;" src="/icons/heart.svg" width="14">
            <span style="font-size: 12px; margin-left: 4px;">{{ snippet.likes_count }}</span>
            <img style="margin-left: 12px; margin-bottom: 2px;" src="/icons/star.svg" width="14">
            <span style="font-size: 12px; margin-left: 4px;">{{ snippet.likes_count }}</span>
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
import MoveSnippet from './move-snippet';

import snippetsMixin from './mixins/snippetsMixin';

import { EventBus } from './event-bus.js';

export default {
  components: { MoreButton, MoveSnippet, Modal, Popover },

  mixins: [snippetsMixin],

  props: {
    snippet: { required: true, type: Object },
    currentFolder: { required: true, type: Object },
  },

  data() {
    return {
      snippetOpts: [
        { title: 'Move to...', func: this.moveSnippet, confirmable: false },
        { title: 'Delete snippet', func: this.delete, confirmable: true }
      ],
      showModal: false,
    }
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
      EventBus.$emit('present', {
        title: 'Delete Snippet',
        message: 'Are you sure you want to delete this snippet?',
        confirm: 'DELETE',
        onConfirm: this.handleDeleteConfirm
      })
    },

    handleDeleteConfirm() {
      this.deleteSnippet(this.snippet.id)
        .then(res => {
          this.$emit('deleted', this.snippet.id)
        })
        .catch(error => {
          console.log('error', error.response)
        })
    },

    closeModal() {
      this.showModal = false;
    }
  }
}
</script>
