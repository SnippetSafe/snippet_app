import { Controller } from 'stimulus'
import 'cropperjs/dist/cropper.css';
import Cropper from 'cropperjs';

export default class extends Controller {
  static targets = ['image']

  connect() {
    this.populateCropper()
  }
  
  populateCropper() {
    console.log(this.upload)
    this.imageTarget.setAttribute('src', this.upload.uploadedFile)

    this.cropper = new Cropper(this.imageTarget, {
      aspectRatio: 1/ 1
    });
  }

  handleImageCrop() {
    const canvas = this.cropper.getCroppedCanvas({
      width: 200,
      height: 200
    });

    canvas.toBlob(blob => {
      console.log('b', blob)
    })

    this.upload.avatarTarget.setAttribute('src', canvas.toDataURL())
    this.modal.close()
  }

  get upload() {
    return document.getElementById('upload').upload
  }

  get modal() {
    return document.getElementById('modal').modal
  }
}
