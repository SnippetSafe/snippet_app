import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["count"];
  static values = {
    count: Number
  }

  increment(event) {
    this.countValue += 1
    this.countTarget.textContent = this.countValue
  }

  decrement(event) {
    this.countValue -= 1
    this.countTarget.textContent = this.countValue
  }
}
