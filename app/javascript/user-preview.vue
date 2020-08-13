<template>
  <div class="user-preview--wrapper">
    <div data-controller="hovercard" :data-hovercard-url="userHovercardPath" data-action="mouseenter->hovercard#show mouseleave->hovercard#hide" class="position-relative">
      <a :href="`/users/${user.id}`">
        <img class="user-preview--img" :src="user.avatar_url" height="48" width="48" />
      </a>
    </div>
    <div class="user-preview--summary">
      <div data-controller="hovercard" :data-hovercard-url="userHovercardPath" data-action="mouseenter->hovercard#show mouseleave->hovercard#hide" class="position-relative">
        <a :href="`/users/${user.id}`">
          <span class="user-preview--summary-name">{{ user.name }}</span>
        </a>
      </div>
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
  },

  computed: {
    userHovercardPath() {
      return `/users/${this.user.id}/hovercard`
    }
  }
}
</script>
