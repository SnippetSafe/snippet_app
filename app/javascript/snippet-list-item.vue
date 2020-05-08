<template>
  <div>
    <h4>{{ snippet.description }}</h4>
  </div>
</template>

<script>
export default {
  name: 'ffs',
  props: {
    snippet: { required: true, type: Object }
  }
}
</script>
