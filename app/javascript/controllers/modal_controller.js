import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["modal", "header", "body"];
  static values = { url: String }

  present(event) {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
    axios.defaults.headers.common['Accept'] = 'application/xhtml+xml'

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
    if (this.hasModalTarget) { this.modalTarget.remove(); };
  }
}
