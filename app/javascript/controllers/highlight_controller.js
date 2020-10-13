import { Controller } from 'stimulus';

export default class extends Controller {
  static targets = ["code", "languages", "highlightedBody"];

  connect() {
    this.addLanguagesToSelect()
  }

  highlight(event) {
    const rawCode = event.currentTarget.value
    const highlightedCode = hljs.highlight('ruby', rawCode).value

    this.codeTarget.innerHTML = highlightedCode
    this.highlightedBodyTarget.value = highlightedCode
  }

  addLanguagesToSelect() {
    hljs.listLanguages().forEach(language => {
      const option = document.createElement('option')
      option.text = language
      option.value = language

      this.languagesTarget.add(option)
    })
  }
}
