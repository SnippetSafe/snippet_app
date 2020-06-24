import axios from 'axios'

export default {
  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
    axios.defaults.headers.common['Accept'] = 'application/json'
  },

  methods: {
    updateUser(userForm) {
      const config = {
        headers: {
            'content-type': 'multipart/form-data'
        }
    }

      return axios.put(`/users/modify?ajax=true`, userForm, config)
    },

    followUser(userId) {
      return axios.post(`/users/${userId}/follow?ajax=true`)
    },

    unfollowUser(userId) {
      return axios.post(`/users/${userId}/unfollow?ajax=true`)
    }
  }
}
