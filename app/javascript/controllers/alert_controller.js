import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["alert", "confirm"];  d
  
  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  }
  present(event) {
    event.preventDefault()

    axios.get(this.url)
      .then(res => this.app.insertAdjacentHTML('afterbegin', res.data))
      .catch(console.error)
  }

  close(event) {
    this.alertTarget.remove()
  }

  confirm() {
    console.log(this.confirmPath)

    axios.delete(this.confirmPath, { headers: { 'accept': 'application/json' } })
      .then(res => {
        document.getElementById(this.resourceId).remove()
        this.alertTarget.remove()
        this.toast.display('Snippet deleted!')
      })
      .catch(error => {
        console.error(error)
        this.toast.display('Unable to delete snippet')
      })
  }

  get url() {
    return this.data.get('url')
  }

  get confirmPath() {
    return this.data.get('confirmPath')
  }

  get resourceId() {
    return this.data.get('resourceId')
  }

  get app() {
    return document.getElementById('vue-app')
  }

  get toast() {
    return document.getElementById('toast').toast
  }
}
