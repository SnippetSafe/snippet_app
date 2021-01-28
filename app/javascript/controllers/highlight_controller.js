import { Controller } from 'stimulus';
import marked from 'marked';
import hljs from 'highlightjs'

export default class extends Controller {
  static targets = ["code", "highlightedBody", "description"];

  connect() {
    // not a function as using shim. Find a way to use proper library
    console.log('hl', hljs.registerAlias)
    marked.setOptions({
      highlight: function(code, lang) {
        if (lang && lang !== '') {
          return hljs.highlight(lang, code).value;
        } else {
          return hljs.highlightAuto(code).value;
        }
      },
      langPrefix: 'hljs lang-'
    });
    
  }

  updateDescription(event) {
    this.descriptionTarget.innerHTML = event.target.value
  }

  highlight(event) {
    const rawCode = event.currentTarget.value
    const highlightedCode = marked(rawCode)

    this.codeTarget.innerHTML = highlightedCode
    this.highlightedBodyTarget.value = highlightedCode
  }
}
