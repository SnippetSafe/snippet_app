<template>
  <div class="create-snippet--wrapper">
    <tabs>
      <tab name="Write" :selected="true">
        <input class="new-snippet--description" type="text" placeholder="Snippet description..." v-model="snippetParams.description">
        <div style="display: flex; border: 1px solid lightgray; border-radius: 10px; height: 400px;">
          <div class="create-snippet--input-wrapper">
            <textarea :value="snippetParams.body" @input="updateMarkdown"></textarea>
          </div>
        </div>
      </tab>
      <tab name="Preview">
        <code-highlight
          ref="codeHighlight"
          :code="snippetParams.body"
          :language="snippetParams.language">
        </code-highlight>
      </tab>
      <div class="create-snippet--options-wrapper">
        <input v-model="snippetParams.public" type="radio" id="public" name="public" value="true" checked="checked">
        <label for="public">public</label>
        <input v-model="snippetParams.public" type="radio" id="private" name="public" value="false">
        <label for="private">private</label>
        <select v-model="snippetParams.language">
          <option v-for="language in languages" :key="language" :value="language">{{ language }}</option>
        </select>
        <button class="button--cta-new" @click="createSnippet">
          CREATE
        </button>
      </div>
    </tabs>
  </div>
</template>

<script>
// import * as whatever from './highlight.pack.js';
import marked from 'marked';
import _ from 'lodash';
import axios from 'axios'

import Tabs from './tabs'
import Tab from './tab'
import CodeHighlight from './code-highlight'

export default {
  components: { Tabs, Tab, CodeHighlight },

  data: function () {
    console.log(this.$refs.codeHighlight)
    return {
      snippetParams: {
        description: '',
        body: 'create a snippet',
        highlighted_body: 'create a snippet',
        language: 'ruby',
        public: true
      },
      languages: hljs.listLanguages()
    }
  },

  computed: {
    compiledMarkdown() {
      return marked(this.snippetParams.body)
    },

    highlightedBody() {
      if (this.$refs.codeHighlight) {
        return this.$refs.codeHighlight.highlightedCode
      } else {
        return 'create a snippet'
      }
    }
  },

  mounted() {
    this.$watch(() => this.$refs.codeHighlight.highlightedCode, (value) => { this.snippetParams.highlighted_body = value;})
  },

  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  },

  methods: {
    updateMarkdown: _.debounce(function(e) {
      this.snippetParams.body = e.target.value;
    }, 300),

    createSnippet() {
      console.log('snippet params', this.snippetParams)

      axios.post('/snippets?ajax=true', { snippet: this.snippetParams })
        .then(res => {
          console.log(res)
          const snippet = res.data.snippet

          this.$parent.$emit('close', snippet)
        })
        .catch(console.error)
    }
  }
}
</script>

<style lang="scss" scoped>

.new-snippet {
  &--description {
    width: 100%;
    box-sizing: border-box;
    padding: 6px;
    border-radius: 4px;
    border: 1px solid lightgrey;
    margin: 16px 0px;
    font-size: 14px;
  }
}

.create-snippet--options-wrapper {
  display: flex;
  justify-content: flex-end;
  margin-top: 16px;
}

.create-snippet--wrapper {
  display: flex;
  flex-direction: column;
  padding: 16px;
  border-radius: 4px;
  background-color: white;
  margin: 16px 0px;
}

textarea {
  display: inline-block;
  font-family: "Monaco", courier, monospace;
  color: #333;
  resize: none;
  padding: 0;
  border: none;
  width: 100%;
  height: 100%;
}

textarea:focus {
  outline: 0;
}

.create-snippet--input-wrapper {
  flex: 1;
  margin: 16px;
}

.create-snippet--markdown-wrapper {
  flex: 1;
}

.create-snippet--markdown-container {
  overflow: auto;
  margin: 0px 16px 16px 16px;
}

/* pre {
  background-color: lightgrey;
  overflow: auto;
  padding: 16px;
  border-radius: 5px;
  font-size: 13px;
} */
</style>
