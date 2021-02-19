import { Controller } from 'stimulus';
import { events } from '../mixins/events'

export default class extends Controller {
	static targets = ['tooltip']

	initialize() {
	  events(this);
	}

	display() {
	  this.tooltipTarget.classList.remove('hidden')
	  this.emitEvent('hide-tooltip')
	}

	hide() {
	  this.tooltipTarget.classList.add('hidden')
	  this.emitEvent('display-tooltip')
	}
}