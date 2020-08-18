import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
	static targets = ["more", "popover"];

  display(event) {
    event.preventDefault();

    axios.get(this.url)
      .then(res => {
        document.body.insertAdjacentHTML('beforeend', res.data);
        let popover = document.body.lastElementChild

        const rect = event.target.getBoundingClientRect();
        const x = rect.right - popover.offsetWidth
        const y = window.pageYOffset + rect.bottom + 10

        popover.style.top = `${y}px`
        popover.style.left = `${x}px`
        popover.focus()
      })
      .catch(console.error)
  }

  hide(event) {
    this.element.remove()
  }

  retain_focus(event) {
    event.preventDefault()
  }

  get url() {
		return this.data.get('url')
	}
}
