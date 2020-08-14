import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
	static targets = ["card"];

  show(event) {
		console.log('event', event)

		// TODO: Implement so that card is moved if the y value changes and don't need to hit server each time
		// if (this.hasCardTarget) {
    //   this.cardTarget.classList.remove("hidden");
    // } else {
			const y = event.y

			let position = 'above';
			if (y < 200) { position = 'below' }

			axios.get(this.url, { params: { position } })
				.then(res => {
					this.element.insertAdjacentHTML('beforeend', res.data);
				})
				.catch(console.error)
		// }
}
	
	hide() {
		if (this.hasCardTarget) {
			// this.cardTarget.classList.add("hidden")
			this.cardTarget.remove();
		}
	}

	disconnect() {
		if (this.hasCardTarget) { this.cardTarget.remove() }
	}

	get url() {
		return this.data.get('url')
	}
}
