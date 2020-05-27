import axios from 'axios'

export default {
  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
    axios.defaults.headers.common['Accept'] = 'application/json'
  },

  methods: {
    fileSnippet(folderId, snippetId) {
      const params = { folder_id: folderId, snippet_id: snippetId }

      return axios.put(`/folders/file_snippet?ajax=true`, params)
    },
    updateFolder(folderId, params) {
      return axios.put(`/folders/${folderId}?ajax=true`, { folder: params })
    },

    deleteFolder(folderId) {
      return axios.delete(`/folders/${folderId}?ajax=true`)
    }
  }
}
