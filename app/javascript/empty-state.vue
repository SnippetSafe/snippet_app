<template>
  <div class="empty-state--wrapper">
    <a class="empty-state--container" :href="href">
      <img src="/icons/edit-grey.svg" width="40">
      <p>You haven't added any snippets to this folder.</p>
      <span>Click here to add one.</span>
    </a>
  </div>
</template>

<script>
export default {
  props: {
    href: { type: String, required: true }
  }
}
</script>
