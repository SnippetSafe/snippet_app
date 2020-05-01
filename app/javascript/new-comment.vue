<template>
  <div class="new-comment--wrapper">
    <card id="new-comment" class="new-comment--container">
      <div style="display: flex;">
        <img style="border-radius: 50%;" src="https://media-exp1.licdn.com/dms/image/C4E03AQG0MUNjxFvBTw/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=WnnJ_Q6MpQFur5Uev2iqeLAnoX6Rdb1Bv6RoAijK3tA" height="48" width="48" />
        <div style="margin-left: 12px; margin-top: 8px;">
          <span style="display: block; font-weight: bold; font-size: 14px; font-family: Helvetica, sans-serif;">{{ currentUser.name }}</span>
          <span style="font-size: 12px; color: gray;">New comment</span>
        </div>
      </div>
      <textarea class="new-comment--body" v-model="commentParams.body" placeholder="Leave a comment" autofocus></textarea>
      <!-- TODO: Make sure that the body content can't be empty -->
      <div class="new-comment--button-wrapper">
        <button class="button--cta-new" @click="createComment">COMMENT</button>
      </div>
    </card>
  </div>
</template>

<script>
import { store } from './store';
import axios from 'axios'

import Card from './card';

export default {
  components: { Card },

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

  // TODO: Extract this into a class or module that can be reused across the application
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
  .new-comment {
    &--wrapper {
      border-top: 2px solid lightgray;
    }

    &--header {
      height: 30px;
      border-bottom: 1px solid lightgray;
      background-color: #FAFBFC;
    }

    // &--container {
    //   margin: 24px 0px 24px 0px;
    //   box-shadow: 0 4px 9px lightgrey;
    //   padding: 16px;
    //   background-color: white;
    //   border-radius: 4px;
    // }

    &--body {
      margin-top: 16px;
      display: block;
      width: 100%;
      box-sizing: border-box;
      resize: none;
      height: 140px;
      padding: 6px;
      font-size: 14px;
      border-radius: 4px;
      border: 1px solid lightgray;
    }

    &--button-wrapper {
      display: flex;
      margin-top: 16px;
      flex-direction: column;
      align-items: flex-end;
    }
  }
</style>
