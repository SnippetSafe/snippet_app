<template>
  <div class="edit-avatar--wrapper">
    <modal v-if="showModal" header="Crop Image" @close="closeModal">
      <div slot="body">
        <vue-cropper
          ref="cropper"
          :src="newImage"
          alt="Source Image"
          :aspect-ratio="1 / 1"
          @ready="ready"
          @cropstart="ready"
          @cropmove="ready"
          @cropend="ready"
          @crop="ready"
          @zoom="ready"
        >
        </vue-cropper>
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
    ready() {
      console.log('ready')
    },

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
          self.showModal = true;
          self.newImage = e.target.result;

          // self.cropStuff()

          self.$emit('change', input.files[0])
        }

        reader.readAsDataURL(input.files[0]);
      }
    },

    closeModal() {
      this.showModal = false;
    },

    cropStuff() {
      setTimeout(() => {
        const image = document.getElementById('test')

        const cropper = new Cropper(image, {
          aspectRatio: 1 / 1,
          minContainerWidth: 860,   //decides the size of image
          minContainerHeight: 355,
          crop(event) {
            console.log(event.detail.x);
            console.log(event.detail.y);
            console.log(event.detail.width);
            console.log(event.detail.height);
            console.log(event.detail.rotate);
            console.log(event.detail.scaleX);
            console.log(event.detail.scaleY);
          },
        });
      }, 1000)
    }
  }
}
</script>

