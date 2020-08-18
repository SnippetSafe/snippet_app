<template>
  <div v-if="presenting" class="alert-mask">
      <div class="alert-wrapper">
        <card class="alert-container">
          <div class="alert-header">
            <h3>{{ title }}</h3>
            <span>
              <img @click="cancel" class="alert-close" src="/icons/cancel.svg" width="22">
            </span>
          </div>

          <div class="alert-body">
            <span>{{ message }}</span>
          </div>

          <div class="alert-footer">
            <button class="button--cta-cancel" @click="cancel">
              CANCEL
            </button>
            <button class="button--cta-new" @click="confirmAction">
              {{ confirm }}
            </button>
          </div>
        </card>
      </div>
  </div>
</template>

<script>
import Card from './card';
import { EventBus } from './event-bus.js';

export default {
  components: { Card },

  props: {
    // header: { required: true, type: String }
  },

  data() {
    return {
      presenting: false,
      title: 'Alert!',
      message: 'message',
      onConfirm: () => { console.log('confirmed') },
    }
  },

  created() {
    EventBus.$on('presentAlert', this.present)
  },

  methods: {
    present(opts) {
      this.title = opts.title;
      this.message = opts.message;
      this.confirm = opts.confirm;
      this.onConfirm = opts.onConfirm;
      this.presenting = true;
    },

    cancel() {
      this.presenting = false;
    },

    confirmAction() {
      this.onConfirm();
      this.presenting = false;
    }
  }
}
</script>

<style lang="scss">
  .alert-mask {
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

.alert-mask:hover {
  cursor: auto;
}

.alert-wrapper {
  display: table-cell;
  vertical-align: middle;
}

.alert-container {
  max-width: calc(480px - 60px);
  margin: 0px auto;
  padding: 20px 30px;
  background-color: white;
  /* border-radius: 2px; */
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.33);
  transition: all 0.3s ease;
  /* font-family: Helvetica, Arial, sans-serif; */
}

.alert-header {
  display: flex;
  justify-content: space-between;
}

.alert-header h3 {
  margin-top: 0;
  font-family: Helvetica, sans-serif;
  font-weight: 100;
}

.alert-body {
  margin: 18px 0px 38px 0px;
}

.alert-footer {
  display: flex;
  justify-content: flex-end;
}

.alert-default-button {
  float: right;
}

.alert-close {
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

.alert-enter {
  opacity: 0;
}

.alert-leave-active {
  opacity: 0;
}

.alert-enter .alert-container,
.alert-leave-active .alert-container {
  -webkit-transform: scale(1.1);
  transform: scale(1.1);
}
</style>
