import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["field", "submit"];
  static classes = ["enabled", "disabled"];

  connect() {
    this.initialValues = this.fieldTargets.map(target => target.value)
  }

  validateInput(event) {
    const index = this.fieldTargets.indexOf(event.target)
    const initialValue = this.initialValues[index]

    if (initialValue !== event.target.value) {
      this.enableSubmit()
    } else {
      if (this.hasChangedFields()) {
        this.enableSubmit()
      } else {
        this.disableSubmit()
      }
    }
  }

  enableSubmit() {
    this.submitTarget.classList.remove(this.disabledClass)
    this.submitTarget.classList.add(this.enabledClass)
    this.submitTarget.disabled = false
  }

  disableSubmit() {
    this.submitTarget.classList.remove(this.enabledClass)
    this.submitTarget.classList.add(this.disabledClass)
    this.submitTarget.disabled = true
  }

  changedFields() {
    return this.fieldTargets.filter(target => {
      const index = this.fieldTargets.indexOf(target)
      const initialValue = this.initialValues[index]
      
      return initialValue !== target.value
    })
  }

  hasChangedFields() {
    return this.changedFields().length > 0;
  }
}
