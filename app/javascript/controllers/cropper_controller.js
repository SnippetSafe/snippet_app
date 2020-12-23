import { Controller } from 'stimulus'
import { events } from '../mixins/events'
import axios from 'axios';

export default class extends Controller {
  static targets = ['image']

  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
    axios.defaults.headers.common['Accept'] = 'application/json'
  }

  connect() {
    events(this)

    this.populateCropper()
  }
  
  populateCropper() {
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
      let formData = new FormData();

      formData.append('user[avatar]', blob);

      const self = this;

      axios({
        method: 'put',
        url: '/users/modify',
        data: formData
        })
        .then(function (response) {
          self.upload.avatarTarget.setAttribute('src', canvas.toDataURL())
          
          self.emitEvent('update-image', { src: response.data.avatar_url })
          self.emitEvent('close-modal')
        })
        .catch(function (response) {
          //handle error
          console.log(response);
          self.emitEvent('close-modal')
        });
    })
  }

  get upload() {
    return document.getElementById('upload').upload
  }
}
