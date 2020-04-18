<template>
  <i :class="buttonClass"></i>
</template>

<script>
export default {
  props: {
    type: { required: true, type: String }
  },

  computed: {
    buttonClass() {
      return `fas fa-${this.type}`
    }
  }
}
</script>
