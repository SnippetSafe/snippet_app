<template>
  <img :src="avatarUrlDup" style="border-radius: 50%; display: block; margin: 0 auto;" width="80" height="80">
</template>

<script>
import { EventBus } from './event-bus.js';

export default {
  props: {
    avatarUrl: { required: true, type: String }
  },

  data() {
    return {
      avatarUrlDup: this.avatarUrl
    }
  },

  created() {
    EventBus.$on('updateAvatar', this.assignNewAvatar)
  },

  methods: {
    assignNewAvatar(newAvatarUrl) {
      this.avatarUrlDup = newAvatarUrl;
    }
  }
}
</script>
