<template>
  <div class="user-preview--wrapper">
    <a :href="`/users/${user.id}`">
      <img class="user-preview--img" src="https://media-exp1.licdn.com/dms/image/C4E03AQG0MUNjxFvBTw/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=WnnJ_Q6MpQFur5Uev2iqeLAnoX6Rdb1Bv6RoAijK3tA" height="48" width="48" />
    </a>
    <div class="user-preview--summary">
      <a :href="`/users/${user.id}`">
        <span class="user-preview--summary-name">{{ user.name }}</span>
      </a>
      <span v-if="date" class="user-preview--summary-time-ago">{{ date }}</span>
      <span v-else class="user-preview--summary-time-ago">@{{ user.name }}</span>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    user: { type: Object, required: true },
    date: { type: String, required: false }
  }
}
</script>
