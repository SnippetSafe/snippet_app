<template>
  <card>
    <div style="display: flex;">
      <user-preview :user="comment.user" :date="comment.created_at"/>
    </div>
    <span class="comment--body">{{ comment.body }}</span>
  </card>
</template>

<script>
import Card from './card';
import UserPreview from './user-preview';

export default {
  components: { Card, UserPreview },

  props: {
    comment: { required: true, type: Object }
  }
}
</script>

<style lang="scss" scoped>
  .comment {
    &--header {
      height: 30px;
    }

    &--container {
      margin: 24px 0px 24px 0px;
      box-shadow: 0 4px 9px lightgrey;
      padding: 16px;
      background-color: white;
      border-radius: 4px;
    }

    &--body {
      display: block;
      margin-top: 16px;
    }
  }
</style>
