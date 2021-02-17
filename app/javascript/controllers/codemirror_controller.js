import { Controller } from 'stimulus';
import CodeMirror from 'codemirror';
// import 'codemirror/theme/duotone-dark.css'

export default class extends Controller {
  static targets = ["wrapper", "mirror", "body", "description"];
  static values = {
    modes: Array,
    code: String,
    mode: String,
    initialized: Boolean,
    readOnly: Boolean
  }

  connect() {
    if (this.shouldInitialize()) {
      this.initializeCodeMirror()
      this.setCodeMirrorValue()
      if (this.hasModeValue) { this.importMode(this.modeValue) }
      this.addEventListeners()
    }
  }

  initializeCodeMirror() {
    this.codeMirror = CodeMirror.fromTextArea(this.mirrorTarget, {
      theme: 'one-light',
      mode: 'javascript',
      readOnly: this.readOnlyValue ? 'nocursor' : false
    });

    this.initializedValue = true
  }

  setCodeMirrorValue() {
    const value = this.hasCodeValue ? this.codeValue : "updateMode(event) {\n  const modeId = event.target.value\n  const mode = this.modeFromId(modeId)\n  const hasMode = Object.keys(CodeMirror.modes).includes(mode)\n\n  !hasMode ? this.importMode(mode) : this.setMode(mode)\n}\n\nsetMode(mode) {\n  this.codeMirror.setOption(\"mode\", mode);\n}"
    this.codeMirror.setValue(value)
  }

  updateMode(event) {
    const modeId = event.target.value
    const mode = this.modeFromId(modeId)
    const hasMode = Object.keys(CodeMirror.modes).includes(mode)

    !hasMode ? this.importMode(mode) : this.setMode(mode)
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

  importMode(mode) {
    import(`codemirror/mode/${mode}/${mode}.js`)
      .then(() => this.setMode(mode))
      .catch(console.error)
  }

  setMode(mode) {
    this.codeMirror.setOption("mode", mode);
  }

  modeFromId(modeId) {
    return this.modesValue.find(mode => {
      return Number(mode.id) === Number(modeId)
    }).slug
  }
}
