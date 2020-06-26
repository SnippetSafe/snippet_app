<template>
  <div>
    <div class="flex v-center">
      <div class="flex flex-column">
        <img style="border-radius: 50%;" src="https://media-exp1.licdn.com/dms/image/C4E03AQG0MUNjxFvBTw/profile-displayphoto-shrink_200_200/0?e=1593648000&v=beta&t=WnnJ_Q6MpQFur5Uev2iqeLAnoX6Rdb1Bv6RoAijK3tA" height="120" width="120" />
      </div>
      <div class="margin-left">
        <h2 class="users-show--name">{{ user.name }}</h2>
        <div style="height: 40px;">
          <span>Software developer on the Integrated Biodiversity Assessment Tool and founder of Snippet.io. Can often be found playing tennis or riding a bike.</span>
        </div>
      </div>
    </div>
    <div class="margin-top flex space-between">
      <button v-if="isLoggedOut" @click="redirectToSignUp" class="button--cta-follow">FOLLOW</button>
      <button v-else-if="isViewingOwnProfile" @click="goToEditProfile" class="button--cta-follow">EDIT PROFILE</button>
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

  computed: {
    isLoggedOut() {
      return !this.currentUser
    },

    isViewingOwnProfile() {
      if (this.currentUser) {
        return this.user.id === this.currentUser.id;
      } else {
        return false
      }
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
    redirectToSignUp() {
      window.location.href = '/users/sign_up';
    },

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
