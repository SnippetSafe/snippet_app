<template>
  <div>
    <div class="edit-profile--wrapper">
      <edit-avatar />

      <div class="edit-profile--fields">
        <form-field label="Name" type="text" v-model="userParams.name" :margin-top="false" />
        <form-field label="Description" type="textarea" v-model="userParams.bio" />
        <form-field label="Location" type="text" v-model="userParams.location" />
      </div>

    </div>

    <div class="folders--options-wrapper">
      <button @click="saveForm" class="button--cta-blue">SAVE</button>
    </div>
  </div>
</template>

<script>
import EditAvatar from './edit-avatar';
import FormField from './form-field';

import usersMixin from './mixins/usersMixin';
import { EventBus } from './event-bus.js';

export default {
  components: { EditAvatar, FormField },

  mixins: [usersMixin],

  data() {
    return {
      userParams: {
        name: this.currentUser.name,
        bio: this.currentUser.bio,
        location: this.currentUser.location
      }
    }
  },

  // TODO: Extract this into a class or module that can be reused across the application
  beforeCreate() {
    this.currentUser = this.$store.state.currentUser;
  },

  methods: {
    saveForm() {
      this.updateUser(this.userParams)
        .then(res => {
          EventBus.$emit('presentToast', res.data.message)
        })
        .catch(error => {
          console.error(error)
          EventBus.$emit('presentToast', error.response.data.message)
        })
    }
  }
}
</script>
