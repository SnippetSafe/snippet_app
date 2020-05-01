<template>
  <card>
    <a class="snippet-preview--container" :href="snippetUrl">
      <div class="snippet-preview--author-wrapper">
        <div style="display: flex;">
          <img style="border-radius: 50%;" src="https://media-exp1.licdn.com/dms/image/C4E03AQG0MUNjxFvBTw/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=WnnJ_Q6MpQFur5Uev2iqeLAnoX6Rdb1Bv6RoAijK3tA" height="48" width="48" />
          <div style="margin-left: 12px; margin-top: 8px;">
            <span style="display: block; font-weight: bold; font-size: 14px; font-family: Helvetica, sans-serif;">{{ snippet.user.name }}</span>
            <span style="font-size: 12px; color: gray;">23 minutes ago</span>
          </div>
        </div>
        <div>
          <div style="font-size: 14px;">
            <span style="display: inline-block; font-family: Helvetica, sans serif; font-weight: lighter;">{{ snippet.language }}</span>
          </div>
        </div>
      </div>
      <p class="snippet-preview--description">{{ snippet.description }}</p>
      <div style="display: flex; flex-direction: column;">
        <!-- <snippet-header :filename="snippet.filename" :href="snippetUrl"></snippet-header> -->
        <!-- <a class="snippet-preview--content-wrapper" v-html="snippet.highlighted_body" :href="snippetUrl"></a> -->
        <code-highlight class="snippet-preview--content" :highlighted-code="snippet.highlighted_body"></code-highlight>
        <action-button-bar :snippet="snippet"></action-button-bar>
      </div>
    </a>
  </card>
</template>

<script>
import ActionButtonBar from './action-button-bar';
import Card from './card';
import CodeHighlight from './code-highlight';
import SnippetHeader from './snippet-header';

export default {
  components: {
    ActionButtonBar,
    Card,
    CodeHighlight,
    SnippetHeader,
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
        cursor: pointer;
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
