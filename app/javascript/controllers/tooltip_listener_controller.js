import { Controller } from 'stimulus';

export default class extends Controller {
	static targets = ['tooltip']

	display() {
	  this.tooltipTarget.classList.remove('hidden')
	}

	hide() {
	  this.tooltipTarget.classList.add('hidden')
	}
}