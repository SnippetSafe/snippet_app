<template>
  <transition name="slide-bottom">
    <div v-if="isActive" :class="toastClass">
      <span v-html="message"></span>
    </div>
  </transition>
</template>

<script>
import { EventBus } from './event-bus.js';

export default {

  props: {
    notice: { type: String, required: false },
    alert: { type: String, required: false }
  },

  data() {
    return {
      isActive :false,
      toastClass: 'toast--container-notice'
    }
  },

  created() {
    EventBus.$on('presentToast', this.present)
  },

  mounted() {
    console.log('notice', this.notice)

    if (this.notice) {
      this.toastClass = 'toast--container-notice';
      this.present(this.notice)
    } else if (this.alert) {
      this.toastClass = 'toast--container-alert'
      this.present(this.alert)
    }
  },

  methods: {
    present(message) {
      this.message = message;
      this.isActive = true;

      setTimeout(() => {
        this.message = '';
        this.isActive = false;
      }, 4000)
    }
  }
}
</script>

<style scoped>
.slide-bottom-enter-active, .slide-bottom-leave-active {
  transition: bottom .4s;
}
.slide-bottom-enter, .slide-bottom-leave-to /* .fade-leave-active below version 2.1.8 */ {
  bottom: -300px;
}
</style>
