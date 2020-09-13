import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
	static targets = ["popover"];

  display(event) {
    event.preventDefault();
    event.stopPropagation()

    if (this.hasPopoverTarget) {
      this.popoverTarget.remove()
    } else {
      this.hideAllPopovers()

      axios.get(this.url)
        .then(res => {
          this.element.insertAdjacentHTML('beforeend', res.data);
        })
        .catch(console.error)
    }
  }

  hide(event) {
    if(this.hasPopoverTarget && !this.element.contains(event.target)) {
      this.popoverTarget.remove()
    }
  }

  retain_focus(event) {
    event.preventDefault()
  }

  confirm(event) {
    event.preventDefault();
  }

  disconnect() {
    if (this.hasPopoverTarget) { this.popoverTarget.remove() }
  }

  hideAllPopovers() {
    Array.from(document.getElementsByClassName('popover--container')).forEach(el => {
      el.remove()
    })
  }

  get url() {
		return this.data.get('url')
  }
  
  get confirmText() {
    return this.data.get('confirm')
  }
}
