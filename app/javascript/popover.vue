<template>
  <div v-if="presenting" v-on-clickaway="dismiss" :style="styles" class="popover--container">
    <div v-for="opt in popoverOpts" :key="opt.title" class="popover--item" @click.prevent="performAction(opt)">
      <span>{{ opt.title }}</span>
    </div>
  </div>
</template>

<script>
import { EventBus } from './event-bus.js';
import { mixin as clickaway } from 'vue-clickaway';

import Modal from './modal';

export default {
  components: { Modal },

  mixins: [ clickaway ],

  data() {
    return {
      presenting: false,
      popoverOpts: [],
      top: 0,
      left: 0
    }
  },

  created() {
    EventBus.$on('presentPopover', this.present)
  },

  computed: {
    styles() {
      return `top: ${this.top}px; left: ${this.left}px;`
    }
  },

  methods: {
    present(event, popoverOpts) {
      this.popoverOpts = popoverOpts;

      const rect = event.target.getBoundingClientRect();

      this.top = rect.bottom + 10
      this.left = rect.left - 126

      this.presenting = true;
    },

    dismiss() {
      this.presenting = false;
      this.top = 0;
      this.left = 0;
    },
  
    togglePopover() {
      this.presenting = !this.presenting;
    },

    performAction(opt) {
      opt.action()
      this.presenting = false;
    },
  }
}
</script>
