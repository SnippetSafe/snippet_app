<template>
  <div>
    <div class="tabs--headers-container">
      <div>
        <h2 class="margin-top no-margin-bottom" v-if="title">{{ title }}</h2>
      </div>
      <div class="tabs--headers-wrapper">
        <div v-for="tab in tabs" @click="selectTab(tab)" :class="['tabs--header', { 'tabs--header-active': tab.isActive }]" :key="tab.name">
            <span>{{ tab.name }}</span>
        </div>
      </div>
    </div>

    <div class="tabs-details">
        <slot></slot>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    title: { type: String, required: false }
  },

  data() {
    return {tabs: [] };
  },
    
  created() {
    this.tabs = this.$children;
  },

  methods: {
    selectTab(selectedTab) {
      this.tabs.forEach(tab => {
        tab.isActive = (tab.name == selectedTab.name);
      });
    }
  }
}
</script>

<style lang="scss" scoped>
  .tabs {
    &--headers{
      &-container {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
      }

      &-wrapper {
        display: flex;
        flex-direction: row;
      }
    }

    &--header {
      padding: 16px;
      border-radius: 2px;

      &:hover {
        cursor: pointer;
        background-color: #DEF2F1;
      }

      &-active {
        @extend .tabs--header;

        text-decoration: underline;
        text-decoration-color: #3AAFA9;
      }
    }
  }
</style>
