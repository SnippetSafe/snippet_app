<template>
  <div>
    <h1>Latest Snippets</h1>
    <div v-for="snippet in snippets" :key="snippet.id" style="border-bottom: 1px solid lightgrey; padding: 16px;">
      <div style="display: flex;">
        <img style="border-radius: 50%;" src="https://www.rawlinsdavy.com/wp-content/uploads/2018/12/profile-placeholder-300x300.png" height="48" width="48" />
        <div style="margin-left: 12px; margin-top: 8px;">
          <span style="display: block; font-weight: bold; font-size: 14px;">Lydia Firminger</span>
          <span style="display: block; font-size: 12px;">Javascript</span>
        </div>
      </div>
      <p>{{ snippet.description }}</p>
      <div v-html="compiledMarkdown(snippet.body)"></div>
    </div>
  </div>
</template>

<script>
import marked from 'marked'

export default {
  props: {
    snippets: { type: Array, required: true }
  },

  created() {
    console.log('snippets', this.snippets)
  },

  methods: {
    compiledMarkdown(markdown) {
      return marked(markdown);
    }
  }
}
</script>
