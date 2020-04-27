<template>
  <div class="create-snippet--wrapper">
    <tabs>
      <tab name="Write" :selected="true">
        <input type="text" placeholder="snippet description" v-model="snippetParams.description">
        <div style="display: flex; border: 1px solid lightgray; border-radius: 10px; height: 400px;">
          <div class="create-snippet--input-wrapper">
            <textarea :value="snippetParams.body" @input="updateMarkdown"></textarea>
          </div>
          <div class="create-snippet--markdown-wrapper" >
            <div class="create-snippet--markdown-container" v-html="compiledMarkdown"></div>
          </div>
        </div>
        <div class="create-snippet--options-wrapper">
          <input v-model="snippetParams.public" type="radio" id="public" name="public" value="true" checked="checked">
          <label for="public">public</label>
          <input v-model="snippetParams.public" type="radio" id="private" name="public" value="false">
          <label for="private">private</label>
          <select v-model="snippetParams.language_id">
            <option v-for="language in languages" :key="language.id" :value="language.id">{{ language.name }}</option>
          </select>
          <button @click="createSnippet">
            create snippet
          </button>
        </div>
      </tab>
      <tab name="Preview">

      </tab>
    </tabs>
  </div>
</template>

<script>
import marked from 'marked';
import _ from 'lodash';
import axios from 'axios'

import Tabs from './tabs'
import Tab from './tab'

export default {
  components: { Tabs, Tab },

  props: {
    languages: { type: Array, required: true }
  },

  data: function () {
    return {
      snippetParams: {
        description: '',
        body: '# create a snippet',
        language_id: this.languages[0].id,
        public: true
      }
    }
  },

  computed: {
    compiledMarkdown() {
      return marked(this.snippetParams.body)
    }
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

.create-snippet--options-wrapper {
  display: flex;
  justify-content: flex-end;
}

.create-snippet--wrapper {
  display: flex;
  flex-direction: column;
  width: 100%;
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
