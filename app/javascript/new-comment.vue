<template>
  <div class="new-comment--wrapper">
    
  </div>
</template>

<script>
import { store } from './store';
import axios from 'axios'
import  { EventBus } from './event-bus';
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
      },
      errors: null
    }
  },

  // TODO: Extract this into a class or module that can be reused across the application
  beforeCreate() {
    this.currentUser = this.$store.state.currentUser;
  },

  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  },

  methods: {
    createComment() {
      axios.post('/comments?ajax=true', { comment: this.commentParams })
        .then(res => {
          const comment = res.data.comment

          this.resetCommentForm()
          this.$emit('commentCreated', comment)
          EventBus.$emit('presentToast', res.data.message)
        })
        .catch(error => this.errors = error.response.data.errors)
    },

    resetCommentForm() {
      this.commentParams.body = ''
      this.errors = null;
    }
  }
}
</script>
