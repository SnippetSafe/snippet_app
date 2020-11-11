import { Controller } from 'stimulus';
import marked from 'marked';

export default class extends Controller {
  static targets = ["code", "languages", "highlightedBody", "description"];

  connect() {
    this.addLanguagesToSelect()

    marked.setOptions({
      highlight: function(code, lang) {
        if (lang && lang !== '') {
          return hljs.highlight(lang, code).value;
        } else {
          return hljs.highlightAuto(code).value;
        }
      }
    });
    
  }

  updateDescription(event) {
    this.descriptionTarget.innerHTML = event.target.value
  }

  //  TODO: Pass in the selected language!!!
  highlight(event) {
    const rawCode = event.currentTarget.value
    const highlightedCode = marked(rawCode)

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
