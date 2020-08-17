import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
	static targets = ["popover"];

  display(event) {
    event.preventDefault();

    console.log('display popover', this.element)

    axios.get(this.url)
      .then(res => {
        document.body.insertAdjacentHTML('beforeend', res.data);
        let popover = document.body.lastElementChild

        const rect = event.target.getBoundingClientRect();
        console.log(rect)
        const x = rect.left - 126
        const y = window.pageYOffset + rect.bottom + 10

        popover.style.top = `${y}px`
        popover.style.left = `${x}px`
        popover.focus()

        popover.addEventListener('blur', (e) => { 
          console.log('hide')

          popover.remove()
        })
        console.log('oppoover', popover)

      })
      .catch(console.error)
  }

  hide() {
    console.log('hide')
  }

	disconnect() {
  }
  
  get url() {
		return this.data.get('url')
	}
}
