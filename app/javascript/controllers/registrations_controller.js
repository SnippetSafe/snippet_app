import { Controller } from 'stimulus';

export default class extends Controller {
  onSignUpSuccess(event) {
    const [data, status, xhr] = event.detail;
    const urlWithToast = encodeURI(`${location.toString()}?notice=${data.message}`)
  }

  onSignUpError(event) {
    const [data, status, xhr] = event.detail;
    this.toast.display(data.message)
  }

  get toast() {
    return document.getElementById('toast').toast
  }
}
