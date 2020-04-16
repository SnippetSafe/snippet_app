<template>
  <div id="header">
    <div id="header-wrapper">
      <div style="display: flex; align-items: center;">
        <a class="button--cta-transparent" href="/">SNIPPET.IO</a>
      </div>

      <div style="display: flex; align-items: center;">
        <a @click="newSnippet" class="button--cta-new">NEW SNIPPET</a>
        <a class="button--cta-blue" href="/">SIGN IN</a>
        <a class="button--cta-transparent" href="/">SIGN UP</a>
      </div>
    </div>
  </div>
</template>

<script>
import  { EventBus } from './event-bus';

export default {
  methods: {
    newSnippet() {
      EventBus.$emit('openNewSnippetModal')
    }
  }
}
</script>
