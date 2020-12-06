import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['name'];

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
    const [data, status, xhr] = event.detail;
    this.toast.display(data.message)
  }

  presentModal(event) {
    this.modal.present(event.target.dataset.modalUrl)
  }

  get toast() {
    return document.getElementById('toast').toast
  }

  get modal() {
    return document.getElementById('modal').modal
  }
}