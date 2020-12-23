import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["modal", "header", "body"];
  static values = { url: String }

  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  }

  present(event) {
    event.preventDefault();
    event.stopPropagation();

    axios.get(this.urlValue)
      .then(res => {
        this.close();

        document.body.insertAdjacentHTML('afterbegin', res.data);
      })
      .catch(console.error)
  }

  close() {
    const modal = document.getElementById('modal')

    if (modal) { modal.remove(); };
  }
}
