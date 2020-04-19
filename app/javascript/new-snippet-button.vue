<template>
  <a @click="newSnippet" class="button--cta-new">NEW SNIPPET</a>
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
