<template>
  <div class="snippet-preview--container">
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
          <span style="display: inline-block; font-family: Helvetica, sans serif; font-weight: lighter;">{{ snippet.language.name }}</span>
          <i class="devicon-ruby-plain colored"></i>
        </div>
      </div>
    </div>
    <p class="snippet-preview--description">{{ snippet.description }}</p>
    <div style="display: flex; flex-direction: column;">
      <!-- <snippet-header :filename="snippet.filename" :href="snippetUrl"></snippet-header> -->
      <a class="snippet-preview--content-wrapper" v-html="snippetHTML" :href="snippetUrl"></a>
      <action-button-bar :snippet="snippet"></action-button-bar>
    </div>
  </div>
</template>

<script>
import SnippetHeader from './snippet-header'
import ActionButtonBar from './action-button-bar'

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
      box-shadow: 0 4px 9px lightgrey;
      background-color: white;
      margin: 16px 0px 16px 0px;
      padding: 16px 16px 0px 16px;
      border-radius: 4px;
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
      // box-shadow: inset 0px -11px 8px -10px #CCC;
      border-radius: 4px;
      // margin: 0px 18px 0px 18px;

      &-wrapper {
        // border: 1px solid lightgrey;
        font-family: Roboto Mono,Menlo,Consolas,monospace;
        border-radius: 4px;
        background-color: #282c34;
        position: relative;
        display: block;
        text-decoration: none;

        ::-webkit-scrollbar {
            width: 0px;
            background: transparent; /* make scrollbar transparent */
        }

        &:visited { color: inherit; }
        &:hover {
          cursor: pointer;
          opacity: 95%;
        }
      }
    }
  }
</style>
