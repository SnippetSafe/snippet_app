<template>
  <card>
    <div style="display: flex;">
        <img style="border-radius: 50%;" src="https://media-exp1.licdn.com/dms/image/C4D03AQFDEttQjYQSbA/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=V16a0Z3adcm8E22knjzE7dqvUddTkBgJj0g6-6Zstt4" height="48" width="48" />
        <div style="margin-left: 12px; margin-top: 8px;">
          <span style="display: block; font-weight: bold; font-size: 14px; font-family: Helvetica, sans-serif;">{{ comment.user_name }}</span>
          <span style="font-size: 12px; color: gray;">54 seconds ago</span>
        </div>
      </div>
    <span class="comment--body">{{ comment.body }}</span>
  </card>
</template>

<script>
import Card from './card';

export default {
  components: { Card },

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
