import { Controller } from 'stimulus'
import axios from 'axios'

export default class extends Controller {
  static targets = ['entries', 'pagination', 'input', 'form']

  initialize() {
    const csrfToken = document.querySelector("meta[name=csrf-token]").content
    axios.defaults.headers.common['X-CSRF-Token'] = csrfToken

    this.isLoadingMore = false

    if (this.hasInputTarget) { this.inputTarget.focus() };
  }

  search = _.debounce(function(event) {
    this.isLoadingMore = true

    axios.get(this.baseUrl, { params: { search: event.target.value }, headers: { 'accept': 'application/json' } })
      .then(res => {
        let entriesString = res.data.entries
      
        this.entriesTarget.innerHTML = entriesString
        this.paginationTarget.innerHTML = res.data.pagination

        this.isLoadingMore = false
      })
      .catch(console.error)
  }, 400)

  add(event) {
    this.entriesTarget.insertAdjacentHTML('afterbegin', event.detail)
  }

  update(event) {
    const id = new DOMParser().parseFromString(event.detail, "text/xml").firstChild.id 
    const listItem = document.getElementById(id)

    if (listItem) { listItem.outerHTML = event.detail }
  }

  scroll() {
    console.log('yah')
    if (this.shouldLoadMore()) { this.loadMore() }
  }

  loadMore() {
    this.isLoadingMore = true

    axios.get(this.nextPageUrl, { headers: { 'accept': 'application/json' } })
      .then(res => {
        let entriesString = res.data.entries
      
        this.entriesTarget.insertAdjacentHTML('beforeend', entriesString)
        this.paginationTarget.innerHTML = res.data.pagination

        document.querySelectorAll('pre code').forEach((block) => {
          hljs.highlightBlock(block)
        })

        this.isLoadingMore = false
      })
      .catch(console.error)
  }

  shouldLoadMore() {
    return this.nextPageAnchor && this.hasReachedScrollTrigger() && !this.isLoadingMore
  }

  hasReachedScrollTrigger() {
    const body = document.body
    const html = document.documentElement
    const height = Math.max(body.scrollHeight, body.offsetHeight, html.clientHeight, html.scrollHeight, html.offsetHeight)

    return (window.pageYOffset >= (height - window.innerHeight - 80))
  }

  get nextPageAnchor() {
    return this.paginationTarget.querySelector("a[rel='next']")
  }

  get nextPageUrl() {
    return this.nextPageAnchor.href
  }

  get baseUrl() {
    return this.data.get('baseUrl')
  }
}
