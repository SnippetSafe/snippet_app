<template>
  <div class="create-snippet--wrapper">
    <tabs title="New Snippet">
      <div>
        <ul v-if="errors" style="border: 1px solid #f99595; font-weight: 100; padding: 6px; list-style-position:inside; border-radius: 2px; background-color: #f9bbbb;">
          <li v-for="error in errors" :key="error">{{ error }}</li>
        </ul>
        <tab name="Write" :selected="true">
          <input class="new-snippet--description" type="text" placeholder="Snippet description..." v-model="snippetParams.description">
          <textarea class="new-snippet--body" :value="snippetParams.body" @input="updateBody" placeholder="Snippet body..."></textarea>
        </tab>
        <tab name="Preview">
          <code-highlight
            class="margin-top"
            ref="codeHighlight"
            :raw-code="snippetParams.body"
            :language="snippetParams.language">
          </code-highlight>
        </tab>
      </div>
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
    return {
      snippetParams: {
        description: '',
        body: '',
        highlighted_body: '???',
        language: 'ruby',
        public: true
      },
      languages: hljs.listLanguages(),
      errors: null
    }
  },

  computed: {
    compiledMarkdown() {
      return marked(this.snippetParams.body)
    },
  },

  mounted() {
    this.$watch(() => this.$refs.codeHighlight.highlighted, (value) => {
      this.snippetParams.highlighted_body = value;
    })
  },

  created() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  },

  methods: {
    updateBody: _.debounce(function(e) {
      this.snippetParams.body = e.target.value;
    }, 300),

    createSnippet() {
      console.log('snippet params', this.snippetParams)

      axios.post('/snippets?ajax=true', { snippet: this.snippetParams })
        .then(res => {
          console.log(res)
          const snippet = res.data.snippet

          // this.$parent.$emit('close', snippet)
          window.location.href = '/';
        })
        .catch(error => {
          console.error(error)

          this.errors = error.response.data.errors
        })
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
    border-radius: 2px;
    border: 1px solid lightgrey;
    margin: 16px 0px;
    font-size: 14px;
    display: block;
  }

  &--body {
    display: flex;
    padding: 6px;
    border: 1px solid lightgray;
    border-radius: 2px;
    height: 400px;
    width: 100%;
    box-sizing: border-box;
    resize: vertical;
    font-size: 14px;
    font-family: Roboto Mono,Menlo,Consolas,monospace;
  }
}

.create-snippet--options-wrapper {
  display: flex;
  justify-content: flex-end;
  margin-top: 16px;
}

.create-snippet--wrapper {
  // display: flex;
  // flex-direction: column;
  padding: 16px;
  border-radius: 2px;
  background-color: white;
  margin: 16px 0px;
}

// textarea {
//   display: inline-block;
//   font-family: "Monaco", courier, monospace;
//   color: #333;
//   padding: 0;
//   height: 100%;
// }

// textarea:focus {
//   outline: 0;
// }

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
