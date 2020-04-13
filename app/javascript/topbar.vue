<template>
  <div id="header">
    <div id="header-wrapper">
      <div style="display: flex; align-items: center;">
        <span>SNIPPET</span>
      </div>

      <div style="display: flex; align-items: center;">
        <a @click="newSnippet" style="background-color: #57B65A; color: white; border-radius: 5px; border: 1px solid #57B65A; padding: 6px 10px; font-size: 12px; font-family: Helvetica, sans-serif;">NEW SNIPPET</a>
        <a style="border-radius: 5px; margin-left: 8px; border: 1px solid #003F63; padding: 6px 10px; font-size: 12px; font-family: Helvetica, sans-serif; text-decoration: none; background-color: #003F63; color: snow;" href="/">SIGN IN</a>
        <a style="border-radius: 5px; margin-left: 8px; border: 1px solid #003F63; padding: 6px 10px; font-size: 12px; font-family: Helvetica, sans-serif; text-decoration: none; color: #003F63;" href="/">SIGN UP</a>
      </div>
    </div>
  </div>
</template>

<script>
import  { EventBus } from './event-bus';

export default {
  methods: {
    newSnippet() {
      EventBus.$emit('openNewSnippetModal')
    }
  }
}
</script>
