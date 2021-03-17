import { Controller } from 'stimulus';
import CodeMirror from 'codemirror';
import 'codemirror/mode/meta.js'
import 'codemirror/theme/lucario.css'

export default class extends Controller {
  static targets = ["wrapper", "mirror", "body", "description"];
  static values = {
    modes: Array,
    code: String,
    modeId: String,
    initialized: Boolean,
    readOnly: Boolean,
    isCapture: Boolean,
  }

  connect() {
    if (this.shouldInitialize()) {
      this.initializeCodeMirror()
      this.setCodeMirrorValue()

      if (this.hasModeIdValue) {
        this.importModeFromId(this.modeIdValue)
      }

      this.addEventListeners()
    }
  }

  updateTheme(event) {
    const theme = event.detail
    console.log(theme)

    import(`codemirror/theme/${theme}.css`)
      .then(() => this.setTheme(theme))
      .catch(console.error)
  }

  setTheme(theme) {
    this.codeMirror.setOption("theme", theme);
  }

  initializeCodeMirror() {
    this.codeMirror = CodeMirror.fromTextArea(this.mirrorTarget, {
      theme: 'one-dark',
      mode: "javascript",
      readOnly: this.readOnlyValue ? 'nocursor' : false,
      scrollbarStyle: "null"
    });

    this.initializedValue = true

    if (this.isCaptureValue) {
      document.querySelector(".CodeMirror")
        .classList.add('rounded-tr-md', 'rounded-tl-md', 'shadow-2xl')
    }
  }

  setCodeMirrorValue() {
    const value = this.hasCodeValue ? this.codeValue : "updateMode(event) {\n  const modeId = event.target.value\n  const mode = this.modeFromId(modeId)\n  const hasMode = Object.keys(CodeMirror.modes).includes(mode)\n\n  !hasMode ? this.importMode(mode) : this.setMode(mode)\n}\n\nsetMode(mode) {\n  this.codeMirror.setOption(\"mode\", mode);\n}"
    this.codeMirror.setValue(value)
  }

  updateMode(event) {
    const modeId = event.target.value
    
    this.importModeFromId(modeId)
  }

  importModeFromId(modeId) {
    const mode = this.modeFromId(modeId)
    const hasMode = Object.keys(CodeMirror.modes).includes(mode)

    !hasMode ? this.importMode(mode) : this.setMode(mode)
  }

  importMode(mode) {
    const path = mode.mode

    import(`codemirror/mode/${path}/${path}.js`)
      .then(() => this.setMode(mode))
      .catch(console.error)
  }

  setMode(mode) {
    this.codeMirror.setOption("mode", mode.mime);
  }

  modeFromId(modeId) {
    const dbMode = this.modesValue.find(mode => {
      return Number(mode.id) === Number(modeId)
    })

    return CodeMirror.modeInfo.find(mode => {
      return mode.name === dbMode.name
    })
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
