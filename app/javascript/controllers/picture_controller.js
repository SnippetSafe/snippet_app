import { Controller } from 'stimulus';
import domtoimage from 'dom-to-image';
import axios from 'axios'

export default class extends Controller {
	static targets = ['code']
  static values = {
    code: String,
    extension: String,
    mimeType: String
  }

  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  }

	toDataUrl() {
		return domtoimage.toPng(this.codeTarget, this.imageConfig)
	}

  toBlob() {
    return domtoimage.toBlob(this.codeTarget, this.imageConfig)
  }

  tweet() {
    this.toBlob()
      .then(this.tweetImage)
      .catch(console.error)
  }

  download() {
    this.toDataUrl()
      .then(this.downloadImage)
      .catch(console.error)
  }

  downloadRaw() {
    const fileName = `snippet.${this.extensionValue}`
    const blob = new Blob([this.codeValue], { type: this.mimeTypeValue });
    let anchorElement = document.createElement('a');

    anchorElement.download = fileName;
    anchorElement.href = URL.createObjectURL(blob);
    anchorElement.dataset.downloadurl = [
      this.mimeTypeValue,
      anchorElement.download,
      anchorElement.href
    ].join(':');
    anchorElement.style.display = "none";

    document.body.appendChild(anchorElement);
    anchorElement.click();
    document.body.removeChild(anchorElement);

    setTimeout(function() { URL.revokeObjectURL(anchorElement.href); }, 1500);
  }

  tweetImage(blob) {
    let formData = new FormData();
    formData.append('fname', 'tweet.png');
    formData.append('data', blob);

    const headers = { 'Content-Type': `multipart/form-data` }

    axios.post(`/tweets`, formData, { headers })
      .then(res => {
        const imageUrl = res.data.media_url

        window.open(`https://twitter.com/intent/tweet?text=${imageUrl}`)
      })
      .catch(console.error)
  }

	downloadImage(dataUrl) {
		let link = document.createElement('a')

		link.setAttribute('download', 'snippetsafe.png');
		link.setAttribute('href', dataUrl);
		link.click();
		link.remove()
	}

  get imageConfig() {
    const scale = 2;

		return {
			height: this.codeTarget.offsetHeight * scale,
			width: this.codeTarget.offsetWidth * scale,
			style: {
				transform: "scale(" + scale + ")",
				transformOrigin: "top left",
				width: this.codeTarget.offsetWidth + "px",
				height: this.codeTarget.offsetHeight + "px"
			}
		}
  }
}