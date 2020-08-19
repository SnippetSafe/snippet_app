import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["folderwrapper"];

  delete_alert(event) {
    event.preventDefault()

    axios.get(this.url)
      .then(res => {
        document.getElementById('vue-app').insertAdjacentHTML('afterbegin', res.data);
      })
      .catch(console.error)
  }

  move_modal() {
    event.preventDefault()

    axios.get(this.url)
      .then(res => {
        document.getElementById('vue-app').insertAdjacentHTML('afterbegin', res.data);
      })
      .catch(console.error)
  }

  move() {
    console.log('move')
  }

  select_folder(event) {
    const folderId = event.target.dataset.folderId

    if (folderId === this.selectedFolderId ) { return }

    const checkmark = document.getElementById('selected-checkmark')
    const checkmarkClone = checkmark.cloneNode(true)

    checkmark.remove()
    event.target.insertAdjacentElement("beforeend", checkmarkClone)
    this.selectedFolderId = folderId

    console.log('new folder selected?', this.selectedFolderId !== this.originalFolderId)
  }

  get url() {
    return this.data.get('url')
  }

  get selectedFolderId() {
    return this.data.get('selectedFolderId')
  }

  get originalFolderId() {
    return this.data.get('originalFolderId')
  }

  set selectedFolderId(folderId) {
    return this.data.set('selectedFolderId', folderId)
  }
}
