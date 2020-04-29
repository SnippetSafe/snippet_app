<template>
  <pre><code v-html="highlightedCode"></code></pre>
</template>

<script>
export default {
  props: {
    code: { required: true, type: String },
    language: { required: true, type: String}
  },

  computed: {
    highlightedCode() {
      return hljs.highlight(this.language, this.code).value
    }
  }
}
</script>
