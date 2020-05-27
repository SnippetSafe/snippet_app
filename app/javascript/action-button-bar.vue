<template>
  <div class="action-button-bar--wrapper">
    <modal v-if="showModal" header="File Snippet" @close="closeModal">
      <move-snippet
        slot="body"
        :snippet="snippet"
        :confirm-action="folderConfirm"
        confirm-text="FILE SNIPPET">
      </move-snippet>
    </modal>
    <action-button
      v-for="button in actionButtons"
      :snippet="snippetDup"
      :type="button.type"
      :count="button.count"
      :action="button.action"
      :hasActioned="button.hasActioned"
      :key="button.type">
    </action-button>
  </div>
</template>

<script>
import ActionButton from './action-button';
import Modal from './modal';
import MoveSnippet from './move-snippet';
import foldersMixin from './mixins/foldersMixin';
import  { EventBus } from './event-bus';
import { store } from './store';
import axios from 'axios'

export default {
  components: {
    ActionButton,
    Modal,
    MoveSnippet
  },

  mixins: [foldersMixin],

  props: {
    snippet: { type: Object, required: true }
  },

  data() {
    return {
      snippetDup: this.snippet,
      showModal: false,
      folderConfirm: (folder) => {
        this.fileSnippet(folder.id, this.snippet.id)
          .then(res => {
            EventBus.$emit('presentToast', res.data.message);
            this.closeModal();
          })
          .catch(error => {
            EventBus.$emit('presentToast', error.response.data.message);
            this.closeModal();
          })
      }
    }
  },

  computed: {
    actionButtons() {
      return [
        { type: 'heart', count: this.snippetDup.likes_count, action: this.likeAction(), hasActioned: this.snippetDup.liked_by_current_user },
        { type: 'comment', count: this.snippetDup.comments_count, action: this.commentAction(), hasActioned: false },
        { type: 'share' , count: 0, action: () => { console.log('sharing') }, hasActioned: false },
        { type: 'folder' , count: 0, action: this.fileAction, hasActioned: false }
      ]
    }
  },

  // TODO: Extract this into a class or module that can be reused accross the application
  beforeCreate() {
    this.currentUser = this.$store.state.currentUser;
  },

  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  },

  methods: {
    closeModal() {
      this.showModal = false;
    },

    fileAction() {
      if (this.currentUser) {
          this.showModal = true
        } else {
          window.location.href = '/users/sign_up'
        }
    },
  
    likeAction() {
      return () => {
        if (this.currentUser) {
          const likeParams = {
            user_id: this.currentUser.id,
            snippet_id: this.snippet.id
          }
  
          axios.post('/likes?ajax=true', { like: likeParams })
          .then(res => this.snippetDup = res.data.snippet)
          .catch(console.error)
        } else {
          window.location.href = '/users/sign_up'
        }
      }
    },

    commentAction() {
      return () => {
        if (this.currentUser) {
          window.location.href = `/snippets/${this.snippetDup.id}#new-comment`;
        } else {
          window.location.href = '/users/sign_up'
        }
      }
    }
  }
}
</script>

<style lang="scss" scoped>
  .action-button-bar {
    &--wrapper {
      display: flex;
      // border: 1px solid lightgrey;
      // border-top: none;
    }
  }
</style>
