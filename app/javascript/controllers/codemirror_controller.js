import { Controller } from 'stimulus';
import CodeMirror from 'codemirror';
import 'codemirror/mode/ruby/ruby.js'
// import 'codemirror/theme/duotone-dark.css'

export default class extends Controller {
  static targets = ["wrapper", "mirror", "body", "description"];
  static values = {
    code: String,
    initialized: Boolean,
    readOnly: Boolean
  }

  connect() {
    if (this.shouldInitialize()) {
      this.initializeCodeMirror()
      this.setCodeMirrorValue()
      this.addEventListeners()
    }
  }

  initializeCodeMirror() {
    this.codeMirror = CodeMirror.fromTextArea(this.mirrorTarget, {
      theme: 'one-light',
      mode: 'ruby',
      readOnly: this.readOnlyValue ? 'nocursor' : false
    });

    this.initializedValue = true
  }

  setCodeMirrorValue() {
    const value = this.hasCodeValue ? this.codeValue : ''
    this.codeMirror.setValue(value)
  }

  shouldInitialize() {
    return !this.initializedValue
  }

  addEventListeners() {
    var editor = document.querySelector('.CodeMirror');

    editor.addEventListener("click", (event) => {
      event.stopPropagation()
    })
  }
}
