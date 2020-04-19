<template>
  <div class="comment--container">
    <div class="comment--header">
      <span>{{ comment.user_name }}</span>
    </div>
    <p>{{ comment.body }}</p>
  </div>
</template>

<script>
export default {
  props: {
    comment: { required: true, type: Object }
  }
}
</script>

<style lang="scss" scoped>
  .comment {
    &--header {
      height: 30px;
      border-bottom: 1px solid lightgray;
      background-color: #FAFBFC;
    }

    &--container {
      // height: 40px;
      border: 1px solid lightgray;
      margin: 16px 0px 16px 0px;
    }
  }
</style>
