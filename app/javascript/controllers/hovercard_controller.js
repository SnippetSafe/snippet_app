import { Controller } from 'stimulus';

export default class extends Controller {
	static targets = ["card"];

  show() {
		if (this.hasCardTarget) {
      this.cardTarget.classList.remove("hidden");
    } else {
			fetch(this.url)
				.then((r) => r.text())
				.then((html) => {
					const fragment = document
						.createRange()
						.createContextualFragment(html);

					this.element.appendChild(fragment);
				});
		}
}
	
	hide() {
		if (this.hasCardTarget) {
			console.log('gfd', this.cardTarget.classList)
			this.cardTarget.classList.add("hidden")
		}
	}

	disconnect() {
		if (this.hasCardTarget) { this.cardTarget.remove() }
	}

	get url() {
		return this.data.get('url')
	}
}
