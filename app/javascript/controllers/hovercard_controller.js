import { Controller } from 'stimulus';

export default class extends Controller {
	static targets = ["card"];

  connect() {
		
		console.log('d', this.data)
    console.log("hello from StimulusJS")
  }

  show() {
		console.log('show')

		fetch(this.url)
			.then((r) => r.text())
			.then((html) => {
				const fragment = document
					.createRange()
					.createContextualFragment(html);

				this.element.appendChild(fragment);
			});
}
	
	hide() {
		console.log('hide')

		if (this.cardTarget) {
      // this.cardTarget.remove();
    }
	}

	get url() {
		return this.data.get('url')
	}
}