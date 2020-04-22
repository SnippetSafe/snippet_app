<template>
  <div @click="performAction" class="action-button--wrapper">
    <action-icon :type="type"></action-icon>
    <span>{{ count }}</span>
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
  },

  methods: {
    performAction() {
      console.log(`performing action for ${this.type} on snippet ${this.snippet.filename}`)
    }
  }
}
</script>

<style lang="scss" scoped>
  .action-button {
    &--wrapper {
      flex: 1;
      text-align:center;
      color: grey;
      margin-top: 11px;
      margin-bottom: 11px;
      font-size: 14px;

      &:hover {
        cursor: pointer;
        color: #003F63;
      }
    }
  }
</style>
