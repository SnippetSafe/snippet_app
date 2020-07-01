<template>
  <div>
    <snippet-preview
      v-for="snippet in snippetz"
      :key="snippet.id"
      :snippet="snippet"
    />
  </div>
</template>

<script>
import SnippetPreview from './snippet-preview'

export default {
  components: { SnippetPreview },
  
  props: {
    snippets: { type: Array, required: true }
  },

  data() {
    return {
      snippetz: this.snippets
    }
  }
}
</script>
