import { Controller } from 'stimulus';
import { events } from '../mixins/events'

export default class extends Controller {
  initialize() {
    events(this);
  }

  change(event) {
    const newTheme = event.target.value

    this.emitEvent('change-theme', newTheme)
  }
}