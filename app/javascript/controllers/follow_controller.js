import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ['container'];
  static values = {
    id: String
  };

  follow(event) {
    event.stopPropagation();

    axios.post(this.followUrl)
      .then(res => {
        this.containerTarget.innerHTML = res.data
      })
      .catch(console.error)
  }

  unfollow() {
    event.stopPropagation();

    axios.post(this.unfollowUrl)
      .then(res => {
        this.containerTarget.innerHTML = res.data
      })
      .catch(console.error)
  }

  get followUrl() {
    return `/users/${this.idValue}/follow`
  }

  get unfollowUrl() {
    return `/users/${this.idValue}/unfollow`
  }
}
