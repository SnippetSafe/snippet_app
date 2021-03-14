import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["toast", "message", "noticeIcon", "alertIcon"];

  connect() {
    this.element[this.identifier] = this
  }
  
  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

    this.checkForNotice();
  }

  checkForNotice() {
    if (this.hasNotice()) {
      this.display(this.notice)
    } else if (this.hasAlert()) {
      this.display(this.alert, 'alert')
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
    this.displayIconForToastType(type)
    this.showToast()
  }
  
  showToast() {
    this.toastTarget.classList.remove('hidden')

    this.setToastTimeout()
  }

  hideToast() {
    this.toastTarget.classList.add('hidden')
  }

  displayIconForToastType(type) {
    this.iconTargets.forEach(this.hideIcon)

    this[`${type}IconTarget`].classList.remove('hidden')
  }

  hideIcon(iconTarget) {
    iconTarget.classList.add('hidden')
  }

  setToastTimeout() {
    const toastTimeoutInMilliseconds = 10000

    setTimeout(() => this.hideToast(), toastTimeoutInMilliseconds)
  }
  
  get notice() {
    return this.data.get('notice')
  }
  
  get alert() {
    return this.data.get('alert')
  }

  get iconTargets() {
    return [this.noticeIconTarget, this.alertIconTarget]
  }
}
