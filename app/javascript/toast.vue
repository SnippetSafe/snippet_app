<template>
  <transition name="slide-bottom">
    <div v-if="isActive" class="toast--container">
      <span>Snippet deleted!</span>
    </div>
  </transition>
</template>

<script>
import { EventBus } from './event-bus.js';

export default {

  data() {
    return {
      isActive :false
    }
  },

  created() {
    EventBus.$on('presentToast', this.present)
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
