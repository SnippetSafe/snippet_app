<template>
  <div class="sidebar--wrapper">
    <div class="sidebar--section-wrapper">
      <div class="menu-button--wrapper">
        <a class="menu-button--item" href="/">
          <img src="icons/home.svg" width="28">
          <span style="display: block;  margin-top: 8px;">Home</span>
        </a>
        <a class="menu-button--item">
          <img src="icons/favorites.svg" width="28">
          <span style="display: block; margin-top: 8px;">Stars</span>
        </a>
      </div>
      <div class="menu-button--wrapper">
        <div class="menu-button--item">
          <img src="icons/folder-1.svg" width="28">
          <span style="display: block; margin-top: 8px;">Folders</span>
        </div>
        <div class="menu-button--item">
          <img src="icons/envelope.svg" width="28">
          <span style="display: block; margin-top: 8px;">Messages</span>
        </div>
      </div>
      <div class="menu-button--wrapper">
        <div class="menu-button--item">
          <img src="icons/loupe.svg" width="28">
          <span style="display: block; margin-top: 8px;">Explore</span>
        </div>
        <div class="menu-button--item">
          <img src="icons/chat-1.svg" width="28">
          <span style="display: block; margin-top: 8px;">Comments</span>
        </div>
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
