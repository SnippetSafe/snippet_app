import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = [];

  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  }

  presentModal(event) {
    event.stopPropagation()
    const target = event.currentTarget || event.target
    console.log('e', target.dataset)
    this.modal.present(target.dataset.modalUrl)
  }

  get modal() {
    return document.getElementById('modal').modal
  }
}
