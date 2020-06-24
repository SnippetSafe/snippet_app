<template>
  <div class="edit-avatar--wrapper">
    <img ref="avatar" src="https://media-exp1.licdn.com/dms/image/C4E03AQG0MUNjxFvBTw/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=WnnJ_Q6MpQFur5Uev2iqeLAnoX6Rdb1Bv6RoAijK3tA" style="border-radius: 50%;" width="120" height="120">
    <div class="edit-avatar--edit-button" @click="selectNewAvatar">
      <img src="/icons/edit.svg" width="16">
      <input name="avatar" ref="fileInput" type="file" @change="handleFileSelect" style="visibility: hidden" />
    </div>
  </div>
</template>

<script>
export default {
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
