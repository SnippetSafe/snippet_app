import { Controller } from 'stimulus';

export default class extends Controller {

  presentModal(event) {
    event.stopPropagation()
    const target = event.currentTarget || event.target
    this.modal.present(target.dataset.modalUrl)
  }

  get modal() {
    return document.getElementById('modal').modal
  }
}
