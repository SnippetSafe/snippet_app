import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["toast", "message"];

  connect() {
    this.element[this.identifier] = this
  }
  
  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

    this.checkForNotice();
  }

  checkForNotice() {
    if (this.hasNotice() || this.hasAlert()) {
      const message = this.hasNotice() ? this.notice : this.alert

      this.display(message)
    }
  }

  hasNotice() {
    return this.notice.length > 0
  }

  hasAlert() {
    return this.alert.length > 0
  }

  display(message, type = 'notice') {
    this.messageTarget.innerHTML = message
    this.toastTarget.classList.remove('hidden')
    setTimeout(() => this.hideToast(), 3000)
  }

  hideToast() {
    this.toastTarget.classList.add('hidden')
  }
  
  get notice() {
    return this.data.get('notice')
  }
  
  get alert() {
    return this.data.get('alert')
  }
}
