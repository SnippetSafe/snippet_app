import axios from 'axios'

export default {
  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
    axios.defaults.headers.common['Accept'] = 'application/json'
  },

  methods: {
    updateFolder(folderId, params) {
      return axios.put(`/folders/${folderId}?ajax=true`, { folder: params })
    },

    deleteFolder(folderId) {
      return axios.delete(`/folders/${folderId}?ajax=true`)
    }
  }
}
