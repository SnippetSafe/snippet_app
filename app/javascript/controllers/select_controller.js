import { Controller } from 'stimulus';
import { events } from '../mixins/events'
import axios from 'axios';

export default class extends Controller {
  static values = {
    url: String
  }

  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
    axios.defaults.headers.common['Accept'] = 'application/json'
    events(this);
  }

  change(event) {
    const newThemeId = event.target.value

    axios.put(this.urlValue, { theme_id: newThemeId})
      .then(res => {
        this.emitEvent('change-theme', res.data.theme)
      })
      .catch(console.error)
  }
}