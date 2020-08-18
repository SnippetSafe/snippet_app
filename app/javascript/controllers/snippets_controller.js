import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {

  delete_alert(event) {
    event.preventDefault()
    console.log('ok', this.url)

    axios.get(this.url)
        .then(res => {
          document.getElementById('vue-app').insertAdjacentHTML('afterbegin', res.data);
        })
        .catch(console.error)
  }

  get url() {
    return this.data.get('url')
  }
}
