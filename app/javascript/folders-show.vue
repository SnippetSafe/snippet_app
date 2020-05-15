<template>
  <card>
    <div style="display: flex; justify-content: space-between;">
        <back-button></back-button>
        <h2 style="margin: 2px 0px 0px 12px; display: inline-block;">{{ folder.name }}</h2>
    </div>
    <div style="margin-top: 16px;">
      
      <snipt v-for="snippet in snippetz" :snippet="snippet" :current-folder="folder" :key="snippet.id"></snipt>
    </div>
    <div class="folders--options-wrapper">
      <a :href="`/snippets/new?folder_id=${folder.id}&redirect_url=/folders/${folder.id}`" class="button--cta-new">NEW SNIPPET</a>
    </div>
  </card>
</template>

<script>
import Snipt from './snipt';
import Card from './card'
import BackButton from './back-button'
import { EventBus } from './event-bus';

export default {
  components: {
    Snipt,
    Card,
    BackButton
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

  methods: {
    handleSnippetFolderChange(snippet) {
      console.log('changed')

      this.snippetz = this.snippetz.filter(s => {
        return s.id !== snippet.id
      })
    }
  }
}
</script>
