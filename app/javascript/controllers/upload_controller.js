import { Controller } from 'stimulus'
import { events } from '../mixins/events'

export default class extends Controller {
  static targets = ['fileInput', 'avatar']

  connect() {
    events(this)

    this.element[this.identifier] = this
  }

  selectNewImage(event) {
    event.preventDefault()
    this.fileInputTarget.value = ''
    this.fileInputTarget.click()
  }

  handleFileSelect(event) {
    const input = event.target;

    if (input.files && input.files[0]) {
      const self = this;
      const reader = new FileReader();

      reader.onload = function(e) {
        self.uploadedFile = e.target.result
        self.emitEvent('open-avatar-modal')
      }

      reader.readAsDataURL(input.files[0]);
    }
  }

  set cropper(cropperObj) {
    return this.cropper = cropperObj
  }
}
