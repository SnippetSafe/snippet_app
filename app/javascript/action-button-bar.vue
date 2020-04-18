<template>
  <div class="action-button-bar--wrapper">
    <action-button
      v-for="button in actionButtons"
      :snippet="snippet"
      :type="button.type"
      :key="button.type">
    </action-button>
  </div>
</template>

<script>
import ActionButton from './action-button'

export default {
  components: {
    ActionButton,
  },

  props: {
    snippet: { type: Object, required: true }
  },

  data() {
    return {
      actionButtons: [
        { type: 'heart' },
        { type: 'comment' },
        { type: 'share' },
        { type: 'star' }
      ]
    }
  },
}
</script>

<style lang="scss" scoped>
  .action-button-bar {
    &--wrapper {
      display: flex;
      border: 1px solid lightgrey;
      border-top: none;
    }
  }
</style>
