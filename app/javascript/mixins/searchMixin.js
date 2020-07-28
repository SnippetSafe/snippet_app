import axios from 'axios'
import  { EventBus } from '../event-bus';
import Loader from '../loader';
import EmptyStateMessage from '../empty-state-message';

export default {

  components: { EmptyStateMessage, Loader },

  data() {
    return {
      hasMoreItems: true,
      busy: false,
      items: [],
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
    this.$store.commit('resetSearchParams')
    EventBus.$off('search', this.getItems)
  },

  computed: {
    endpoint() {
      return `/${this.resourceName}/search`
    },

    busyOrMaximum() {
      return this.busy || !this.hasMoreItems;
    },

    shouldDisplayEmptyState() {
      return (this.items.length === 0) && !this.isFirstLoad;
    },

    emptyStateText() {
      return `No ${this.resourceName} to display`;
    },

    emptyStateHref() {
      return `/${this.resourceName}/new`;
    }
  },

  methods: {
    getItems(reset = false) {
      if (reset) { this.hasMoreItems = true; }

      if (this.hasMoreItems && !this.busy) {
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
