import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["alert", "confirm", "body", "header"];
  
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
    
    if (listItem.dataset.redirectAfterDelete) {
      Turbolinks.visit('/')
    } else {
      listItem.remove()
      this.toast.display(event.currentTarget.dataset.toastMessage)
      this.close()
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
