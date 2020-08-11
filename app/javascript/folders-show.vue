<template>
  <div class="margin-top">
    <div style="display: flex; align-itmes: center; justify-content: space-between;">
        <span class="inline-flex v-center">{{ folder.name }}</span>
        <a :href="newSnippetUrl" class="button--cta-new">NEW SNIPPET</a>
    </div>
    <div v-if="snippetz.length > 0" style="margin-top: 16px;">
      <snippet-preview
        v-for="snippet in snippetz"
        :key="snippet.id"
        :snippet="snippet"
        @deleted="handleSnippetDeletion"
        :actionable="true"
      />
    </div>
    <empty-state v-else :href="newSnippetUrl"></empty-state>
  </div>
</template>

<script>
import Card from './card'
import BackButton from './back-button'
import EmptyState from './empty-state'
import SnippetPreview from './snippet-preview'

import { EventBus } from './event-bus';

export default {
  components: {
    BackButton,
    Card,
    EmptyState,
    SnippetPreview,
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
