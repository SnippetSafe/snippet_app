import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['fileInput', 'avatar']

  connect() {
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

        self.modal.present('/users/edit_avatar_modal')
      }

      reader.readAsDataURL(input.files[0]);
    }
  }

  get modal() {
    return document.getElementById('modal').modal
  }

  set cropper(cropperObj) {
    return this.cropper = cropperObj
  }
}
