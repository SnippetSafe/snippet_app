<template>
  <div class="create-snippet--wrapper">
    <div style="display: flex;">
      <div>
        <h3 style="margin-left: 16px;">Create Snippet</h3>
      </div>
    </div>
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
      <button @click="createSnippet">
        create snippet
      </button>
    </div>
  </div>
</template>

<script>
import marked from 'marked';
import _ from 'lodash';
import axios from 'axios'

export default {
  data: function () {
    return {
      snippetParams: {
        description: '',
        body: '# create a snippet',
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

      axios.post('/snippets', { snippet: this.snippetParams })
        .then(res => {
          console.log(res)
        })
        .catch(console.error)
    }
  }
}
</script>

<style>
.create-snippet--options-wrapper {
  display: flex;
  justify-content: flex-end;
}

.create-snippet--wrapper {
  display: flex;
  flex-direction: column;
  position: absolute;
  top: 50%;
  margin-top: -300px;
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

pre {
  background-color: lightgrey;
  overflow: auto;
  padding: 16px;
  border-radius: 10px;
  font-size: 13px;
}
</style>
