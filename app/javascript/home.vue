<template>
  <div>
    <modal v-if="showModal" @close="closeModal">
      <h3 slot="header">New Snippet</h3>
      <new-snippet :languages="languages" slot="body" />
    </modal>

    <div style="display: flex;">
      <div style="flex: 1">
        buttons
      </div>
      <div style="flex: 3;">
        <div v-for="snippet in snippetz" :key="snippet.id" style="border-bottom: 1px solid lightgrey; padding: 16px;">
          <div style="display: flex;">
            <img style="border-radius: 50%;" src="https://www.rawlinsdavy.com/wp-content/uploads/2018/12/profile-placeholder-300x300.png" height="48" width="48" />
            <div style="margin-left: 12px; margin-top: 8px;">
              <span style="display: block; font-weight: bold; font-size: 14px; font-family: Helvetica, sans-serif;">Lydia Firminger</span>
              <span style="display: block; font-size: 12px; font-family: Helvetica, sans-serif;">Javascript</span>
            </div>
          </div>
          <p style="font-family: Helvetica, sans-serif; font-size: 14px; color: darkslategrey;">{{ snippet.description }}</p>
          <div style="border: 1px solid lightgrey; background-color: snow; position: relative;" v-html="snippetHTML(snippet)"></div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import marked from 'marked'
import Modal from './modal'
import NewSnippet from './new-snippet'
import Topbar from './topbar'
import { EventBus } from './event-bus';

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

    EventBus.$on('openNewSnippetModal', this.openNewSnippetModal)
  },

  methods: {
    compiledMarkdown(markdown) {
      return marked(markdown);
    },

    snippetHTML(snippet) {
      return `
        ${snippet.language_label}
        <div style="max-height: 258px; overflow: hidden; box-shadow: inset 0px -11px 8px -10px #CCC;">
          ${snippet.highlighted}
        </div>
      `
    },

    openNewSnippetModal() {
      console.log('make the snip')
      this.showModal = true
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
