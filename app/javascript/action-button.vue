<template>
  <i  @click="performAction" :class="[ 'action-button--wrapper', buttonClass]"></i>
</template>

<script>
export default {
  props: {
    snippet: { type: Object, required: true },
    type: { required: true, type: String }
  },

  computed: {
    buttonClass() {
      return `fas fa-${this.type}`
    }
  },

  methods: {
    performAction() {
      console.log(`performing action for ${this.type} on snippet ${this.snippet.filename}`)
    }
  }
}
</script>

<style lang="scss" scoped>
  .action-button {
    &--wrapper {
      flex: 1;
      text-align:center;
      color: grey;
      margin-top: 11px;
      margin-bottom: 11px;
      font-size: 14px;

      &:hover {
        cursor: pointer;
        color: #003F63;
      }
    }
  }
</style>
