import * as Turbo from "@hotwired/turbo"
import { Controller } from 'stimulus';
import { events } from '../mixins/events'

export default class extends Controller {
  static targets = ["entries", "body", "count"];
  static values = {
    count: Number
  }

  initialize() {
    events(this);
  }
  
  onCreateSuccess(event) {
    const [data, status, xhr] = event.detail;
    
    this.entriesTarget.insertAdjacentHTML('beforeend', data.element)
    this.entriesTarget.classList.remove('hidden')
    this.bodyTarget.value = ''

    this.emitEvent('comment-created')
  }

  onCreateError(event) {
    const [data, status, xhr] = event.detail;
  }

  onDeleteSuccess(event) {
    const resourceId = event.currentTarget.dataset.resourceId
    const listItem = document.getElementById(resourceId)
    
    if (listItem.dataset.redirectAfterDelete) {
      Turbo.visit('/')
    } else {
      listItem.remove()
    }

    this.emitEvent('comment-deleted')
  }

  button(event) {
    this.countValue += 1
    this.countTarget.textContent = this.countValue
  }
}
