<template>
  <div @click.prevent="performAction" class="action-button--wrapper">
    <img style="margin-left: 10px; margin-bottom: 2px;" :src="`/icons/${type}.svg`" width="14">
    <span style="font-size: 12px; margin-left: 4px;">{{ count }}</span>
  </div>
</template>

<script>
import ActionIcon from './action-icon.vue';

export default {
  components: { ActionIcon },

  props: {
    snippet: { type: Object, required: true },
    type: { required: true, type: String },
    count: { required: true, type: Number },
    action: { required: true, type: Function },
    hasActioned: { required: true, type: Boolean },
  },

  methods: {
    performAction() {
      this.action()
    }
  }
}
</script>

<style lang="scss" scoped>
  .action-button {
    &--wrapper {
      display: flex;
      align-items: center;
      font-size: 14px;

      &:hover {
        cursor: pointer;
      }
    }

    &--count {
      margin-left: 8px;
    }
  }
</style>
