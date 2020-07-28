<template>
  <card>
    <div style="display: flex;">
      <user-preview :user="comment.user" :date="comment.created_at"/>
    </div>
    <span class="comment--body">{{ comment.body }}</span>
    <more-button v-if="popoverOptions.length > 0" :options="popoverOptions" class="position-absolute" />
  </card>
</template>

<script>
import Card from './card';
import UserPreview from './user-preview';
import MoreButton from './more-button'
import axios from 'axios'
import  { EventBus } from './event-bus';
import { store } from './store';

export default {
  components: { Card, MoreButton, UserPreview },

  props: {
    comment: { required: true, type: Object }
  },

  // TODO: Extract this into a class or module that can be reused accross the application
  beforeCreate() {
    this.currentUser = this.$store.state.currentUser;
  },

  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  },

  computed: {
    popoverOptions() {
      let options = []

      if (this.currentUser.id === this.comment.user.id) {
        options.push(
          {
            title: 'Delete comment',
            action: this.deleteComment
          }
        )
      }

      return options
    }
  },

  methods: {
    deleteComment() {
      axios.delete(`/comments/${this.comment.id}?ajax=true`)
        .then(res => {
          this.$emit('commentDeleted', this.comment)
          EventBus.$emit('presentToast', res.data.message)
        })
        .catch(error => this.errors = error.response.data.errors)
    },
  }
}
</script>

<style lang="scss" scoped>
  .comment {
    &--header {
      height: 30px;
    }

    &--container {
      margin: 24px 0px 24px 0px;
      box-shadow: 0 4px 9px lightgrey;
      padding: 16px;
      background-color: white;
      border-radius: 4px;
    }

    &--body {
      display: block;
      margin-top: 16px;
    }
  }
</style>
