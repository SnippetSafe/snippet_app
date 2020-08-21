import { Controller } from 'stimulus'
import axios from 'axios'

export default class extends Controller {
  static targets = ['entries', 'pagination']

  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken
  }

  scroll() {
    let nextPage = this.paginationTarget.querySelector("a[rel='next']")

    if (!nextPage) { return }

    let url = nextPage.href

    let body = document.body
    let html = document.documentElement

    let height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight)

    if (window.pageYOffset >= (height - window.innerHeight)) {
      console.log('bottom')
      this.loadMore(url)
    }
  }

  loadMore(url) {
    axios.get(url, { headers: { 'accept': 'application/json' } })
      .then(res => {
        let entriesString = res.data.entries
      
        this.entriesTarget.insertAdjacentHTML('beforeend', entriesString)
        this.paginationTarget.innerHTML = res.data.pagination

        document.querySelectorAll('pre code').forEach((block) => {
          hljs.highlightBlock(block);
        });
      })
      .catch(console.error)
  }
}
