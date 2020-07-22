import axios from 'axios'
import  { EventBus } from '../event-bus';
import Loader from '../loader';

export default {

  components: { Loader },

  data() {
    return {
      hasMoreItems: true,
      busy: false,
      items: [],
      active: true,
      isFirstLoad: true
    }
  },

  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
    axios.defaults.headers.common['Accept'] = 'application/json'

    EventBus.$on('folderDeleted', this.handleItemDeletion)
    EventBus.$on('search', this.getItems)
    this.getItems();
  },

  destroyed() {
    this.active = false;
    this.$store.commit('resetSearchParams')
  },

  computed: {
    endpoint() {
      return `/${this.resourceName}/search`
    },

    busyOrMaximum() {
      return this.busy || !this.hasMoreItems;
    }
  },

  methods: {
    getItems(reset = false) {
      if (reset) { this.hasMoreItems = true; }

      if (this.hasMoreItems && !this.busy && this.active) {
        this.busy = true
        let params = this.$store.state.searchParams
  
        axios.get(this.endpoint, { params: params })
          .then(res => {
            if (reset) { this.items = []; }

            const returnedItems = res.data.items
  
            if ((returnedItems.length > 0) && (returnedItems.length < params.per_page)) {
              this.items = this.items.concat(returnedItems)
              this.hasMoreItems = false;
            } else if (returnedItems.length === params.per_page) {
              this.items = this.items.concat(returnedItems)
              params.page += 1
              this.$store.commit('updateSearchParams', params)
            } else {
              this.hasMoreItems = false;
            }
            
            this.busy = false;
            this.isFirstLoad = false;
          })
          .catch(console.error)
      }
    },

    handleItemDeletion(itemId) {
      this.items = this.items.filter(item => {
        return item.id !== itemId
      })
    }
  }
}
