<template>
  <div>
    <div class="flex v-center">
      <div class="flex flex-column">
        <img style="border-radius: 50%;" src="https://media-exp1.licdn.com/dms/image/C4E03AQG0MUNjxFvBTw/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=WnnJ_Q6MpQFur5Uev2iqeLAnoX6Rdb1Bv6RoAijK3tA" height="120" width="120" />
      </div>
      <div class="margin-left">
        <div class="flex space-between v-center">
          <h2 class="users-show--name">{{ user.name }}</h2>
          <span class="language-tag">{{ snippetsCount }} snippets</span>
        </div>
        <div style="height: 40px;">
          <span>Software developer on the Integrated Biodiversity Assessment Tool and founder of Snippet.io. Can often be found playing tennis or riding a bike.</span>
        </div>
      </div>
    </div>
    <div class="margin-top">
      <button @click="followAction" class="button--cta-follow text-center">FOLLOW</button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    user: { type: Object, required: true },
    snippetsCount: { type: Number, required: true }
  },

  methods: {
    followAction() {
      console.log('follow')
    }
  }
}
</script>
