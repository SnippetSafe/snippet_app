<template>
  <pre class="code-highlight"><code :class="this.language" v-html="highlighted"></code></pre>
</template>

<script>
export default {
  props: {
    rawCode: { required: false, type: String },
    highlightedCode: { required: false, type: String },
    language: { required: false, type: String }
  },

  computed: {
    highlighted() {
      if (this.highlightedCode) {
        return this.highlightedCode
      } else {
        return hljs.highlight(this.language, this.rawCode).value
      }
    }
  }
}
</script>

<style lang="scss">
  // pre {
  //   background-color: #FDF6E3;
  //   padding: 16px;
  //   margin: 0px;
  //   font-size: 16px;
  //   border: 1px solid #DEF2F1;
  //   border-radius: 2px;

  //   ::-webkit-scrollbar {
  //     width: 0px;
  //     background: transparent; /* make scrollbar transparent */
  //   }
  // }
</style>
