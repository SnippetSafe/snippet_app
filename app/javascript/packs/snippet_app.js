/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

// import Vue from 'vue'
// import App from '../app.vue'

// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     render: h => h(App)
//   }).$mount()
//   document.body.appendChild(app.$el)

//   console.log(app)
// })


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'

// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the project is using turbolinks, install 'vue-turbolinks':
//
// yarn add vue-turbolinks
//
// Then uncomment the code block below:

var infiniteScroll =  require('vue-infinite-scroll');

//
import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue/dist/vue.esm'

import { store } from '../store.js';

import ActionIcon from '../action-icon';
import Alert from '../alert';
import UserAvatar from '../user-avatar';
import Card from '../card';
import EditAvatar from '../edit-avatar';
import EditProfile from '../edit-profile';
import Modal from '../modal.vue'
import NewSnippet from '../new-snippet.vue'
import NewSnippetButton from '../new-snippet-button.vue'
import Popover from '../popover.vue';
import Sidebar from '../sidebar.vue'
import Tabs from '../tabs.vue';
import Tab from '../tab.vue';
import UserPreview from '../user-preview.vue';
import UserProfile from '../user-profile.vue'
import CodeHighlight from '../code-highlight.vue';

Vue.use(TurbolinksAdapter)
Vue.use(infiniteScroll)


document.addEventListener('DOMContentLoaded', () => {
  
  //TODO: remove this as it causes to page load slower - use a user component instead!
  (function (appElement) {

    const app = new Vue({
      el: '#vue-app',
      store,
      components: {
        ActionIcon,
        Alert,
        UserAvatar,
        Card,
        EditAvatar,
        CodeHighlight,
        EditProfile,
        Modal,
        NewSnippet,
        NewSnippetButton,
        Popover,
        Sidebar,
        Tab,
        Tabs,
        UserPreview,
        UserProfile
      },

      created() {
        if (appElement.dataset.user) {
          const currentUser = JSON.parse(appElement.dataset.user);

          this.$store.commit('setCurrentUser', currentUser)
        }
      }
    })

  })(document.getElementById('vue-app'));

})
