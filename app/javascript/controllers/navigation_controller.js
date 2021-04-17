import * as Turbo from "@hotwired/turbo"
import { Controller } from 'stimulus';

export default class extends Controller {
  static values = {
    url: String
  }

  connect() {
    this.stopPropagationOnLinks();
  }

  navigate() {
    Turbo.visit(this.urlValue)
  }

  stopPropagationOnLinks() {
    this.element.querySelectorAll('a').forEach(link => {
      link.onclick = (event) => { event.stopPropagation() }
    })
  }
}
