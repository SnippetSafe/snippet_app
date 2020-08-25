import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
	static targets = ["popover"];

  display(event) {
    event.preventDefault();
    event.stopPropagation()

    if (this.hasPopoverTarget && !this.popoverTarget.classList.contains('hidden')) {
      this.hideAllPopovers()

      this.popoverTarget.classList.add('hidden')
    } else if (this.hasPopoverTarget && this.popoverTarget.classList.contains('hidden')) {
      this.hideAllPopovers()

      this.popoverTarget.classList.remove('hidden')
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
      this.popoverTarget.classList.add('hidden')
    }
  }

  retain_focus(event) {
    event.preventDefault()
  }

  confirm(event) {
    event.preventDefault();

    console.log('text', this.confirmText)
  }

  disconnect() {
    if (this.hasPopoverTarget) { this.PopoverTarget.remove() }
  }

  hideAllPopovers() {
    Array.from(document.getElementsByClassName('popover--container')).forEach(el => {
      el.classList.add('hidden')
    })
  }

  get url() {
		return this.data.get('url')
  }
  
  get confirmText() {
    return this.data.get('confirm')
  }
}
