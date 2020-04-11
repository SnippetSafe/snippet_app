<template>
  <div>
    <modal v-if="showModal" @close="closeModal">
      <h3 slot="header">New Snippet</h3>
      <new-snippet :languages="languages" slot="body" />
    </modal>
    <button @click="showModal = true">New Snippet</button>
    <h1>Latest Snippets</h1>
    <div v-for="snippet in snippetz" :key="snippet.id" style="border-bottom: 1px solid lightgrey; padding: 16px;">
      <div style="display: flex;">
        <img style="border-radius: 50%;" src="https://www.rawlinsdavy.com/wp-content/uploads/2018/12/profile-placeholder-300x300.png" height="48" width="48" />
        <div style="margin-left: 12px; margin-top: 8px;">
          <span style="display: block; font-weight: bold; font-size: 14px;">Lydia Firminger</span>
          <span style="display: block; font-size: 12px;">Javascript</span>
        </div>
      </div>
      <p>{{ snippet.description }}</p>
      <div v-html="snippet.highlighted"></div>
    </div>
  </div>
</template>

<script>
import marked from 'marked'
import Modal from './modal'
import NewSnippet from './new-snippet'

export default {
  components: { Modal, NewSnippet },

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
  },

  methods: {
    compiledMarkdown(markdown) {
      return marked(markdown);
    },

    closeModal(snippet) {
      if (snippet) {
        this.snippetz.unshift(snippet);
      }

      this.showModal = false;
    }
  }
}
</script>
