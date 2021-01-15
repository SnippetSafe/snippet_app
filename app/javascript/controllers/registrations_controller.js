import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['name', 'errors'];

  connect() {
    document.activeElement.blur();
    this.nameTarget.focus();
  }

  onSignUpSuccess(event) {
    const [data, status, xhr] = event.detail;
    const urlWithToast = encodeURI(`${location.toString()}?notice=${data.message}`)
    Turbolinks.visit(urlWithToast)
  }

  onSignUpError(event) {
    // TODO: Display specific errors
    const [data, status, xhr] = event.detail;
    this.errorsTarget.innerHTML = data.element
    this.toast.display(data.message, 'alert')
  }

  get toast() {
    return document.getElementById('toast').toast
  }
}
