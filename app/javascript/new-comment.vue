<template>
  <div id="new-comment" class="comment--container">
    <div class="comment--header">
      <span>{{ currentUser.name }}</span>
    </div>
    <textarea v-model="commentParams.body"></textarea>
    <button @click="createComment">Comment</button>
  </div>
</template>

<script>
import { store } from './store';
import axios from 'axios'

export default {
  props: {
    snippet: { required: true, type: Object }
  },

  data() {
    return {
      commentParams: {
        snippet_id: this.snippet.id,
        user_id: this.currentUser.id,
        body: ''
      }
    }
  },

  // TODO: Extract this into a class or module that can be reused accross the application
  beforeCreate() {
    this.currentUser = this.$store.state.currentUser;
    console.log('u', this.currentUser)
  },

  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  },

  methods: {
    createComment() {
      console.log('com params', this.commentParams)

      axios.post('/comments?ajax=true', { comment: this.commentParams })
        .then(res => {
          console.log(res)
          const comment = res.data.comment

          this.resetCommentForm()
          this.$emit('commentCreated', comment)
        })
        .catch(console.error)
    },

    resetCommentForm() {
      this.commentParams.body = ''
    }
  }
}
</script>

<style lang="scss" scoped>
  .comment {
    &--header {
      height: 30px;
      border-bottom: 1px solid lightgray;
      background-color: #FAFBFC;
    }

    &--container {
      // height: 40px;
      border: 1px solid lightgray;
      margin: 16px 0px 16px 0px;
    }
  }
</style>
