import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["moveButton"];

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
    
    console.log('selected', this.selectedFolderId)
    console.log('original', this.originalFolderId)
  }
  
  select_folder(event) {
    const folderId = event.target.dataset.folderId
    
    if (folderId === this.selectedFolderId ) { return }
    
    const previousSelection = this.element.getElementsByClassName('move-snippet--item-selected')[0]

    if (previousSelection) {
      previousSelection.classList.remove('move-snippet--item-selected')
      previousSelection.classList.add('move-snippet--item')
      const checkmark = document.getElementById('selected-checkmark')
      const checkmarkClone = checkmark.cloneNode(true)
      
      checkmark.remove()
      
      event.target.insertAdjacentElement("beforeend", checkmarkClone)
    } else {
      event.target.insertAdjacentHTML('beforeend', '<img id="selected-checkmark" src="/icons/checked.svg" width="14">')
    }
    
    event.target.classList.add('move-snippet--item-selected')
    
    this.selectedFolderId = folderId


    this.moveButtonTarget.href = this.moveButtonTarget.href.split('?')[0].concat(`?folder_id=${folderId}`)
    if (this.selectedFolderId === this.originalFolderId) {
      this.moveButtonTarget.disabled = true
      this.moveButtonTarget.classList.remove('button--cta-new')
      this.moveButtonTarget.classList.add('button--cta-disabled')
    } else {
      this.moveButtonTarget.disabled = false
      this.moveButtonTarget.classList.remove('button--cta-disabled')
      this.moveButtonTarget.classList.add('button--cta-new')
    }

    console.log('new folder selected?', this.selectedFolderId !== this.originalFolderId)
    console.log('mb', this.moveButtonTarget)
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
