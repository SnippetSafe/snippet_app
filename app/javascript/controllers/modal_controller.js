import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["modal"];
  
  connect() {
    this.element[this.identifier] = this
  }

  present() {
    event.preventDefault()

    axios.get(this.url)
      .then(res => {
        document.getElementById('vue-app').insertAdjacentHTML('afterbegin', res.data);
      })
      .catch(console.error)
  }

  close() {
    this.modalTarget.remove()
  }

  get url() {
    return this.data.get('url')
  }
}
