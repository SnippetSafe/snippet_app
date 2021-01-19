import { Controller } from 'stimulus';
import { events } from "../mixins/events";
import axios from 'axios';

export default class extends Controller {
  static targets = ['body', 'folder', 'pagination'];
  static values = {
    folderId: String
  };

  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  }

  connect() {
    this.getSnippetsForSelectedFolder()
    this.folderTargets[0].classList.add('selected')
    this.stopPropagationOnLinks()
  }

  selectFolder(event) {
    const folderId = event.currentTarget.dataset.folderId
    this.folderIdValue = folderId
    
    this.folderTargets.forEach(target => {
      target.classList.remove('selected')
    })
    event.currentTarget.classList.add('selected')

    this.getSnippetsForSelectedFolder()
  }

  getSnippetsForSelectedFolder() {
    axios.get(`/folders/${this.folderIdValue}/snippets`)
      .then(res => {
        this.bodyTarget.innerHTML = res.data
      })
      .catch(console.error)
  }

  stopPropagationOnLinks() {
    this.element.querySelectorAll('a').forEach(link => {
      link.onclick = (event) => { event.stopPropagation() }
    })
  }
}
