import { Controller } from 'stimulus';
import { events } from "../mixins/events";

export default class extends Controller {
  static targets = ["entries", "body"];
  
  connect() {
    events(this)
  }

  update(event) {
    const element = document.getElementById(event.detail.client_id)

    if (element) { element.outerHTML = event.detail.element }
  }

  onCreateSuccess(event) {
    const [data, status, xhr] = event.detail;
    
    this.entriesTarget.insertAdjacentHTML('beforeend', data.element)
    this.entriesTarget.classList.remove('hidden')
    this.bodyTarget.value = ''
  }

  onCreateError(event) {
    const [data, status, xhr] = event.detail;
  }
}
