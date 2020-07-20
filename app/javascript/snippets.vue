<template>
	<div v-infinite-scroll="getSnippets" infinite-scroll-disabled="busy" infinite-scroll-distance="200">
		<snipt
			v-for="snippet in snippets"
			@deleted="handleSnippetDeletion"
			:snippet="snippet"
			:key="snippet.id">
		</snipt>
    <img v-if="busy" src="/icons/loader-grey.svg" width="50">
	</div>
</template>

<script>
import Snipt from './snipt';
import axios from 'axios';

import  { EventBus } from './event-bus';

export default {
  components: { Snipt },
  
  data() {
    return {
      hasMoreSnippets: true,
      busy: true,
      snippets: []
    }
  },

	created() {
		const csrfToken = document.querySelector("meta[name=csrf-token]").content
		axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
		axios.defaults.headers.common['Accept'] = 'application/json'

    EventBus.$on('search', this.getSnippets)
    this.getSnippets();
  },
  
  destroyed() {
    this.$store.commit('resetSearchParams')
  },

	methods: {
		getSnippets(reset = false) {
      if (reset) {
        this.hasMoreSnippets = true;
        this.snippets = [];
      }

      if (this.hasMoreSnippets) {
        this.busy = true
        let params = this.$store.state.searchParams
  
        axios.get('/snippets/search', { params: params })
          .then(res => {
            const returnedSnippets = res.data.snippets
  
            if (returnedSnippets.length > 0) {
              this.snippets = this.snippets.concat(returnedSnippets)
              params.page += 1
              this.$store.commit('updateSearchParams', params)
            } else {
              this.hasMoreSnippets = false;
            }
            
            this.busy = false
          })
          .catch(console.error)
      }
    },
    
    handleSnippetDeletion(snippetId) {
      console.log('deleted')

      this.snippets = this.snippets.filter(s => {
        return s.id !== snippetId
      })
    },
	}
}
</script>
