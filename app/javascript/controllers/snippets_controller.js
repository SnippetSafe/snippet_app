import { Controller } from 'stimulus';
import { events } from "../mixins/events";

export default class extends Controller {
  static targets = ["moveButton", "listItem", "errors"];

  connect() {
    events(this)
  }

  update(event) {
    const element = document.getElementById(event.detail.client_id)

    if (element) {
      element.outerHTML = event.detail.element
    }
  }

  onCreateSuccess(event) {
    const [data, status, xhr] = event.detail;
    
    this.emitEvent('snippet-created', data)
    this.emitEvent('close-modal');

    this.toast.display('Your snippet was created!')
  }

  onCreateError(event) {
    const [data, status, xhr] = event.detail;
    this.errorsTarget.innerHTML = data.element;
  }

  onUpdateSuccess(event) {
    const [data, status, xhr] = event.detail;

    this.emitEvent('snippet-updated', data)
    this.emitEvent('close-modal');
    this.toast.display('Your snippet was updated!')
  }

  onUpdateError(event) {
    const [data, status, xhr] = event.detail;
    this.errorsTarget.innerHTML = data.element;
  }

  onDeleteSuccess(event) {
    const [data, status, xhr] = event.detail;
    const resourceId = data.resource_id
    const element = document.getElementById(resourceId)
    
    if (element.dataset.redirectAfterDelete) {
      Turbolinks.visit('/')
    } else {
      element.remove()
      this.emitEvent('close-alert')
    }
  }

  onDeleteError() {
    this.emitEvent('close-alert')
  }

  get url() {
    return this.data.get('url')
  }

  get toast() {
    return document.getElementById('toast').toast
  }
}
