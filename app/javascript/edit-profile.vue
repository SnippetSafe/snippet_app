<template>
  <div class="margin-top">
    <div class="edit-profile--wrapper">

      <div class="edit-profile--fields">
        <ul v-if="errors" style="color: #86181d; border: 1px solid lightgray; font-weight: 100; padding: 6px; list-style-position:inside; border-radius: 2px; background-color: #f9bbbb; font-size: 14px;">
          <li v-for="error in errors" :key="error">{{ error }}</li>
        </ul>
        <form-field label="Name" type="text" v-model="userParams.name" :margin-top="false" />
        <form-field label="Description" type="textarea" v-model="userParams.bio" />
        <form-field label="Location" type="text" v-model="userParams.location" />
      </div>

      <edit-avatar @change="addAvatarToParams"/>
    </div>

    <div class="folders--options-wrapper">
      <button @click="saveForm" :class="buttonClass">SAVE</button>
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
        location: this.currentUser.location,
        avatar: undefined
      },
      errors: null
    }
  },

  // TODO: Extract this into a class or module that can be reused across the application
  beforeCreate() {
    this.currentUser = this.$store.state.currentUser;
  },

  computed: {
    buttonClass() {
      if (this.formEdited) {
        return "button--cta-blue";
      } else {
        return "button--cta-disabled"
      }
    },

    formEdited() {
      return this.userParams.avatar !== undefined || (this.userParams.name !== this.currentUser.name) || (this.userParams.bio !== this.currentUser.bio) || (this.userParams.location !== this.currentUser.location)
    }
  },

  methods: {
    saveForm() {
      if (this.formEdited) {
        let formData = new FormData()

        Object.keys(this.userParams).forEach(attribute => {
          const value = this.userParams[attribute];

          if (attribute === 'avatar' && !value) {
            return;
          } else {
            formData.append(`user[${attribute}]`, value);
          };
        })

        this.updateUser(formData)
          .then(res => {
            if (this.userParams.avatar) {
              document.getElementById("user-avatar").src = res.data.user.avatar_url
            }
            EventBus.$emit('presentToast', res.data.message)

            this.currentUser = res.data.user;
            this.resetForm();

          })
          .catch(error => this.errors = error.response.data.errors)
      }
    },

    addAvatarToParams(avatarFile) {
      this.userParams.avatar = avatarFile;
    },

    resetForm() {
      // Trigger refresh of formComplete computed property
      this.userParams = Object.assign({}, this.userParams);
      this.userParams.avatar = undefined;
      this.errors = null
    }
  }
}
</script>
