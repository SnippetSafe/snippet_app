<template>
  <div class="popover--wrapper" tabindex="0" @focusout="displayPopover = false">
    <div @click.prevent="togglePopover" class="more-button">
      <img src="/icons/more.svg" width="12">
    </div>
    <div v-if="displayPopover" @click.prevent="()=> { }" class="popover--container">
      <!-- <slot></slot> -->
      <div v-for="opt in options" :key="opt.title" class="popover--item" @click.prevent="performOptFunc(opt)">
        <span>{{ opt.title }}</span>
      </div>
    </div>
  </div>
</template>

<script>
import Modal from './modal';

export default {
  components: { Modal },

  props: {
    options: { type: Array, required: true }
  },

  data() {
    return {
      displayPopover: false,
      showModal: false
    }
  },

  methods: {
    togglePopover() {
      this.displayPopover = !this.displayPopover;
    },

    performOptFunc(opt) {
      opt.func()
      this.displayPopover = false;
    },

    dothing() {
      console.log('think')
    },

    closeModal() {
      this.showModal = false;
    }
  }
}
</script>

<style lang="scss">
  .popover {
    &--wrapper {
      &:focus {
        outline: none;
      }
    }

    &--container {
      background-color: white;
      position: absolute;
      top: 30px;
      right: 0px;
      // border: 1px solid #DEF2F1;
      border-radius: 5px;
      box-shadow: 0 0 6px rgba(0,0,0,.3);
      // height: 200px;
      // width: 100px;
      z-index: 5;
      padding: 8px 0px;
      font-size: 14px;
    }

    &--item {
      font-weight: 100;
      padding: 4px 12px;
      min-width: 120px;

      &:hover { 
        background-color: #DEF2F1;
      }
    }
  }
</style>
