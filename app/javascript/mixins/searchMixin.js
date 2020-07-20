import axios from 'axios'
import  { EventBus } from '../event-bus';

export default {

  data() {
    return {
      hasMoreItems: true,
      busy: true,
      items: []
    }
  },

  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
    axios.defaults.headers.common['Accept'] = 'application/json'

    EventBus.$on('search', this.getItems)
    this.getItems();
  },

  destroyed() {
    this.$store.commit('resetSearchParams')
  },

  computed: {
    endpoint() {
      return `/${this.resourceName}/search`
    }
  },

  methods: {
    getItems(reset = false) {
      if (reset) {
        this.hasMoreItems = true;
        this.items = [];
      }

      if (this.hasMoreItems) {
        this.busy = true
        let params = this.$store.state.searchParams
  
        axios.get(this.endpoint, { params: params })
          .then(res => {
            const returnedItems = res.data.items
  
            if (returnedItems.length > 0) {
              this.items = this.items.concat(returnedItems)
              params.page += 1
              this.$store.commit('updateSearchParams', params)
            } else {
              this.hasMoreItems = false;
            }
            
            this.busy = false
          })
          .catch(console.error)
      }
    },
  }
}
