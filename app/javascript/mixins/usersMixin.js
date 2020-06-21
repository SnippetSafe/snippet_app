import axios from 'axios'

export default {
  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
    axios.defaults.headers.common['Accept'] = 'application/json'
  },

  methods: {
    updateUser(userParams) {
      return axios.put(`/users?ajax=true`, { user: userParams })
    },

    followUser(userId) {
      return axios.post(`/users/${userId}/follow?ajax=true`)
    },

    unfollowUser(userId) {
      return axios.post(`/users/${userId}/unfollow?ajax=true`)
    }
  }
}
