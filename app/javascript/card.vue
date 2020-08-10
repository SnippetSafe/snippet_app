<template>
  <div :class="['card--container', { 'card--container-padding': withPadding }]">
    <slot></slot>
  </div>
</template>

<script>
export default {
  props: {
    withPadding: { default: true, type: Boolean }
  }
}
</script>
