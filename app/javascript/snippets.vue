<template>
	<div v-infinite-scroll="getItems" infinite-scroll-disabled="busyOrMaximum" infinite-scroll-distance="200">
		<snipt
			v-for="item in items"
			@deleted="handleItemDeletion"
			:snippet="item"
			:key="item.id">
		</snipt>
    <img style="display: block; margin: 20px auto;" v-if="isFirstLoad" src="/icons/loader-grey.svg" width="50">
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
