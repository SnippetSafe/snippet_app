<template>
  <div class="snippets--list-item--wrapper">
    <modal v-if="showModal" @close="closeModal">
      <h3 slot="header">Move Snippet</h3>
      <move-snippet slot="body" :snippet="snippet"></move-snippet>
    </modal>
    <a class="snippets--list-item" :href="snippetPath">
      <div class="snippets--list-item--title-wrapper">
        <span class="snippets--list-item--title-link">{{ snippet.description }}</span>
        <div style="display: flex; align-items: center; position: relative;">
          <span class="language-tag">{{ snippet.language }}</span>
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
</template>

<script>
import MoreButton from './more-button';
import Popover from './popover';
import Modal from './modal';
import MoveSnippet from './move-snippet';

export default {
  components: { MoreButton, MoveSnippet, Modal, Popover },

  props: {
    snippet: { required: true, type: Object }
  },

  data() {
    return {
      snippetOpts: [
        { title: 'Move to...', func: this.moveSnippet },
        { title: 'Delete snippet', func: () => { console.log('deleting') } }
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

    closeModal() {
      this.showModal = false;
    }
  }
}
</script>
