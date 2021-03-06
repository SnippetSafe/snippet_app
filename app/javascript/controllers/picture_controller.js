import { Controller } from 'stimulus';
import domtoimage from 'dom-to-image';

export default class extends Controller {
	static targets = ['code']

	capture() {
		const scale = 2;
		const node = this.codeTarget
		const options = {
			height: node.offsetHeight * scale,
			width: node.offsetWidth * scale,
			style: {
				transform: "scale(" + scale + ")",
				transformOrigin: "top left",
				width: node.offsetWidth + "px",
				height: node.offsetHeight + "px"
			}
		}

		domtoimage.toJpeg(node, options)
			.then(this.downloadImage)
			.catch(console.error)
	}

	downloadImage(dataUrl) {
		let link = document.createElement('a')

		link.setAttribute('download', 'snippetsafe.jpeg');
		link.setAttribute('href', dataUrl);
		link.click();
		link.remove()
	}
}