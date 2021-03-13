import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["count"];
  static values = {
    count: Number
  }

  increment(event) {
    this.countValue += 1

    this.renderValueAndMargin()
  }

  decrement(event) {
    this.countValue -= 1

    this.renderValueAndMargin()
  }

  renderValueAndMargin() {
    if (this.countValue > 0) {
      this.countTarget.textContent = this.countValue
      this.countTarget.classList.add('ml-1')
    } else {
      this.countTarget.classList.remove('ml-1')
      this.countTarget.textContent = ''
    }
  }
}
