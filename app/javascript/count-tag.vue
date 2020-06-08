<template>
  <div>
    <a v-if="href" :href="href" :class="classForTag">{{ count }} {{ identifier }}</a>
    <span v-else :class="classForTag">{{ count }} {{ identifier }}</span>
  </div>
</template>

<script>
export default {
  props: {
    identifier: { type: String, required: true },
    count: { type: Number, required: true },
    color: { type: String, default: 'primary' },
    href: { type: String, required: false }
  },

  computed: {
    classForTag() {
      if (this.href) {
        return `tag--count-${this.color}--active`;
      } else {
        return `tag--count-${this.color}`;
      }
    }
  }
}
</script>
