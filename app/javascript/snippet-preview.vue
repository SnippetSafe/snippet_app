<template>
  <card>
    <a class="snippet-preview--container" :href="snippetUrl">
      <div class="snippet-preview--author-wrapper">
        <user-preview :user="snippet.user" :date="snippet.created_at"/>
        <div>
          <div style="display: flex; flex-direction: column;">
            <div style="display: flex; justify-content: flex-end; margin-bottom: 8px;">
              <span class="language-tag">{{ snippet.language }}</span>
            </div>
            <action-button-bar :snippet="snippet"></action-button-bar>
          </div>
        </div>
      </div>
      <p class="snippet-preview--description">{{ snippet.description }}</p>
      <div style="display: flex; flex-direction: column;">
        <code-highlight class="snippet-preview--content" :highlighted-code="snippet.highlighted_body"></code-highlight>
      </div>
    </a>
  </card>
</template>

<script>
import ActionButtonBar from './action-button-bar';
import CodeHighlight from './code-highlight';
import Card from './card';
import SnippetHeader from './snippet-header';
import UserPreview from './user-preview';

export default {
  components: {
    ActionButtonBar,
    CodeHighlight,
    Card,
    SnippetHeader,
    UserPreview
  },

  props: {
    snippet: { type: Object, required: true }
  },

  computed: {
    snippetHTML() {
      return `
        <div class="snippet-preview--content">
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
  .snippet-preview {
    &--container {
      display: block;
      text-decoration: none;
      color: inherit;

      &:hover {
        text-decoration: none;
        background-color: #fcfdff;
      }
    }

    &--author-wrapper {
      display: flex;
      justify-content: space-between;
    }

    &--filename {
      font-family: Helvetica, sans-serif;
      font-size: 14px;
      text-decoration: none;

      &:hover { text-decoration: underline; }
    }

    &--description {
      font-family: Helvetica, sans-serif;
      font-size: 14px;
      color: darkslategrey;
    }

    &--content {
      max-height: 258px;
      overflow-y: scroll;
    }
  }
</style>
