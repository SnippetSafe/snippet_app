import { Controller } from 'stimulus';
import axios from 'axios';
import Turbolinks from 'turbolinks'

export default class extends Controller {
  static targets = ["moveButton", "listItem"];

  view_snippet(event) {
    event.stopPropagation()
    const snippetUrl = event.currentTarget.dataset.snippetUrl

    // Turbolinks.visit(snippetUrl)
    window.location.href = snippetUrl
  }

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

  modal_search(event) {
    const searchTerm = event.target.value.toLowerCase();

    this.listItemTargets.forEach(item => {
      const folderName = item.getAttribute('data-filter-key').toLowerCase()

      if (folderName.includes(searchTerm)) {
        item.classList.remove('hidden')
      } else {
        item.classList.add('hidden')
      }
    })
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
