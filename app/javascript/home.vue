<template>
  <div>
    <modal v-if="showModal" @close="closeModal">
      <h3 slot="header">New Snippet</h3>
      <new-snippet :languages="languages" slot="body" />
    </modal>
    <snippet-preview
      v-for="snippet in snippetz"
      :key="snippet.id"
      :snippet="snippet"
    />
  </div>
</template>

<script>
import marked from 'marked'
import Modal from './modal'
import NewSnippet from './new-snippet'
import SnippetPreview from './snippet-preview'

import { EventBus } from './event-bus';

export default {
  components: { Modal, NewSnippet, SnippetPreview },

  props: {
    snippets: { type: Array, required: true },
    languages: { type: Array, required: true }
  },

  data() {
    return {
      showModal: false,
      snippetz: this.snippets
    }
  },

  created() {
    console.log('snippets', this.snippets)

    EventBus.$on('openNewSnippetModal', this.openNewSnippetModal)
  },

  methods: {
    openNewSnippetModal() {
      this.showModal = true
    },

    closeModal(snippet) {
      if (snippet) { this.snippetz.unshift(snippet); };

      this.showModal = false;
    }
  }
}
</script>
