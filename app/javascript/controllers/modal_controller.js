import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["modal", "header", "body"];
  
  connect() {
    this.element[this.identifier] = this
  }

  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  }

  present(event) {
    console.log('click', event.currentTarget.dataset)
    event.preventDefault();
    event.stopPropagation();

    axios.get(event.currentTarget.dataset.modalUrl)
      .then(res => {
        console.log(res)
        this.close();
        document.body.insertAdjacentHTML('afterbegin', res.data);
        // this.bodyTarget.insertAdjacentHTML('afterbegin', res.data);
        // this.modalTarget.classList.remove('hidden')
      })
      .catch(console.error)
  }

  close() {
    const modal = document.getElementById('modal')

    if (modal) { modal.remove(); };
  }
}
