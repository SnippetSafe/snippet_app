<template>
  <div>
    <div class="edit-profile--wrapper">
      <edit-avatar />

      <div class="edit-profile--fields">
        <form-field label="Name" type="text" :value="currentUser.name" :margin-top="false" @change="logChange"/>
        <form-field label="Description" type="textarea" value="Dummy description" />
        <form-field label="Location" type="text" value="location" />
      </div>

    </div>

    <div class="folders--options-wrapper">
      <button class="button--cta-blue">SAVE</button>
    </div>
  </div>
</template>

<script>
import EditAvatar from './edit-avatar';
import FormField from './form-field';

export default {
  components: { EditAvatar, FormField },

    // TODO: Extract this into a class or module that can be reused accross the application
  data() {
    return {
      currentUser: this.$store.state.currentUser
    }
  },

  methods: {
    logChange(value) {
      console.log(value)
    }
  }
}
</script>
