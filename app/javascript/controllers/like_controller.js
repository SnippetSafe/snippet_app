import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ['container'];
  static values = {
    url: String
  };

  connect() {
    console.log('c')
  }

  toggle(event) {

    console.log('this', this.urlValue)
    event.stopPropagation();

    axios.post(this.urlValue)
      .then(res => {
        this.containerTarget.innerHTML = res.data
      })
      .catch(console.error)
  }
}