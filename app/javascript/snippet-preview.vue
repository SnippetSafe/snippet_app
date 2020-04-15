<template>
  <div class="snippet-preview--container">
    <div class="snippet-preview--author-wrapper">
      <img style="border-radius: 50%;" src="https://www.rawlinsdavy.com/wp-content/uploads/2018/12/profile-placeholder-300x300.png" height="48" width="48" />
      <div style="margin-left: 12px; margin-top: 8px;">
        <span style="display: block; font-weight: bold; font-size: 14px; font-family: Helvetica, sans-serif;">Lydia Firminger</span>
        <span style="display: block; font-size: 12px; font-family: Helvetica, sans-serif;">Javascript</span>
      </div>
    </div>
    <p class="snippet-preview--description">{{ snippet.filename }}</p>
    <p class="snippet-preview--description">{{ snippet.description }}</p>
    <div class="snippet-preview--content-wrapper" v-html="snippetHTML"></div>
  </div>
</template>

<script>
export default {
  props: {
    snippet: { type: Object, required: true }
  },

  computed: {
    snippetHTML() {
      return `
        ${this.snippet.language_label}
        <div class="snippet-preview--content">
          ${this.snippet.highlighted}
        </div>
      `
    }
  }
}
</script>

<style lang="scss">
  .snippet-preview {
    &--container {
      border-bottom: 1px solid lightgrey; 
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
      max-height: 258px;
      overflow: hidden;
      box-shadow: inset 0px -11px 8px -10px #CCC;

      &-wrapper {
        border: 1px solid lightgrey;
        background-color: snow;
        position: relative;
      }
    }
  }
</style>
