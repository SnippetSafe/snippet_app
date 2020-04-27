<template>
  <div>
    <div class="tabs--headers">
      <div v-for="tab in tabs" @click="selectTab(tab)" :class="['tabs--header', { 'tabs--header-active': tab.isActive }]" :key="tab.name">
          <span>{{ tab.name }}</span>
      </div>
    </div>

    <div class="tabs-details">
        <slot></slot>
    </div>
  </div>
</template>

<script>
export default {
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
      display: flex;
      flex-direction: row;
      justify-content: flex-end;
    }

    &--header {
      padding: 16px;
      border-bottom: 1px solid grey;

      &:hover {
        cursor: pointer;
      }

      &-active {
        @extend .tabs--header;

        border-bottom: 1px solid #57B65A;
      }
    }
  }
</style>
