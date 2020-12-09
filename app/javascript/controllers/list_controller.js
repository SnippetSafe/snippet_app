import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {

  static values = {
    url: String
  }

  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  }

  connect() {
    console.log(this.urlValue)
    axios.get(this.urlValue)
      .then(res => {
        console.log(res)
      })
      .catch(console.error)
  }
}
