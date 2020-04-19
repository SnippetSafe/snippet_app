<template>
  <div class="snippet-show--container">
    <div class="snippet-show--author-wrapper">
      <img style="border-radius: 50%;" src="https://www.rawlinsdavy.com/wp-content/uploads/2018/12/profile-placeholder-300x300.png" height="48" width="48" />
      <span style="margin-left: 12px; margin-top: 16px; display: block; font-weight: bold; font-size: 14px; font-family: Helvetica, sans-serif;">{{ snippet.user.name }}</span>
    </div>
    <p class="snippet-show--description">{{ snippet.description }}</p>
    <div style="display: flex; flex-direction: column;">
      <snippet-header :filename="snippet.filename"></snippet-header>
      <div class="snippet-show--content" v-html="snippet.highlighted"></div>
      <action-button-bar :snippet="snippet"></action-button-bar>
    </div>
    <div class="snippet-show--comments-wrapper">
      <comment v-for="comment in comments" :comment="comment" :key="comment.id"></comment>
    </div>
    <new-comment @commentCreated="addNewCommentToComments" :snippet="snippet"></new-comment>
  </div>
</template>

<script>
import ActionButtonBar from './action-button-bar';
import Comment from './comment';
import NewComment from './new-comment';
import SnippetHeader from './snippet-header';

export default {
  components: {
    ActionButtonBar,
    Comment,
    NewComment,
    SnippetHeader
  },

  props: {
    snippet: { type: Object, required: true }
  },

  data() {
    return {
      comments: this.snippet.comments
    }
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
  },

  created() {
    console.log('user', this.$store.state.currentUser)
    console.log('show snippet', this.snippet)
  },

  methods: {
    addNewCommentToComments(newComment) {
      console.log('new com', newComment)
      this.comments.push(newComment)
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
