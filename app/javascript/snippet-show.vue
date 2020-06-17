<template>
  <div>
    <card>
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
      <p class="snippet-show--description">{{ snippetDup.description }}</p>
      <div style="display: flex; flex-direction: column;">
        <code-highlight style="overflow-x: scroll;" :highlighted-code="snippet.highlighted_body"></code-highlight>
      </div>
    </card>
    <div class="snippet-show--comments-wrapper">
      <comment v-for="comment in comments" :comment="comment" :key="comment.id"></comment>
    </div>
    <new-comment v-if="currentUser" @commentCreated="addNewCommentToComments" :snippet="snippet"></new-comment>
    <card v-if="!currentUser">
      <span>Please <a href="/users/sign_in">sign in</a> to leave a comment</span>
    </card>
  </div>
</template>

<script>
import ActionButtonBar from './action-button-bar';
import Card from './card';
import CodeHighlight from './code-highlight'
import Comment from './comment';
import NewComment from './new-comment';
import SnippetHeader from './snippet-header';
import UserPreview from './user-preview';

export default {
  components: {
    ActionButtonBar,
    Card,
    Comment,
    CodeHighlight,
    NewComment,
    SnippetHeader,
    UserPreview
  },

  props: {
    snippet: { type: Object, required: true }
  },

  data() {
    return {
      snippetDup: this.snippet,
      comments: this.snippet.comments,
      currentUser: null
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
    this.currentUser = this.$store.state.currentUser;
  },

  methods: {
    addNewCommentToComments(newComment) {
      this.snippetDup.comments_count += 1
      this.comments.push(newComment)
    }
  }
}
</script>

<style lang="scss">
  .snippet-show {
    // &--container {
    //   box-shadow: 0 4px 9px lightgrey;
    //   background-color: white;
    //   margin: 16px 0px 16px 0px;
    //   padding: 16px 16px 0px 16px;
    //   border-radius: 4px;
    // }

    &--author-wrapper {
      display: flex;
      justify-content: space-between;
    }

    &--description {
      font-family: Helvetica, sans-serif;
      font-size: 14px;
      color: darkslategrey;
    }

    &--content {
      background-color: #282c34;
      position: relative;
      display: block;
      text-decoration: none;
      border-radius: 4px;
      // margin: 0px 18px 0px 18px;
    }

    &--comments {
      &-wrapper {
        // box-shadow: 0 4px 9px lightgrey;
        // padding: 16px;
        // background-color: white;
        // border-radius: 4px;
      }
    }
  }
</style>
