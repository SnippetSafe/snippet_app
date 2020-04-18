<template>
  <div class="snippet-show--container">
    <div class="snippet-show--author-wrapper">
      <img style="border-radius: 50%;" src="https://www.rawlinsdavy.com/wp-content/uploads/2018/12/profile-placeholder-300x300.png" height="48" width="48" />
      <span style="margin-left: 12px; margin-top: 16px; display: block; font-weight: bold; font-size: 14px; font-family: Helvetica, sans-serif;">Lydia Firminger</span>
    </div>
    <p class="snippet-show--description">{{ snippet.description }}</p>
    <div style="display: flex; flex-direction: column;">
      <snippet-header :filename="snippet.filename"></snippet-header>
      <div class="snippet-show--content" v-html="snippet.highlighted"></div>
      <action-button-bar :snippet="snippet"></action-button-bar>
    </div>
  </div>
</template>

<script>
import SnippetHeader from './snippet-header';
import ActionButtonBar from './action-button-bar';

export default {
  components: {
    ActionButtonBar,
    SnippetHeader
  },

  props: {
    snippet: { type: Object, required: true }
  },

  computed: {
    snippetHTML() {
      return `
        ${this.snippet.language_label}
        <div class="snippet-show--content">
          ${this.snippet.highlighted}
        </div>
      `
    },

    snippetUrl() {
      return `/snippets/${this.snippet.id}`
    }
  }
}
</script>

<style lang="scss">
  .snippet-show {
    &--container {
      // border-bottom: 1px solid lightgrey; 
      padding: 16px;
    }

    &--author-wrapper {
      display: flex;
    }

    &--description {
      font-family: Helvetica, sans-serif;
      font-size: 14px;
      color: darkslategrey;
    }

    &--content {
      border: 1px solid lightgrey;
      background-color: snow;
      position: relative;
      display: block;
      text-decoration: none;
    }
  }
</style>
