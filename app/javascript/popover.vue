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

<style lang="scss">
  .popover {

    &--container {
      background-color: white;
      position: absolute;
      // top: 30px;
      // right: 0px;
      // border: 1px solid #DEF2F1;
      border-radius: 5px;
      box-shadow: 0 0 6px rgba(0,0,0,.3);
      // height: 200px;
      // width: 100px;
      z-index: 5;
      padding: 8px 0px;
      font-size: 14px;

      &:focus {
        outline: none;
      }
    }

    &--item {
      font-weight: 100;
      padding: 4px 12px;
      min-width: 120px;

      &:hover { 
        background-color: #DEF2F1;
        cursor: pointer;
      }
    }
  }
</style>
