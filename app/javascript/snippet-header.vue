<template>
  <div class="snippet-header--container">
    <a v-if="href" :href="href" class="snippet-header--filename-link">{{ filename }}</a>
    <span v-else class="snippet-header--filename">{{ filename }}</span>
  </div>
</template>

<script>
export default {
  props: { 
    filename: { required: true, type:  String },
    href: { required: false, type:  String },
  }
}
</script>

<style lang="scss">
  .snippet-header {
    &--container {
      background-color: #FAFBFC;
      border: 1px solid lightgrey;
      border-bottom: none;
    }

    &--filename {
      display: block;
      margin: 10px 0px 10px 16px;
      font-family: Helvetica, sans-serif;
      font-size: 14px;
      text-decoration: none;

      &-link {
        @extend .snippet-header--filename;

        &:hover { text-decoration: underline; }
      }
    }
  }
</style>
