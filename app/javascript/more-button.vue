<template>
  <div class="more-button">
    <img @click.prevent="openPopover"  src="/icons/more.svg" width="12">
  </div>
</template>

<script>
import Popover from './popover';
import { EventBus } from './event-bus.js';

export default {
  components: { Popover },

  props: {
    options: { type: Array, required: true }
  },

  methods: {
    openPopover() {
      EventBus.$emit('presentPopover', event, this.options)
    }
  }
}
</script>
