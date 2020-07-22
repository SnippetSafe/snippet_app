<template>
  <div class="empty-state-message">
    <a :href="href">{{ text }}, why not create one?</a>
  </div>
</template>

<script>
export default {
  props: {
    text: { type: String, default: "No results to show" },
    href: { type: String, default: "/snippets/new" },
  }
}
</script>
