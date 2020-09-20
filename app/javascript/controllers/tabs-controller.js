import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['tab', 'panel'];

  change(event) {
    this.markTabAsActive(event)
    this.displayPanel(event)
  }

  markTabAsActive() {
    this.tabTargets.forEach(tab => tab.classList.remove('tabs--header-active'))
    event.currentTarget.classList.add('tabs--header-active')
  }

  displayPanel() {
    const index = this.tabTargets.indexOf(event.currentTarget)
    const activePanel = this.panelTargets[index]

    this.panelTargets.forEach(tab => tab.classList.add('hidden'))
    activePanel.classList.remove('hidden')
  }
}
