import { Controller } from 'stimulus';

export default class extends Controller {
  static values = {
    url: String
  }

  navigate() {
    Turbolinks.visit(this.urlValue)
  }
}
