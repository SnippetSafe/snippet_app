<template>
  <div>
    <div class="snippet-show--container">
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
      <p class="snippet-show--description">{{ snippetDup.description }}</p>
      <div style="display: flex; flex-direction: column;">
        <div class="snippet-show--content" v-html="snippetDup.highlighted"></div>
        <action-button-bar :snippet="snippetDup"></action-button-bar>
      </div>
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
      snippetDup: this.snippet,
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
      this.snippetDup.comments_count += 1
      this.comments.push(newComment)
    }
  }
}
</script>

<style lang="scss">
  .snippet-show {
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
