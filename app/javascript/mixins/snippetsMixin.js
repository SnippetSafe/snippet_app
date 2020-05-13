import axios from 'axios'

export default {
  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
    axios.defaults.headers.common['Accept'] = 'application/json'
  },

  methods: {
    updateSnippet(snippetId, params) {
      return axios.put(`/snippets/${snippetId}?ajax=true`, { snippet: params })
    }
  }
}
