<template>
  <div :class="formFieldClass">
    <label :for="inputId">{{ label }}</label>
    <textarea v-if="isTextarea" :id="inputId" :type="type" v-model="valueDup" @keyup="emitValueChange"/>
    <input v-else :id="inputId" :type="type" v-model="valueDup" @keyup="emitValueChange"/>
  </div>
</template>

<script>
export default {
  props: {
    marginTop: { type: Boolean, default: true },
    label: { type: String, required: true },
    type: { type: String, required: true },
    value: { type: String, required: true },
  },

  data() {
    return {
      valueDup: this.value
    }
  },

  computed: {
    formFieldClass() {
      return this.marginTop ? 'form-field' : 'form-field--no-margin-top'
    },

    inputId() {
      return `${this.label.toLowerCase()}-input`
    },

    isTextarea() {
      return this.type === 'textarea';
    }
  },

  methods: {
    emitValueChange() {
      this.$emit('input', this.valueDup)
    }
  }
}
</script>
