import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['image']

  update(event) {
    console.log('e', event)
    this.element.setAttribute('src', event.detail.src)
  }
}
