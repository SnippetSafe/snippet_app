import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['entries']

  update(event) {
    const folderId = event.detail.folder_id
    const clientId = event.detail.client_id
    const element = document.getElementById(clientId)

    if (element) {
      if ((this.folderId && folderId) && (this.folderId !== folderId)) {
        element.remove()
      } else {
        element.outerHTML = event.detail.element
      }
    }
  }

  get folderId() {
    return this.data.get('id')
  }
}
