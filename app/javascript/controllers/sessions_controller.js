import * as Turbo from "@hotwired/turbo"
import { Controller } from 'stimulus';

export default class extends Controller {
  onSignInSuccess(event) {
    const [data, status, xhr] = event.detail;
    const urlWithToast = encodeURI(`${location.toString()}?notice=${data.message}`)
    Turbo.visit(urlWithToast)
  }

  onSignInError(event) {
    const [data, status, xhr] = event.detail;
    this.toast.display(data.message, 'alert')
  }

  get toast() {
    return document.getElementById('toast').toast
  }
}
