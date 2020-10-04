import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["field", "submit"];

  connect() {
    this.initialValues = this.fieldTargets.map(target => target.value)
  }

  validateInput(event) {
    const index = this.fieldTargets.indexOf(event.target)
    const initialValue = this.initialValues[index]

    if (initialValue !== event.target.value) {
      this.enableSubmit()
    } else {
      if (this.changedFields().length > 0) {
        this.enableSubmit()
      } else {
        this.disableSubmit()
      }
    }
  }

  enableSubmit() {
    this.submitTarget.classList.remove("button--cta-disabled")
    this.submitTarget.classList.add("button--cta-blue")
    this.submitTarget.disabled = false
  }

  disableSubmit() {
    this.submitTarget.classList.remove("button--cta-blue")
    this.submitTarget.classList.add("button--cta-disabled")
    this.submitTarget.disabled = true
  }

  changedFields() {
    return this.fieldTargets.filter(target => {
      const index = this.fieldTargets.indexOf(target)
      const initialValue = this.initialValues[index]
      
      return initialValue !== target.value
    })
  }
}
