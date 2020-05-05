<template>
  <div class="folders--row">
    <folder v-for="folder in folders" :key="folder.id" :folder="folder"></folder>
    <div v-for="i in (3 - folders.length)" :key="i" style="height: 100px; flex: 1 0 31%; text-align: center; padding: 24px 8px;"></div>
  </div>
</template>

<script>
import Folder from './folder';

export default {
  components: { Folder },

  props: { 
    folders: { required: true, type: Array }
  }
}
</script>
