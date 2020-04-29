<template>
  <div @click.prevent="performAction" class="action-button--wrapper">
    <action-icon :type="type" :actioned="hasActioned"></action-icon>
    <span class="action-button--count">{{ count }}</span>
  </div>
</template>

<script>
import ActionIcon from './action-icon.vue';

export default {
  components: { ActionIcon },

  props: {
    snippet: { type: Object, required: true },
    type: { required: true, type: String },
    count: { required: true, type: Number },
    action: { required: true, type: Function },
    hasActioned: { required: true, type: Boolean },
  },

  created(){
    console.log(this.type, this.hasActioned)
  },

  methods: {
    performAction() {
      console.log(`performing action for ${this.type} on snippet ${this.snippet.filename}`)
      this.action()
        // .then(res => {
        //   console.log(res)
        //   const comment = res.data.like
        //   // console.log(this.snippet)
        //   this.count += 1
        //   // this.resetCommentForm()
        //   // this.$emit('commentCreated', comment)
        // })
        // .catch(console.error)
    }
  }
}
</script>

<style lang="scss" scoped>
  .action-button {
    &--wrapper {
      flex: 1;
      text-align:center;
      color: grey;
      margin-top: 11px;
      margin-bottom: 11px;
      font-size: 14px;

      &:hover {
        cursor: pointer;
        color: #003F63;
      }
    }

    &--count {
      margin-left: 8px;
    }
  }
</style>
