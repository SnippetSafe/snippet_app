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

<style lang="scss">
  .more-button {
    padding: 3px 4px;
    display: inline-block;
    top: 4px; right: 4px;

    &:hover {
      cursor: pointer;
      background-color: white;
    }
  }
</style>
