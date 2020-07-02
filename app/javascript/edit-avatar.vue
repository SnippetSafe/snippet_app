<template>
  <div class="edit-avatar--wrapper">
    <modal v-if="showModal" header="Crop Avatar" @close="closeModal">
      <div slot="body">
        <vue-cropper
          class="edit-avatar--cropper"
          ref="cropper"
          :src="newImage"
          alt="New Avatar"
          :aspect-ratio="1 / 1"
          :strict="false"
        >
        </vue-cropper>

        <div class="action-buttons">
          <button @click="emitCroppedImage" class="button--cta-blue">CROP</button>
        </div>
      </div>
    </modal>
    <img ref="avatar" :src="currentUser.avatar_url" width="120" height="120" style="border-radius: 50%;">
    <div class="edit-avatar--edit-button" @click="selectNewAvatar">
      <img src="/icons/edit.svg" width="16">
      <input name="avatar" ref="fileInput" type="file" @change="handleFileSelect" style="visibility: hidden" />
    </div>
  </div>
</template>

<script>
import Modal from './modal'

import VueCropper from 'vue-cropperjs';
import 'cropperjs/dist/cropper.css';

export default {
  components: { Modal, VueCropper },

  data() {
    return {
      showModal: false,
      newImage: undefined
    }
  },
  // TODO: Extract this into a class or module that can be reused accross the application
  beforeCreate() {
    this.currentUser = this.$store.state.currentUser;
  },

  methods: {
    emitCroppedImage() {
      const canvas = this.$refs.cropper.getCroppedCanvas({
        width: 200,
        height: 200
      });

      canvas.toBlob(blob => { this.$emit('change', blob) });

      this.$refs.avatar.setAttribute('src', canvas.toDataURL());

      this.closeModal();
    },

    selectNewAvatar() {
      this.$refs.fileInput.value = '';
      this.$refs.fileInput.click();
    },

    handleFileSelect(event) {
      const input = event.target;

      if (input.files && input.files[0]) {
        const self = this;
        const reader = new FileReader();

        reader.onload = function(e) {
          self.showModal = true;
          self.newImage = e.target.result;
        }

        reader.readAsDataURL(input.files[0]);
      }
    },

    closeModal() {
      this.showModal = false;
      this.newImage = undefined;
    }
  }
}
</script>

