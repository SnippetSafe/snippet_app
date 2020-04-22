<template>
  <div class="action-button-bar--wrapper">
    <action-button
      v-for="button in actionButtons"
      :snippet="snippet"
      :type="button.type"
      :count="button.count"
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
        { type: 'heart', count: this.snippet.likes_count },
        { type: 'comment', count: this.snippet.comments_count },
        { type: 'share' , count: 0 },
        { type: 'star' , count: 0 }
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
