import { Controller } from 'stimulus'
import axios from 'axios';

export default class extends Controller {
  static targets = ['image']

  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
    axios.defaults.headers.common['Accept'] = 'application/json'
  }

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
      
      let formData = new FormData();

      formData.append('user[avatar]', blob);

      const self = this;

      axios({
        method: 'put',
        url: '/users/modify',
        data: formData
        })
        .then(function (response) {
            const event = new CustomEvent('update-image', { detail: { src: response.data.avatar_url } })
            window.dispatchEvent(event)

            self.upload.avatarTarget.setAttribute('src', canvas.toDataURL())
            self.modal.close()
        })
        .catch(function (response) {
            //handle error
            console.log(response);
            self.modal.close()
        });
    })
  }

  get upload() {
    return document.getElementById('upload').upload
  }

  get modal() {
    return document.getElementById('modal').modal
  }
}
