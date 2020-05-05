<template>
  <div @mouseenter="viewPreview = !viewPreview" @mouseleave="viewPreview = !viewPreview" class="folders--list-item-wrapper">
    <div class="folders--list-item">
      <a :href="folderPath" class="folders--list-item--link" :title="folder.name">
        <span class="folders--snippet-count">{{ folder.snippet_count }}</span>
        <img class="folders--snippet-icon" src="/icons/folder-1.svg" width="28">
        <span class="folders--list-item--title">{{ folder.name }}</span>
      </a>
    </div>
    <div v-if="(folder.recent_snippets.length > 0) && viewPreview" class="preview-popover">
      <a v-for="snippet in folder.recent_snippets" :href="snippetPath(snippet)" class="preview-wrapper" :title="snippet.description" :key="snippet.id">
        <div style="display: flex; justify-content: space-between;">
          <span class="language-tag">{{ snippet.language }}</span>
          <span class="date-tag">Just now</span>
        </div>
        <span style="display: block; font-size: 14px; margin-top: 4px;">{{ snippet.description.substring(0, 78) }}...</span>
      </a>
    </div>
    <div v-else-if="(folder.recent_snippets.length === 0) && viewPreview" class="preview-popover">
      <a :href="newSnippetPath({ folder_id: folder.id, redirect_url: '/folders' })" class="preview-wrapper" style="display: flex; justify-content: center;">
        <img src="/icons/edit.svg" width="20">
        <div style="display: flex; flex-direction: column; justify-content: center; margin-left: 8px;">
          <span style="font-size: 14px; display: block;">Add snippet</span>
        </div>
      </a>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    folder: { required: true, type: Object }
  },

  data() {
    return {
      viewPreview: false
    }
  },

  computed: {
    folderPath() {
      return `/folders/${this.folder.id}`
    }
  },

  methods: {
    snippetPath(snippet) {
      return `/snippets/${snippet.id}`
    },
    // TODO: Use the params
    newSnippetPath(opts = {}) {
      return `/snippets/new`
    }
  }
}
</script>
