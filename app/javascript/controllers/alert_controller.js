import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["alert", "confirm", "body", "header"];
  
  // initialize() {
  //   const csrfToken = document.querySelector("meta[name=csrf-token]").content
  //   axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  // }

  connect() {
    this.element[this.identifier] = this
  }

  present(url) {
    axios.get(url)
      .then(res => {
        this.bodyTarget.insertAdjacentHTML('afterbegin', res.data);
        this.alertTarget.classList.remove('hidden')
      })
      .catch(console.error)
  }

  close() {
    this.alertTarget.classList.add('hidden')
    this.bodyTarget.innerHTML = ''
  }

  deleteSuccess(event) {
    const resourceId = event.currentTarget.dataset.resourceId
    const listItem = document.getElementById(resourceId)
    
    if (listItem) {
      listItem.remove()
      this.toast.display(event.currentTarget.dataset.toastMessage)
      this.close()
    } else {
      Turbolinks.visit('/')
    }
  }

  unfileSuccess(event) {
    this.toast.display(event.currentTarget.dataset.toastMessage)
    this.close()
  }

  get toast() {
    return document.getElementById('toast').toast
  }
}
