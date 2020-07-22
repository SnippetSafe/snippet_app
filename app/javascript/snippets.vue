<template>
	<div v-infinite-scroll="getItems" infinite-scroll-disabled="busyOrMaximum" infinite-scroll-distance="200">
		<snipt
			v-for="item in items"
			@deleted="handleItemDeletion"
			:snippet="item"
			:key="item.id">
		</snipt>
    <loader v-if="isFirstLoad" />
	</div>
</template>

<script>
import searchMixin from './mixins/searchMixin';
import Snipt from './snipt';

export default {
  components: { Snipt },

  mixins: [searchMixin],

  data() {
    return {
      resourceName: 'snippets'
    }
  },
}
</script>
