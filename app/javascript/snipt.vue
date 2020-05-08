<template>
  <div class="snippets--list-item" style="">
    <div class="snippets--list-item--title-wrapper">
      <!-- <img src="/icons/file.svg" width="18"> -->
      <a :href="snippetPath" class="snippets--list-item--title-link">{{ snippet.description }}</a>
      <!-- <span class="language-tag">{{ snippet.language }}</span> -->
      <img style="margin-left: 12px;" src="/icons/settings.svg" width="14">
    </div>
    <div class="snippets--list-item--author-wrapper">
      <!-- <span style="font-size: 14px; flex: 1; color: grey;">You - {{ snippet.created_at }}</span> -->
      <span class="language-tag">{{ snippet.language }}</span>
    </div>
    <div class="snippets--list-item--social-wrapper">
      <div>
        <span style="font-size: 14px; color: grey;">{{ snippet.created_at }}</span>
      </div>
      <div style="display: flex; align-items: center;">
        <img style="margin-left: 12px; margin-bottom: 2px;" src="/icons/heart.svg" width="14">
        <span style="font-size: 12px; margin-left: 4px;">{{ snippet.likes_count }}</span>
        <img style="margin-left: 12px; margin-bottom: 2px;" src="/icons/star.svg" width="14">
        <span style="font-size: 12px; margin-left: 4px;">{{ snippet.likes_count }}</span>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    snippet: { required: true, type: Object }
  },

  created() {
    console.log('snippet', this.snippet)
  },

  computed: {
    snippetPath() {
      return `/snippets/${this.snippet.id}`;
    }
  }
}
</script>
