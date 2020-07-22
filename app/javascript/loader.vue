<template>
  <img class="loader" src="/icons/loader-grey.svg" :width="width">
</template>

<script>
export default {
  props: {
    width: { default: 50, type: Number }
  }
}
</script>
