import { Controller } from 'stimulus';
import axios from 'axios';

export default class extends Controller {
  static targets = ["alert", "confirm", "body", "header"];
  static values = { url: String };

  present(event) {
    event.preventDefault();
    event.stopPropagation();

    axios.get(this.urlValue)
      .then(res => {
        document.body.insertAdjacentHTML('afterbegin', res.data);
      })
      .catch(console.error)
  }

  deleteSuccess(event) {
    const resourceId = event.currentTarget.dataset.resourceId
    const listItem = document.getElementById(resourceId)
    
    if (listItem.dataset.redirectAfterDelete) {
      Turbolinks.visit('/')
    } else {
      listItem.remove()
      this.toast.display(event.currentTarget.dataset.toastMessage)
      this.close()
    }
  }

  unfileSuccess(event) {
    this.toast.display(event.currentTarget.dataset.toastMessage)
    this.close()
  }

  close() {
    if (this.hasAlertTarget) { this.alertTarget.remove(); };
  }

  get toast() {
    return document.getElementById('toast').toast
  }
}
