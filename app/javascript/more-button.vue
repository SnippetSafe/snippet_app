<template>
  <div class="more-button">
    <img @click.prevent="openPopover"  src="/icons/more.svg" width="12">
  </div>
</template>

<script>
import Popover from './popover';

export default {
  components: { Popover },

  methods: {
    openPopover: () => {
      console.log('opening popover')
    }
  }
}
</script>

<style lang="scss">
  .more-button {
    margin-left: 4px;
    padding: 3px 4px;
    display: inline-block;
    position: relative;

    &:hover {
      cursor: pointer;
      background-color: white;
    }
  }
</style>
