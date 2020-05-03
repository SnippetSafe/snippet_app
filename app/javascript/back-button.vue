<template>
  <a class="back-button" :href="backUrl">
    <img src="/icons/return.svg" width="20">
  </a>
</template>

<script>
export default {
  computed: {
    backUrl() {
      return document.referrer
    }
  }
}
</script>
