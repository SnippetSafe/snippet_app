<template>
  <i :class="[iconClass, actionClass]"></i>
</template>

<script>
export default {
  props: {
    type: { required: true, type: String },
    actioned: { required: false, default: false, type: Boolean }
  },

  computed: {
    iconClass() {
      return `fas fa-${this.type} `
    },

    actionClass() {
      const actionStatus = this.actioned ? 'actioned' : 'unactioned'

      return `action-icon--${this.type}-${actionStatus}`
    }
  },

  created() {
    console.log(this.buttonClasses)
  }
}
</script>

<style lang="scss">
  .action-icon {
    &--heart {
      &-actioned {
        color: red;
      }
    }
  }
</style>

</style>
