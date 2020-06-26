<template>
  <div class="edit-avatar--wrapper">
    <img ref="avatar" :src="currentUser.avatar_url" width="120" height="120" style="border-radius: 50%;">
    <div class="edit-avatar--edit-button" @click="selectNewAvatar">
      <img src="/icons/edit.svg" width="16">
      <input name="avatar" ref="fileInput" type="file" @change="handleFileSelect" style="visibility: hidden" />
    </div>
  </div>
</template>

<script>
export default {
  // TODO: Extract this into a class or module that can be reused accross the application
  beforeCreate() {
    this.currentUser = this.$store.state.currentUser;
    console.log('user', this.currentUser)
  },

  methods: {
    selectNewAvatar() {
      this.$refs.fileInput.click()
    },

    handleFileSelect(event) {
      const input = event.target;

      if (input.files && input.files[0]) {
        const self = this;
        const reader = new FileReader();

        reader.onload = function(e) {
          self.$refs.avatar.setAttribute('src', e.target.result);

          self.$emit('change', input.files[0])
        }

        reader.readAsDataURL(input.files[0]);
      }
    }
  }
}
</script>
