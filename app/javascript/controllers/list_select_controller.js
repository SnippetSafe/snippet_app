import { Controller } from 'stimulus'
import axios from 'axios';
import { events } from "../mixins/events";

export default class extends Controller {
	static targets = ['button', 'item', 'checkmark']
	static values = {
		selectedId: Number,
		originalId: Number,
		confirmPath: String
	}

	initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  }

	connect() {
		events(this)
		this.buttonTarget.disabled = true
	}

	selectFolder(event) {
		const currentSelection = event.currentTarget
		const id = currentSelection.dataset.id
		const previousSelection = this.previouslySelected()

		if (currentSelection === previousSelection ) { return }

		this.reassignClasses(previousSelection, currentSelection)
		this.reassignCheckmark(currentSelection)
		this.selectedIdValue = id
		this.toggleButton()
	}

	previouslySelected() {
		return this.itemTargets.find(item => {
			return Number(item.dataset.id) === this.selectedIdValue 
		})
	}

	reassignClasses(previousSelection, currentSelection) {
		previousSelection.classList.remove('move-snippet--item-selected')
		previousSelection.classList.add('move-snippet--item')
		currentSelection.classList.remove('move-snippet--item')
		currentSelection.classList.add('move-snippet--item-selected')
	}

	reassignCheckmark(currentSelection) {
		const checkmark = this.checkmarkTarget
		const checkmarkClone = checkmark.cloneNode(true)
		
		checkmark.remove()
		currentSelection.insertAdjacentElement("beforeend", checkmarkClone)
	}

	toggleButton() {
		if (this.selectedIdValue === this.originalIdValue) {
      this.buttonTarget.disabled = true
      this.buttonTarget.classList.remove('button--cta-primary')
      this.buttonTarget.classList.add('button--disabled')
    } else {
      this.buttonTarget.disabled = false
      this.buttonTarget.classList.remove('button--disabled')
      this.buttonTarget.classList.add('button--cta-primary')
    }
	}
	
	search(event) {
    const searchTerm = event.target.value.toLowerCase();

    this.itemTargets.forEach(item => {
      const folderName = item.dataset.filterValue.toLowerCase()

      if (folderName.includes(searchTerm)) {
        item.classList.remove('hidden')
      } else {
        item.classList.add('hidden')
      }
    })
	}

	file() {
    axios.post(this.confirmPathValue, { folder_id: this.selectedIdValue }, { headers: { 'accept': 'application/json' } })
      .then(() => this.emitEvent('close-modal'))
      .catch(console.error)
  }
}