<template>
  <div class="sidebar--wrapper">
    <div style="font-weight: bold; font-size: 18px; font-family: Helvetica, sans-serif; margin: 0 auto; width: 150px;">
      <div style="margin: 12px 0px 12px 0px; display: flex;">
        <action-icon style="width: 60px; text-align: center;" type="home"></action-icon>
        <span>Home</span>
      </div>
    </div>
    <div style="font-weight: bold; font-size: 18px; font-family: Helvetica, sans-serif; margin: 0 auto; width: 150px;">
      <div style="margin: 12px 0px 12px 0px; display: flex;">
        <action-icon style="width: 60px; text-align: center;" type="star"></action-icon>
        <span>Stars</span>
      </div>
    </div>
    <div style="font-weight: bold; font-size: 18px; font-family: Helvetica, sans-serif; margin: 0 auto; width: 150px;">
      <div style="margin: 12px 0px 12px 0px; display: flex;">
        <action-icon style="width: 60px; text-align: center;" type="folder"></action-icon>
        <span>Folders</span>
      </div>
    </div>
    <div style="font-weight: bold; font-size: 18px; font-family: Helvetica, sans-serif; margin: 0 auto; width: 150px;">
      <div style="margin: 12px 0px 12px 0px; display: flex;">
        <action-icon style="width: 60px; text-align: center;" type="hashtag"></action-icon>
        <span>Explore</span>
      </div>
    </div>
    <div style="font-weight: bold; font-size: 18px; font-family: Helvetica, sans-serif; margin: 0 auto; width: 150px;">
      <div style="margin: 12px 0px 12px 0px; display: flex;">
        <action-icon style="width: 60px; text-align: center;" type="envelope"></action-icon>
        <span>Messages</span>
      </div>
    </div>
  </div>
</template>

<script>
import ActionIcon from './action-icon.vue';

export default {
  components: { ActionIcon }
}
</script>

<style lang="scss" scoped>
  .sidebar {
    &--wrapper {
      // background-color: snow;
      // height: 400px;
      // border: 1px solid lightgrey;
      margin: 16px;
      position: sticky;
      position: -webkit-sticky;
      top: 70px;
    }
  }
</style>
