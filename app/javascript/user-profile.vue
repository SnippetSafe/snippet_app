<template>
  <div>
    <div class="flex v-center">
      <div class="flex flex-column">
        <img style="border-radius: 50%;" src="https://media-exp1.licdn.com/dms/image/C4E03AQG0MUNjxFvBTw/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=WnnJ_Q6MpQFur5Uev2iqeLAnoX6Rdb1Bv6RoAijK3tA" height="120" width="120" />
      </div>
      <div class="margin-left">
        <div class="flex space-between v-center">
          <h2 class="users-show--name">{{ user.name }}</h2>
          <div class="flex flex-end">
            <count-tag :href="`/users/${user.id}/followers`" identifier="followers" :count="user.followers_count" :color="colorForTag('followers')"/>
            <count-tag :href="`/users/${user.id}/following`" identifier="following" :count="user.following_count" :color="colorForTag('following')"/>
          </div>
        </div>
        <div style="height: 40px;">
          <span>Software developer on the Integrated Biodiversity Assessment Tool and founder of Snippet.io. Can often be found playing tennis or riding a bike.</span>
        </div>
      </div>
    </div>
    <div class="margin-top flex space-between">
      <button v-if="isViewingOwnProfile" @click="goToEditProfile" class="button--cta-follow">EDIT PROFILE</button>
      <button v-else @click="followAction" @mouseenter="isHovering = true" @mouseleave="isHovering = false" :class="[buttonClass, 'text-center']">{{ buttonText }}</button>
      <count-tag identifier="snippets"  :count="user.snippets_count" color="purple"/>
    </div>
  </div>
</template>

<script>
import usersMixin from './mixins/usersMixin';
import { EventBus } from './event-bus.js';

import CountTag from './count-tag';

export default {
  components: { CountTag },

  mixins: [usersMixin],

  props: {
    user: { type: Object, required: true },
    isFollowing: { type: Boolean, required: true }
  },

  data() {
    return {
      isFollowingDup: this.isFollowing,
      isHovering: false,
    }
  },

  beforeCreate() {
    this.currentUser = this.$store.state.currentUser;
  },

  created() {
    console.log('h', window.location.href)
  },

  computed: {
    isViewingOwnProfile() {
      return this.user.id === this.currentUser.id;
    },

    buttonClass() {
      return this.isFollowingDup ? 'button--cta-unfollow' : 'button--cta-follow'
    },

    buttonText() {
      if (this.isFollowingDup && this.isHovering) {
        return 'UNFOLLOW';
      } else if (this.isFollowingDup) {
        return 'FOLLOWING';
      } else {
        return 'FOLLOW';
      }
    }
  },

  methods: {
    colorForTag(location) {
      console.log(window.location.href.includes(location))
      if (window.location.href.includes(location)) {
        return 'primary';
      } else {
        return 'inverse';
      }
    },
  
    goToEditProfile() {
      window.location.href = '/users/edit';
    },

    followAction() {
      if (!this.isFollowingDup) {
        this.followUser(this.user.id)
          .then(res => {
            console.log('yay', res)
            this.isFollowingDup = true;
            EventBus.$emit('presentToast', res.data.message)
          })
          .catch(error => {
            console.log(error)
            EventBus.$emit('presentToast', error.response.data.message)
          })
      } else {
        this.unfollowUser(this.user.id)
          .then(res => {
            console.log('yay', res)
            this.isFollowingDup = false;
            EventBus.$emit('presentToast', res.data.message)
          })
          .catch(error => {
            console.log(error)
            EventBus.$emit('presentToast', error.response.data.message)
          })
      }
    }
  }
}
</script>
