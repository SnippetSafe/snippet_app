import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['email'];

  connect() {
    document.activeElement.blur()
    this.emailTarget.focus()
  }

  onSignInSuccess(event) {
    const [data, status, xhr] = event.detail;
    const urlWithToast = encodeURI(`${location.toString()}?notice=${data.message}`)
    Turbolinks.visit(urlWithToast)
  }

  onSignInError(event) {
    const [data, status, xhr] = event.detail;
    this.toast.display(data.message)
  }

  get toast() {
    return document.getElementById('toast').toast
  }
}
