import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['text', 'icon', 'value']
  static values = {
    checkedText: String,
    uncheckedText: String,
    checkedIcon: String,
    uncheckedIcon: String
  }

  toggle() {
    this.toggleText();
    this.toggleIcon();
  }

  toggleText() {
    console.log()
  }

  toggleIcon() {
    if (this.isChecked) {
      this.textTarget.innerHTML = this.uncheckedTextValue
      this.iconTarget.setAttribute('src', this.uncheckedIconValue)
      this.valueTarget.value = false
    } else {
      this.textTarget.innerHTML = this.checkedTextValue
      this.iconTarget.setAttribute('src', this.checkedIconValue)
      this.valueTarget.value = true
    }
  }

  get isChecked() {
    return this.currentText === this.checkedTextValue
  }

  get currentText() {
    return this.textTarget.innerHTML
  }
}
