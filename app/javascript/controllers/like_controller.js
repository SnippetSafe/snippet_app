import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ['container'];
  static values = {
    url: String
  };

  toggle(event) {
    event.stopPropagation();

    axios.post(this.urlValue)
      .then(res => {
        this.containerTarget.innerHTML = res.data
      })
      .catch(console.error)
  }
}