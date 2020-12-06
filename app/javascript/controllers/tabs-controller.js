import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['tab', 'panel'];

  change(event) {
    this.markTabAsActive(event)
    this.displayPanel(event)
    this.pushTabChangeToHistory(event)
  }

  markTabAsActive(event) {
    this.tabTargets.forEach(tab => tab.classList.remove('tabs--header-active'))
    event.currentTarget.classList.add('tabs--header-active')
  }

  displayPanel() {
    const index = this.tabTargets.indexOf(event.currentTarget)
    const activePanel = this.panelTargets[index]

    this.panelTargets.forEach(tab => tab.classList.add('hidden'))
    activePanel.classList.remove('hidden')
  }

  pushTabChangeToHistory(event) {
    const tabId = event.currentTarget.dataset.tabId

    if (tabId) {
      const url = new URL(window.location);
      url.searchParams.set('tab_id', event.currentTarget.dataset.tabId);
      window.history.pushState({}, '', url);
    }
  }
}
