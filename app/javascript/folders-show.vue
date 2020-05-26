<template>
  <card>
    <div style="display: flex; justify-content: space-between;">
        <back-button></back-button>
        <h2 style="margin: 2px 0px 0px 12px; display: inline-block;">{{ folder.name }}</h2>
    </div>
    <div v-if="snippetz.length > 0" style="margin-top: 16px;">
      <snipt v-for="snippet in snippetz" @deleted="handleSnippetDeletion" :snippet="snippet" :current-folder="folder" :key="snippet.id"></snipt>
    </div>
    <empty-state v-else :href="newSnippetUrl"></empty-state>
    <div class="folders--options-wrapper">
      <a :href="newSnippetUrl" class="button--cta-new">NEW SNIPPET</a>
    </div>
  </card>
</template>

<script>
import Snipt from './snipt';
import Card from './card'
import BackButton from './back-button'
import EmptyState from './empty-state'

import { EventBus } from './event-bus';

export default {
  components: {
    BackButton,
    Card,
    EmptyState,
    Snipt,
  },

  props: {
    folder: { type: Object, required: true },
    snippets: { type: Array, required: true }
  },

  data() {
    return {
      snippetz: this.snippets
    }
  },

  created() {
    EventBus.$on('changeSnippetFolder', this.handleSnippetFolderChange)
  },

  computed: {
    newSnippetUrl() {
      return `/snippets/new?folder_id=${this.folder.id}&redirect_url=/folders/${this.folder.id}`
    }
  },

  methods: {
    handleSnippetFolderChange(snippet) {
      console.log('changed')

      this.snippetz = this.snippetz.filter(s => {
        return s.id !== snippet.id
      })
    },

    handleSnippetDeletion(snippetId) {
      console.log('deleted')

      this.snippetz = this.snippetz.filter(s => {
        return s.id !== snippetId
      })
    }
  }
}
</script>
