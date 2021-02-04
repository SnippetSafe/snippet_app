import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["entries", "body"];
  
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
