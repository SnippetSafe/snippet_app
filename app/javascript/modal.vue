<template>
  <div @click.prevent="()=> { }" class="modal-mask">
      <div class="modal-wrapper">
        <card class="modal-container">
          <div class="modal-header">
            <h3>{{ header }}</h3>
            <span>
              <img class="modal-close" @click.prevent="$emit('close')" src="/icons/cancel.svg" width="22">
            </span>
          </div>

          <div class="modal-body">
            <slot name="body">
              default body
            </slot>
          </div>

          <!-- <div class="modal-footer">
            <slot name="footer">
              default footer
              <button class="modal-default-button" @click="$emit('close')">
                close
              </button>
            </slot>
          </div> -->
        </card>
      </div>
  </div>
</template>

<script>
import Card from './card';
import  { EventBus } from './event-bus';

export default {
  components: { Card },

  props: {
    header: { required: true, type: String }
  },

  created() {
    EventBus.$on('closeModal', () => this.$emit('close'))
  }
}
</script>

<style lang="scss">
  .modal-mask {
  position: fixed;
  z-index: 9998;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: table;
  transition: opacity 0.3s ease;
}

.modal-mask:hover {
  cursor: auto;
}

.modal-wrapper {
  display: table-cell;
  vertical-align: middle;
}

.modal-container {
  max-width: calc(720px - 60px);
  margin: 0px auto;
  padding: 20px 30px;
  /* background-color: #fff; */
  /* border-radius: 2px; */
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  transition: all 0.3s ease;
  /* font-family: Helvetica, Arial, sans-serif; */
}

.modal-header {
  display: flex;
  justify-content: space-between;
}

.modal-header h3 {
  margin-top: 0;
  font-family: Helvetica, sans-serif;
  font-weight: 100;
}

.modal-body {
  margin-top: 20px;
}

.modal-default-button {
  float: right;
}

.modal-close {
  &:hover {
    cursor: pointer;
    background-color: #DEF2F1;
    border-radius: 50%;
  }
}

/*
 * The following styles are auto-applied to elements with
 * transition="modal" when their visibility is toggled
 * by Vue.js.
 *
 * You can easily play with the modal transition by editing
 * these styles.
 */

.modal-enter {
  opacity: 0;
}

.modal-leave-active {
  opacity: 0;
}

.modal-enter .modal-container,
.modal-leave-active .modal-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>
