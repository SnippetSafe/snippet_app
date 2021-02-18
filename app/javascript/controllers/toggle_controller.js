import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ['background', 'text', 'toggle', 'value']
  static classes = ['enabledColor', 'disabledColor', 'enabledTranslate', 'disabledTranslate']
  static values = {
    enabledText: String,
    disabledText: String,
    enabled: Boolean,
    flip: Boolean
  }

  toggle() {
    this.toggleValue()
    this.toggleToggle()
    this.toggleText()
  }

  toggleValue() {
    this.enabledValue = !this.enabledValue
    
    if (this.flipValue) {
      this.valueTarget.value = !this.enabledValue
    } else {
      this.valueTarget = this.enabledValue
    }
  }

  toggleToggle() {
    this.backgroundTarget.classList.toggle(this.enabledColorClass)
    this.backgroundTarget.classList.toggle(this.disabledColorClass)
    this.toggleTarget.classList.toggle(this.enabledTranslateClass)
    this.toggleTarget.classList.toggle(this.disabledTranslateClass)
  }

  toggleText() {
    if (this.isEnabled) {
      this.textTarget.innerHTML = this.enabledTextValue
    } else {
      this.textTarget.innerHTML = this.disabledTextValue
    }
  }

  get isEnabled() {
    return this.enabledValue
  }
}
