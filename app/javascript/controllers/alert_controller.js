import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["alert"];
  
  present(event) {
    event.preventDefault()

    axios.get(this.url)
      .then(res => {
        document.getElementById('vue-app').insertAdjacentHTML('afterbegin', res.data);
      })
      .catch(console.error)
  }

  close(event) {
    this.alertTarget.remove()
  }

  get url() {
    return this.data.get('url')
  }
}
