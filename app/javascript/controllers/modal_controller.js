import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["modal", "header", "body"];
  
  connect() {
    this.element[this.identifier] = this
  }

  present(url, opts = {}) {
    event.preventDefault()

    axios.get(url)
      .then(res => {
        this.bodyTarget.insertAdjacentHTML('afterbegin', res.data);
        if (opts.callback) { opts.callback() }
        this.modalTarget.classList.remove('hidden')
      })
      .catch(console.error)
  }

  close() {
    this.modalTarget.classList.add('hidden')
    this.bodyTarget.innerHTML = ''
  }

  get url() {
    return this.data.get('url')
  }
}
